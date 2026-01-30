import 'package:bio_app/providers/location_provider.dart';
import 'package:bio_app/providers/uploaded_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/prefs_config.dart';
import '../utils/get_location.dart';

// BitmapDescriptor customIcon = await BitmapDescriptor.asset(
// const ImageConfiguration(size: Size(48, 48)),
// 'assets/my_species_icon.png',
// );
Set<Marker> markerList = {
  Marker(
    markerId: MarkerId("1"),
    position: LatLng(25.00024226928204, 121.48749241419253),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
  ),
  Marker(
    markerId: MarkerId("2"),
    position: LatLng(24.998591774151674, 121.48684325256228),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
  ),
  Marker(
    markerId: MarkerId("3"),
    position: LatLng(24.999846882876795, 121.48512008735838),
  ),
  Marker(
    markerId: MarkerId("4"),
    position: LatLng(24.99675069441381, 121.48689698733172),
  ),
  Marker(
    markerId: MarkerId("5"),
    position: LatLng(25.00222025921649, 121.48904812394206),
  ),
  Marker(
    markerId: MarkerId("6"),
    position: LatLng(24.99886268780056, 121.48395579051615),
  ),
};
class NearbySpeciesView extends ConsumerWidget {
  const NearbySpeciesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final position = ref.watch(locationProvider);

    return position.when(
        data: (res) {
          return NearbySpecies();
        },
        loading: () =>
            Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text("取得位置中...")
                  ],
                )),
        error: (err, st) {

          switch (err) {
            case DeterminePositionError.serviceDisabled:
              return Center(
                  child: Text("定位服務已關閉！請至設定開啟定位服務！"));
            case DeterminePositionError.deniedForever:
              return Center(
                  child: Text("位置權限已被拒絕！請至設定許可位置權限！"));
            case DeterminePositionError.denied:
              return Center(child: Text("請許可位置權限！"));
            default:
              return Center(child: Text("無法取得位置！"));
          }
        });
  }
}
class NearbySpecies extends ConsumerStatefulWidget {
  const NearbySpecies({super.key});

  @override
  ConsumerState<NearbySpecies> createState() => _NearbySpeciesState();
}

class _NearbySpeciesState extends ConsumerState<NearbySpecies> {
  static final CameraPosition _taiwan = CameraPosition(
    target: LatLng(23.973861, 120.982),
    zoom: 7.0,
  );

  GoogleMapController? _controller;
  CameraPosition? _initialPosition;

  @override
  void initState() {
    super.initState();
    _ensureLocationReady();
  }

  Future<void> _ensureLocationReady() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    final prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey(StorageKeys.currentLatitude) && prefs.containsKey(StorageKeys.currentLongitude)) {
      setState(() {
        _initialPosition = CameraPosition(
          target: LatLng(
            prefs.getDouble(StorageKeys.currentLatitude)!,
            prefs.getDouble(StorageKeys.currentLongitude)!,
          ),
          zoom: 16.0,
        );
      });
    } else {
      // Fallback to Taiwan default if nothing is saved
      setState(() {
        _initialPosition = _taiwan;
      });
    }
  }

  Future<void> _moveToCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition();
    if (!mounted || _controller == null) return;

    _controller!.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(position.latitude, position.longitude),
        16,
      ),
    );

    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble(StorageKeys.currentLatitude, position.latitude);
    prefs.setDouble(StorageKeys.currentLongitude, position.longitude);
  }

  // FILTER BUTTON
  Set<Marker> filteredMarkerList = markerList;
  var filterButtonBackgroundColor = Colors.white.withAlpha(150);
  var filterButtonOffImage = Image.asset('assets/images/filter_off.png',opacity: const AlwaysStoppedAnimation<double>(0.5),);
  var filterButtonOnImage = Image.asset('assets/images/filter_on.png');
  bool isFilterOn = false;
  late Image filterButtonImage = filterButtonOffImage;

  void onFilterButtonPressed() {
    if (!isFilterOn) {
      setState(() {
        filteredMarkerList = markerList.take(2).toSet();
        filterButtonBackgroundColor = Colors.white;
        filterButtonImage = filterButtonOnImage;
        isFilterOn = true;
      });
    } else {
      setState(() {
        filteredMarkerList = markerList.toSet();
        filterButtonBackgroundColor = Colors.white.withAlpha(150);
        filterButtonImage = filterButtonOffImage;
        isFilterOn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if(_initialPosition == null) return Center(child: Text("無法取得位置！"));
    final Set<Marker> resultList = filteredMarkerList;
    final storedList = ref.watch(uploadedListProvider);
    for (var element in storedList) {
      resultList.add(Marker(
        markerId: MarkerId(element.id),
        position: LatLng(element.latitude, element.longitude),
      ));
    }
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: _initialPosition!,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          onMapCreated: (controller) async {
            _controller = controller;
            await _moveToCurrentLocation();
          },
          markers: resultList,
        ),
        // FILTER BUTTON
        Positioned(
          top: 60,
          right: 11,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: filterButtonBackgroundColor,
              borderRadius: BorderRadius.circular(3),
              border: BoxBorder.all(color: Colors.grey, width: 0.2),
            ),
            alignment: Alignment.center,
            child: IconButton(
              onPressed: onFilterButtonPressed,
              icon: filterButtonImage,
            ),
          ),
        ),
      ],
    );
  }
}
