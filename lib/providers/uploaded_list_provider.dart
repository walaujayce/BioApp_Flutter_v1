import 'package:bio_app/models/species.dart';
import 'package:bio_app/views/uploaded_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'uploaded_list_provider.g.dart';

@riverpod
class UploadedListNotifier extends _$UploadedListNotifier {
  @override
  List<Species> build() {
    return [...speciesTemplateList];
  }

  List<Species> get cart => state;

  // ➕ Add product
  void add(Species species) {
    // final index = state.indexWhere((p) => p.id == species.id);

    // if (index == -1) {
      state = [...state, species];
    // }
  }

  // Edit product properties
  void update(Species updatedSpecies){
    state = [
      for (final species in state)
        if (species.id == updatedSpecies.id) updatedSpecies else species
    ];
  }

  // ➖ Remove product completely
  void remove(Species species) {
    state = state.where((p) => p.id != species.id).toList();
  }

  // 🧹 Clear cart
  void clear() {
    state = [];
  }
}
