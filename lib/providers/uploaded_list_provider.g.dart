// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uploaded_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UploadedListNotifier)
const uploadedListProvider = UploadedListNotifierProvider._();

final class UploadedListNotifierProvider
    extends $NotifierProvider<UploadedListNotifier, List<Species>> {
  const UploadedListNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'uploadedListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$uploadedListNotifierHash();

  @$internal
  @override
  UploadedListNotifier create() => UploadedListNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Species> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Species>>(value),
    );
  }
}

String _$uploadedListNotifierHash() =>
    r'1aa9f92223639fdbfddc056b343bdec0cd4ba2d8';

abstract class _$UploadedListNotifier extends $Notifier<List<Species>> {
  List<Species> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<Species>, List<Species>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<Species>, List<Species>>,
              List<Species>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
