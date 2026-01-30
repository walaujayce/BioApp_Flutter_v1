// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PageNotifier)
const pageProvider = PageNotifierProvider._();

final class PageNotifierProvider extends $NotifierProvider<PageNotifier, int> {
  const PageNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pageProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pageNotifierHash();

  @$internal
  @override
  PageNotifier create() => PageNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$pageNotifierHash() => r'b47cc2ced257f0659f7d1cd260411f8f969de1a0';

abstract class _$PageNotifier extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
