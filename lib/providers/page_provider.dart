import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'page_provider.g.dart';

@riverpod
class PageNotifier extends _$PageNotifier {
  @override
  int build() {
    return 0;
  }

  void setPage(int index) {
    state = index;
  }
}