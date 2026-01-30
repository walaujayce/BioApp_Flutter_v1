import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapView extends StatefulWidget {
  final LatLng location;

  const GoogleMapView({super.key, required this.location});

  @override
  State<GoogleMapView> createState() => GoogleMapViewState();
}

class GoogleMapViewState extends State<GoogleMapView> {
  GoogleMapController? _controller;

  @override
  void didUpdateWidget(covariant GoogleMapView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (_controller != null &&
        widget.location != oldWidget.location) {
      _controller!.animateCamera(
        CameraUpdate.newLatLngZoom(widget.location, 16),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: widget.location,
        zoom: 16,
      ),
      onMapCreated: (controller) {
        _controller = controller;
      },
      markers: {
        Marker(
          markerId: const MarkerId("marker"),
          position: widget.location,
        ),
      },
      myLocationEnabled: true,
      gestureRecognizers: {
        Factory<OneSequenceGestureRecognizer>(
              () => EagerGestureRecognizer(),
        ),
      },
    );
  }
}


