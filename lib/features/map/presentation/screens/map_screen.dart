// lib/features/map/presentation/screens/map_test_screen.dart
import 'dart:math';

import 'package:cms/core/constants/assets.dart';
import 'package:cms/core/constants/font_heading.dart';
import 'package:cms/core/entities/clinic.dart';
import 'package:cms/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:permission_handler/permission_handler.dart';

class MapScreen extends StatefulWidget {
  static const routeName = '/map-test';
  final Clinic? clinic;

  const MapScreen({super.key, this.clinic});

  @override
  State<MapScreen> createState() => _MapTestScreenState();
}

class _MapTestScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;
  late LatLng _initialPosition = const LatLng(33.5138, 36.2765); // fallback
  final Set<Marker> _markers = {};

  Position? _userLocation;
  List<Clinic> _filteredClinics = [];
  double _radius = 5.0; // Default 5 km

  // Full clinic list (replace with real data later)
  final List<Clinic> _allClinics = [
    Clinic(
      id: '1',
      name: 'Some name clinic',
      specialty: 'Dentist',
      location: 'Damascus, Al-Mazzeh',
      hours: '9:00 AM - 5:00 PM',
      latitude: 33.5138,
      longitude: 36.2765,
      rating: 4.5,
      isSaved: true,
    ),
    Clinic(
      id: '2',
      name: 'Some name clinic',
      specialty: 'Dentist',
      location: 'Damascus, Al-Mazzeh',
      hours: '8:00 AM - 5:00 PM',
      latitude: 33.5200,
      longitude: 36.2800,
      rating: 4.5,
      isSaved: false,
    ),
    Clinic(
      id: '3',
      name: 'Some name clinic',
      specialty: 'Dentist',
      location: 'Damascus, Al-Mazzeh',
      hours: '9:30 AM - 5:00 PM',
      latitude: 33.5160,
      longitude: 36.2780,
      rating: 4.5,
      isSaved: true,
    ),
    Clinic(
      id: '4',
      name: 'Some name clinic',
      specialty: 'Dentist',
      location: 'Damascus, Al-Mazzeh',
      hours: '8:30 AM - 4:30 PM',
      latitude: 33.5080,
      longitude: 36.2850,
      rating: 4.5,
      isSaved: false,
    ),
    Clinic(
      id: '5',
      name: 'Some name clinic',
      specialty: 'Dentist',
      location: 'Damascus, Al-Mazzeh',
      hours: '10:00 AM - 6:00 PM',
      latitude: 33.5220,
      longitude: 36.2820,
      rating: 4.5,
      isSaved: true,
    ),
    Clinic(
      id: '6',
      name: 'Some name clinic',
      specialty: 'Dentist',
      location: 'Damascus, Al-Mazzeh',
      hours: '9:00 AM - 5:00 PM',
      latitude: 33.5100,
      longitude: 36.2700,
      rating: 4.5,
      isSaved: false,
    ),
    Clinic(
      id: '7',
      name: 'Some name clinic',
      specialty: 'Dentist',
      location: 'Damascus, Al-Mazzeh',
      hours: '8:00 AM - 5:00 PM',
      latitude: 33.5250,
      longitude: 36.2750,
      rating: 4.5,
      isSaved: true,
    ),
  ];

  // ---- Lifecycle ----
  @override
  void initState() {
    super.initState();
    _loadLocationAndClinics();
  }

  // ---- Load location and filter clinics ----
  Future<void> _loadLocationAndClinics() async {
    bool hasPermission = await requestLocationPermission();
    if (!hasPermission) {
      // Use default location
      _useDefaultLocation();
      return;
    }

    Position? position = await getCurrentLocation();
    if (position == null) {
      // Use default location
      _useDefaultLocation();
      return;
    }

    setState(() {
      _userLocation = position;
      _initialPosition = LatLng(position.latitude, position.longitude);
      _filteredClinics = filterClinicsByRadius(
        allClinics: _allClinics,
        userLocation: position,
        radiusInKm: _radius,
      );
      _updateMarkers();
      _moveCameraToUser();
    });
  }

  void _useDefaultLocation() {
    const double defaultLat = 33.5138;
    const double defaultLon = 36.2765;
    setState(() {
      _initialPosition = LatLng(defaultLat, defaultLon);
      // Show all clinics (no filtering)
      _filteredClinics = List.from(_allClinics);
      _updateMarkers();
      // Move camera to default location
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _mapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(defaultLat, defaultLon), zoom: 12.0),
          ),
        );
      });
    });
  }

  void _updateMarkers() {
    _markers.clear();
    for (var clinic in _filteredClinics) {
      _markers.add(
        Marker(
          markerId: MarkerId(clinic.id),
          position: LatLng(clinic.latitude, clinic.longitude),
          infoWindow: InfoWindow(
            title: clinic.name,
            snippet: '${clinic.specialty} - ${clinic.location}',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );
    }
  }

  void _moveCameraToUser() {
    if (_userLocation == null) return;
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(_userLocation!.latitude, _userLocation!.longitude),
          zoom: 14.0,
        ),
      ),
    );
  }

  // ---- Distance helpers ----
  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371; // km
    double dLat = _toRadians(lat2 - lat1);
    double dLon = _toRadians(lon2 - lon1);
    double a =
        _haversine(dLat) +
        cos(_toRadians(lat1)) * cos(_toRadians(lat2)) * _haversine(dLon);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  double _toRadians(double degrees) => degrees * pi / 180.0;
  double _haversine(double angle) => pow(sin(angle / 2), 2).toDouble();

  List<Clinic> filterClinicsByRadius({
    required List<Clinic> allClinics,
    required Position userLocation,
    required double radiusInKm,
  }) {
    return allClinics.where((clinic) {
      double distance = calculateDistance(
        userLocation.latitude,
        userLocation.longitude,
        clinic.latitude,
        clinic.longitude,
      );
      return distance <= radiusInKm;
    }).toList();
  }

  // ---- Permissions & Location ----
  // Remove the permission_handler import and usage.
  // Use Geolocator for both permissions and location.

  Future<bool> requestLocationPermission() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return false;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return false;
      }
      return true;
    } catch (e) {
      print('⚠️ Location permission error: $e');
      return false; // Fallback: assume permission is not granted
    }
  }

  Future<Position?> getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print('⚠️ Location services disabled');
        return null;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return null;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return null;
      }

      return await Geolocator.getCurrentPosition();
    } catch (e) {
      print('⚠️ Error getting location: $e');
      return null; // Return null so we can fall back to default
    }
  }

  // ---- UI ----
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // ---- Map ----
          GoogleMap(
            onMapCreated: (controller) => _mapController = controller,
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 15.0,
            ),
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: false,
            mapType: MapType.normal,
          ),
          // ---- Blue Header ----
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildBlueHeader(context),
          ),
          // ---- Radius Chip (non‑intrusive) ----
          Positioned(
            bottom: 200, // just above the clinic slider
            right: 16,
            child: _buildRadiusChip(context),
          ),
          // ---- Floating Clinics Slider ----
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildFloatingSlider(context),
          ),
        ],
      ),
    );
  }

  // ---- Blue Header (Search + Filter) ----
  Widget _buildBlueHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        color: AppColors.main_background_blue,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                // Navigate to SearchScreen
              },
              child: Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: AppColors.black, size: 24),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Search clinics, doctors...',
                        style: FontHeading.bodySmall.copyWith(
                          color: AppColors.customGray,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () => print('Filter pressed'),
              icon: Icon(
                Icons.filter_list,
                color: AppColors.main_background_blue,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---- Radius Chip (floating, shows current radius) ----
  Widget _buildRadiusChip(BuildContext context) {
    return GestureDetector(
      onTap: () => _showRadiusBottomSheet(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(9),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              FontAwesomeIcons.mapPin,
              color: AppColors.main_background_blue,
              size: 16,
            ),
            const SizedBox(width: 6),
            Text(
              '${_radius.toInt()} KM',
              style: FontHeading.bodySmall.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.customGray,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  // ---- Bottom sheet for radius slider ----
  void _showRadiusBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        double localRadius = _radius;
        return StatefulBuilder(
          builder: (context, setStateSheet) {
            return Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.customGray,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Search radius',
                    style: FontHeading.heading4.copyWith(color: Colors.black),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Slider(
                          min: 1,
                          max: 20,
                          divisions: 19,
                          value: localRadius,
                          onChanged: (value) {
                            setStateSheet(() {
                              localRadius = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        '${localRadius.toInt()} KM',
                        style: FontHeading.body.copyWith(
                          color: AppColors.main_background_blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _radius = localRadius;
                          if (_userLocation != null) {
                            _filteredClinics = filterClinicsByRadius(
                              allClinics: _allClinics,
                              userLocation: _userLocation!,
                              radiusInKm: _radius,
                            );
                            _updateMarkers();
                          }
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.main_background_blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Apply'),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // ---- Floating Clinics Slider ----
  Widget _buildFloatingSlider(BuildContext context) {
    if (_filteredClinics.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 190,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _filteredClinics.length,
        itemBuilder: (context, index) {
          final clinic = _filteredClinics[index];
          return RepaintBoundary(
            child: GestureDetector(
              onTap: () {
                // Navigate to ClinicDetailScreen
              },
              child: Container(
                width: 180,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(16),
                            ),
                            child: Image.asset(
                              Assets.assetsImagesClinicPlaceholder,
                              width: 180,
                              height: 110,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 6,
                            right: 6,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                              ),
                              child: Icon(
                                Icons.bookmark,
                                color: clinic.isSaved
                                    ? AppColors.main_background_blue
                                    : AppColors.CustomgrayDark,
                                size: 16,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 6,
                            left: 6,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(117),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    clinic.rating.toString(),
                                    style: FontHeading.caption.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow.shade600,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 6,
                            right: 6,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(117),
                              ),
                              child: Text(
                                clinic.specialty,
                                style: FontHeading.caption.copyWith(
                                  color: Colors.black,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        clinic.name,
                        style: FontHeading.body.copyWith(color: Colors.black),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: AppColors.CustomgrayDark,
                            size: 16,
                          ),
                          const SizedBox(width: 2),
                          Expanded(
                            child: Text(
                              clinic.location,
                              style: FontHeading.bodySmall.copyWith(
                                color: AppColors.CustomgrayDark,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Row(
                        children: [
                          Icon(
                            Icons.access_time_outlined,
                            color: AppColors.CustomgrayDark,
                            size: 16,
                          ),
                          const SizedBox(width: 2),
                          Expanded(
                            child: Text(
                              clinic.hours,
                              style: FontHeading.bodySmall.copyWith(
                                color: AppColors.CustomgrayDark,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
