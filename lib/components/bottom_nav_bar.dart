import 'package:bio_app/providers/page_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomAppBar(
      padding: const EdgeInsets.all(1),
      shape: CircularNotchedRectangle(),
      elevation: 0,
      color: Colors.blue,
      child: BottomNavigationBar(
        onTap: (i) {
          if (i == 1) return;
          ref.read(pageProvider.notifier).setPage(i);
        },
        currentIndex: ref.watch(pageProvider),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        unselectedFontSize: 14.0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.pets), label: "附近物種"),
          BottomNavigationBarItem(icon: Icon(null), label: "新增記錄"),
          BottomNavigationBarItem(icon: Icon(Icons.view_list), label: "上傳列表"),
        ],
      ),
    );
  }
}
