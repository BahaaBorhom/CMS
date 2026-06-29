// lib/features/map/presentation/screens/map_test_screen.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cms/features/home/domain/entities/clinic.dart';

class MapTestScreen extends StatefulWidget {
  static const routeName = '/map-test';
  final Clinic? clinic;

  const MapTestScreen({super.key, this.clinic});

  @override
  State<MapTestScreen> createState() => _MapTestScreenState();
}

class _MapTestScreenState extends State<MapTestScreen> {
  late GoogleMapController _mapController;
  late LatLng _initialPosition;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();

    if (widget.clinic != null) {
      // Center on the passed clinic
      _initialPosition = LatLng(
        widget.clinic!.latitude,
        widget.clinic!.longitude,
      );
      _addClinicMarker(widget.clinic!);
    } else {
      // Default: Damascus
      _initialPosition = const LatLng(33.5138, 36.2765);
      _addSampleMarkers();
    }
  }

  void _addClinicMarker(Clinic clinic) {
    final marker = Marker(
      markerId: MarkerId(clinic.id),
      position: LatLng(clinic.latitude, clinic.longitude),
      infoWindow: InfoWindow(
        title: clinic.name,
        snippet: '${clinic.specialty} - ${clinic.location}',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueBlue,
      ),
    );
    setState(() {
      _markers.add(marker);
    });
  }

  void _addSampleMarkers() {
  final sampleClinics = [
    {
      'id': '1',
      'name': 'Al-Mazzeh Medical Center',
      'lat': 33.5138,
      'lng': 36.2765,
      'snippet': 'General Medicine - Damascus, Al-Mazzeh',
    },
    {
      'id': '2',
      'name': 'Heart Care Clinic',
      'lat': 33.5200,
      'lng': 36.2800,
      'snippet': 'Cardiology - Damascus, Al-Muhafaza',
    },
    {
      'id': '3',
      'name': 'Al-Mazzeh Dental Center',
      'lat': 33.5160,
      'lng': 36.2780,
      'snippet': 'Dentist - Damascus, Al-Mazzeh',
    },
  ];

  for (var c in sampleClinics) {
    final marker = Marker(
      markerId: MarkerId(c['id'] as String),           // ✅ cast to String
      position: LatLng(
        c['lat'] as double,                            // ✅ cast to double
        c['lng'] as double,                            // ✅ use 'lng' not 'long'
      ),
      infoWindow: InfoWindow(
        title: c['name'] as String?,                   // ✅ cast to String?
        snippet: c['snippet'] as String?,              // ✅ cast to String?
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueBlue,
      ),
    );
    _markers.add(marker);
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.clinic != null ? 'Clinic Location' : 'Nearby Clinics',
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          _mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: widget.clinic != null ? 15.0 : 12.0,
        ),
        markers: _markers,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
        mapType: MapType.normal,
      ),
    );
  }
}