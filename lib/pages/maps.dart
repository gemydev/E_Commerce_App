import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationMap extends StatefulWidget {
  double latitude;
  double longitude;

  LocationMap({@required this.latitude, @required this.longitude});

  @override
  _LocationMapState createState() => _LocationMapState();
}

class _LocationMapState extends State<LocationMap> {
  @override
  Widget build(BuildContext context) {
    List<Marker> markers = [
      Marker(
          position: LatLng(widget.latitude, widget.longitude),
          markerId: MarkerId("CurrentLocation")),
    ];
    return Scaffold(
      body: GoogleMap(
        markers: Set.from(markers),
        initialCameraPosition: CameraPosition(
            target: LatLng(widget.latitude, widget.longitude), zoom: 10.0),
        mapType: MapType.hybrid,
      ),
    );
  }
}
