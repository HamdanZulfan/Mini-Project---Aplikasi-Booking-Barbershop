import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class LokasiScreen extends StatefulWidget {
  const LokasiScreen({Key? key}) : super(key: key);

  @override
  State<LokasiScreen> createState() => _LokasiScreenState();
}

class _LokasiScreenState extends State<LokasiScreen> {
  late Position userLocation;
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<Position> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    userLocation = await Geolocator.getCurrentPosition();
    return userLocation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: _getLocation(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return GoogleMap(
                mapType: MapType.normal,
                onMapCreated: _onMapCreated,
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    userLocation.latitude,
                    userLocation.longitude,
                  ),
                  zoom: 15,
                ),
                markers: {
                  captainMarker,
                  kolegaMarker,
                  shortcutMarker,
                  joeMarker,
                  luxeMarker,
                  bronzeMarker,
                  bloomMarker,
                  cleverMarker,
                },
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

Marker captainMarker = Marker(
  markerId: const MarkerId('Captain Barbershop'),
  position: const LatLng(-6.325526434549715, 106.78507708481317),
  infoWindow: const InfoWindow(title: 'Captain Barbershop'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);

Marker kolegaMarker = Marker(
  markerId: const MarkerId('Kolega BarberShop'),
  position: const LatLng(-6.4080849739214685, 106.81784719646039),
  infoWindow: const InfoWindow(title: 'Kolega BarberShop'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);

Marker shortcutMarker = Marker(
  markerId: const MarkerId('Shortcut Barbershop'),
  position: const LatLng(-6.3797396355667395, 106.84503061180152),
  infoWindow: const InfoWindow(title: 'Shortcut Barbershop'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);

Marker joeMarker = Marker(
  markerId: const MarkerId('Joe Babershop'),
  position: const LatLng(-6.40422841516467, 106.84610290754553),
  infoWindow: const InfoWindow(title: 'Joe Babershop'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);

Marker luxeMarker = Marker(
  markerId: const MarkerId('Luxe Barbershop'),
  position: const LatLng(-6.388722751251908, 106.83875379646013),
  infoWindow: const InfoWindow(title: 'Luxe Barbershop'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);

Marker bronzeMarker = Marker(
  markerId: const MarkerId('Bronze Barbershop'),
  position: const LatLng(-6.373208382278983, 106.8324827964599),
  infoWindow: const InfoWindow(title: 'Bronze Barbershop'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);

Marker bloomMarker = Marker(
  markerId: const MarkerId('Bloom Barbershop'),
  position: const LatLng(-6.400954789990525, 106.85100725413103),
  infoWindow: const InfoWindow(title: 'Bloom Barbershop'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);

Marker cleverMarker = Marker(
  markerId: const MarkerId('Clever Barbershop'),
  position: const LatLng(-6.405005158034348, 106.84299008111883),
  infoWindow: const InfoWindow(title: 'Clever Barbershop'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
