import 'package:geolocator/geolocator.dart';

class LocationService {
  // Hardcoded stores in Kingston, Jamaica for MVP
  // Coordinates are approximate
  static final List<StoreLocation> _monitoredStores = [
    StoreLocation(
      name: 'MegaMart Kingston',
      latitude: 18.0179,
      longitude: -76.7905,
    ),
    StoreLocation(
      name: 'Sovereign Centre',
      latitude: 18.0205,
      longitude: -76.7690,
    ),
    StoreLocation(
      name: 'Hi-Lo Barbican',
      latitude: 18.0312,
      longitude: -76.7725,
    ),
    StoreLocation(
      name: 'PriceSmart Red Hills',
      latitude: 18.0423,
      longitude: -76.8152,
    ),
    StoreLocation(name: 'Super Valu', latitude: 18.0125, longitude: -76.7995),
  ];

  /// Request permissions and get current position
  Future<Position?> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null; // Location services are disabled.
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null; // Permissions are denied
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null; // Permissions are denied forever
    }

    return await Geolocator.getCurrentPosition();
  }

  /// Check if user is near any monitored store (within 200m)
  Future<String?> checkStoreProximity() async {
    final position = await getCurrentPosition();
    if (position == null) return null;

    for (final store in _monitoredStores) {
      final distanceInMeters = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        store.latitude,
        store.longitude,
      );

      // Threshold: 200 meters
      if (distanceInMeters <= 200) {
        return store.name;
      }
    }

    return null;
  }
}

class StoreLocation {
  final String name;
  final double latitude;
  final double longitude;

  StoreLocation({
    required this.name,
    required this.latitude,
    required this.longitude,
  });
}
