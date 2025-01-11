import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart';
import '../core/base/base_controller.dart';
import 'package:flutter_map/flutter_map.dart';

class LocationController extends BaseController {
  final currentLocation = const LatLng(-6.2088, 106.8456).obs;
  final address = ''.obs;
  final currentZoom = 15.0.obs;
  final loc.Location location = loc.Location();
  final mapController = MapController();
  var isMapReady = false;

  @override
  void onInit() {
    super.onInit();
    _initLocation();
  }

  Future<void> _initLocation() async {
    try {
      await location.changeSettings(
        accuracy: loc.LocationAccuracy.high,
        interval: 1000,
      );
      
      _checkLocationPermission();
    } catch (e) {
      print('Error initializing location: $e');
      showError('Cannot initialize location service'.tr);
    }
  }

  void onMapCreated(MapController controller) {
    isMapReady = true;
    getCurrentLocation(); // Chỉ gọi getCurrentLocation sau khi map đã sẵn sàng
  }

  Future<void> _checkLocationPermission() async {
    try {
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          showError('Please enable location service'.tr);
          return;
        }
      }

      var permissionGranted = await location.hasPermission();
      if (permissionGranted == loc.PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != loc.PermissionStatus.granted) {
          showError('Need to grant location access.'.tr);
          return;
        }
      }

      // Không gọi getCurrentLocation ở đây nữa
      // Nó sẽ được gọi trong onMapCreated
    } catch (e) {
      print('Error checking permissions: $e'.tr);
      showError('Cannot check permissions'.tr);
    }
  }

  Future<void> getCurrentLocation() async {
    if (!isMapReady) return; // Kiểm tra map đã sẵn sàng chưa
    
    try {
      showLoading();
      
      final locationData = await location.getLocation();
      if (locationData.latitude == null || locationData.longitude == null) {
        throw Exception('Cannot retrieve coordinates'.tr);
      }
      
      final newLocation = LatLng(
        locationData.latitude!,
        locationData.longitude!
      );
      currentLocation.value = newLocation;
      
      try {
        mapController.move(newLocation, currentZoom.value);
      } catch (e) {
        print('Error moving map: $e'.tr);
      }

      final placemarks = await placemarkFromCoordinates(
        locationData.latitude!,
        locationData.longitude!,
      );
      
      if (placemarks.isNotEmpty) {
        final place = placemarks[0];
        final List<String> addressParts = [];
        
        if (place.street?.isNotEmpty == true) addressParts.add(place.street!);
        if (place.subLocality?.isNotEmpty == true) addressParts.add(place.subLocality!);
        if (place.locality?.isNotEmpty == true) addressParts.add(place.locality!);
        if (place.postalCode?.isNotEmpty == true) addressParts.add(place.postalCode!);
        
        address.value = addressParts.join(', ');
      }

      hideLoading();
    } catch (e) {
      hideLoading();
      print('Error getting location: $e');
      showError('Cannot get current location.'.tr);
    }
  }

  void zoomIn() {
    if (!isMapReady) return;
    final newZoom = currentZoom.value + 1;
    if (newZoom <= 18) {
      currentZoom.value = newZoom;
      try {
        mapController.move(currentLocation.value, newZoom);
      } catch (e) {
        print('Error zooming in: $e');
      }
    }
  }

  void zoomOut() {
    if (!isMapReady) return;
    final newZoom = currentZoom.value - 1;
    if (newZoom >= 3) {
      currentZoom.value = newZoom;
      try {
        mapController.move(currentLocation.value, newZoom);
      } catch (e) {
        print('Error zooming out: $e');
      }
    }
  }
} 