import 'package:bio_app/providers/page_provider.dart';
import 'package:bio_app/views/nearby_species.dart';
import 'package:bio_app/views/uploaded_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<int>(pageProvider, (prev, next) {
      _pageController.animateToPage(
        next,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        NearbySpeciesView(),
        UploadedList(),
      ],
    );
  }
}
