import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../models/library_item.dart';
import 'dart:math' as math;

class ItemAnalyticsScreen extends StatelessWidget {
  final LibraryItem item;

  const ItemAnalyticsScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final history = List<PriceHistoryEntry>.from(item.priceHistory)
      ..sort((a, b) => a.date.compareTo(b.date));

    final List<FlSpot> spots = [];
    double minY = double.infinity;
    double maxY = double.negativeInfinity;
    DateTime? minDate;
    DateTime? maxDate;

    for (var i = 0; i < history.length; i++) {
      final entry = history[i];
      final price = entry.price;

      if (price < minY) minY = price;
      if (price > maxY) maxY = price;

      if (minDate == null || entry.date.isBefore(minDate)) {
        minDate = entry.date;
      }
      if (maxDate == null || entry.date.isAfter(maxDate)) {
        maxDate = entry.date;
      }
      spots.add(FlSpot(entry.date.millisecondsSinceEpoch.toDouble(), price));
    }

    if (minY == maxY) {
      if (minY == double.infinity) {
        minY = 0;
        maxY = 10;
      } else {
        minY -= 1;
        maxY += 1;
      }
    } else {
      final diff = maxY - minY;
      minY -= diff * 0.1;
      maxY += diff * 0.1;
    }

    final bottomInterval = _getBottomInterval(minDate, maxDate);
    final leftInterval = _getLeftInterval(minY, maxY);

    return Scaffold(
      appBar: AppBar(title: Text('${item.name} Analytics')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Category: ${item.category}\nCurrent Price: \$${item.price.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              if (spots.length < 2)
                const Expanded(
                  child: Center(
                    child: Text(
                      'Not enough data to show a chart yet.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                )
              else
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 16.0,
                      top: 16.0,
                      bottom: 16.0,
                    ),
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: true,
                          // The freezing was caused by these intervals being 1 on an X-axis representing milliseconds.
                          horizontalInterval: leftInterval,
                          verticalInterval: bottomInterval,
                        ),
                        titlesData: FlTitlesData(
                          show: true,
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 30,
                              interval: bottomInterval,
                              getTitlesWidget: (value, meta) {
                                if (value == meta.max || value == meta.min) {
                                  return const SizedBox.shrink(); // Hide min/max to avoid clipping
                                }
                                final date =
                                    DateTime.fromMillisecondsSinceEpoch(
                                      value.toInt(),
                                    );
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    DateFormat('MM/dd').format(date),
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurface,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: leftInterval,
                              reservedSize: 42,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  '\$${value.toStringAsFixed(1)}',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        borderData: FlBorderData(
                          show: true,
                          border: Border.all(
                            color: Colors.grey.withValues(alpha: 0.5),
                          ),
                        ),
                        minX: spots.first.x,
                        maxX: spots.last.x,
                        minY: minY < 0 ? 0 : minY,
                        maxY: maxY,
                        lineBarsData: [
                          LineChartBarData(
                            spots: spots,
                            isCurved: true,
                            color: Theme.of(context).colorScheme.primary,
                            barWidth: 3,
                            isStrokeCapRound: true,
                            dotData: const FlDotData(show: true),
                            belowBarData: BarAreaData(
                              show: true,
                              color: Theme.of(
                                context,
                              ).colorScheme.primary.withValues(alpha: 0.3),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  double _getBottomInterval(DateTime? min, DateTime? max) {
    if (min == null || max == null) return 86400000;
    final diff = max.millisecondsSinceEpoch - min.millisecondsSinceEpoch;
    if (diff == 0) return 86400000;
    return math.max((diff / 4).floorToDouble(), 1.0);
  }

  double _getLeftInterval(double min, double max) {
    final diff = max - min;
    if (diff == 0) return 1;
    return math.max((diff / 4), 0.1);
  }
}
