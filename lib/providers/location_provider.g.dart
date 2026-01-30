// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LocationNotifier)
const locationProvider = LocationNotifierProvider._();

final class LocationNotifierProvider
    extends $AsyncNotifierProvider<LocationNotifier, LatLng?> {
  const LocationNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'locationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$locationNotifierHash();

  @$internal
  @override
  LocationNotifier create() => LocationNotifier();
}

String _$locationNotifierHash() => r'2731963283aa2b6819edad35e3c07a8ac2e6f376';

abstract class _$LocationNotifier extends $AsyncNotifier<LatLng?> {
  FutureOr<LatLng?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<LatLng?>, LatLng?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<LatLng?>, LatLng?>,
              AsyncValue<LatLng?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
