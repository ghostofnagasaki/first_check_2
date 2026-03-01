import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import '../../features/cart/models/cart_item.dart';

class OcrService {
  final _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  Future<List<CartItem>> parseReceipt(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final RecognizedText recognizedText = await _textRecognizer.processImage(
      inputImage,
    );

    return _extractItemsFromText(recognizedText);
  }

  List<CartItem> _extractItemsFromText(RecognizedText recognizedText) {
    List<CartItem> items = [];

    // Regex to find lines ending with a price (e.g., "Milk 250.00" or "Bread $400")
    // Matches: Any text (group 1) + space + optional currency symbol + number with decimal (group 2)
    final priceRegex = RegExp(r'(.+?)\s+[\$]?(\d+\.\d{2})');

    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        final text = line.text;
        final match = priceRegex.firstMatch(text);

        if (match != null) {
          final name = match.group(1)?.trim() ?? 'Unknown Item';
          final priceString = match.group(2);

          if (priceString != null) {
            final price = double.tryParse(priceString);
            if (price != null) {
              // Heuristic: Ignore lines that look like dates or tiny numbers
              if (name.length > 3) {
                items.add(
                  CartItem.create(name: name, price: price, quantity: 1),
                );
              }
            }
          }
        }
      }
    }

    return items;
  }

  void dispose() {
    _textRecognizer.close();
  }
}
