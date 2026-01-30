import 'dart:convert';
import 'package:bio_app/models/species.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/prefs_config.dart';

part 'uploaded_list_provider.g.dart';

// @riverpod
// class UploadedListNotifier extends _$UploadedListNotifier {
//   @override
//   List<Species> build() {
//     return [...speciesTemplateList];
//   }
//
//   List<Species> get cart => state;
//
//   // ➕ Add product
//   void add(Species species) {
//     // final index = state.indexWhere((p) => p.id == species.id);
//
//     // if (index == -1) {
//       state = [...state, species];
//     // }
//   }
//
//   // Edit product properties
//   void update(Species updatedSpecies){
//     state = [
//       for (final species in state)
//         if (species.id == updatedSpecies.id) updatedSpecies else species
//     ];
//   }
//
//   // ➖ Remove product completely
//   void remove(Species species) {
//     state = state.where((p) => p.id != species.id).toList();
//   }
//
//   // 🧹 Clear cart
//   void clear() {
//     state = [];
//   }
// }
@Riverpod(keepAlive: true)
class UploadedListNotifier extends _$UploadedListNotifier {

  @override
  List<Species> build() {
    _loadFromStorage();
    return [...speciesTemplateList];
  }

  // 🔹 新增
  Future<void> add(Species species) async {
    state = [...state, species];
    await _saveToStorage();
  }

  // 🔹 刪除
  Future<void> remove(Species species) async {
    state = state.where((s) => s.id != species.id).toList();
    await _saveToStorage();
  }

  // 🔹 修改
  Future<void> update(Species updatedSpecies) async{
    state = [
      for (final species in state)
        if (species.id == updatedSpecies.id) updatedSpecies else species
    ];
    await _saveToStorage();
  }

  // 💾 存
  Future<void> _saveToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = state.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList(StorageKeys.uploadedSpeciesList, jsonList);
  }

  // 📥 讀
  Future<void> _loadFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(StorageKeys.uploadedSpeciesList);

    if (jsonList == null) return;

    state = jsonList
        .map((e) => Species.fromJson(jsonDecode(e)))
        .toList();
  }

  // 🧹 全清
  Future<void> clear() async {
    state = [];
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(StorageKeys.uploadedSpeciesList);
  }
}

