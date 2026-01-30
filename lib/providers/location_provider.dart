import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_provider.g.dart';

@riverpod
class LocationNotifier extends _$LocationNotifier {
  @override
  FutureOr<LatLng?> build() {
    return null;
  }

  /// 主動抓目前定位（由 UI 觸發）
  Future<void> fetchCurrentLocation() async {
    state = const AsyncLoading();

    try {
      final permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        throw Exception("Location permission denied");
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      state = AsyncData(LatLng(position.latitude, position.longitude));
    } catch (e, st) {
      state = const AsyncData(null);
    }
  }

  /// 地圖拖曳 / 點擊更新座標
  void updateLocation(LatLng latLng) {
    state = AsyncData(latLng);
  }
}
