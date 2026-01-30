import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../views/confirm_data.dart';

class CaptureImageFab extends ConsumerStatefulWidget {
  const CaptureImageFab({super.key});

  @override
  ConsumerState<CaptureImageFab> createState() => _CaptureImageFabState();
}

class _CaptureImageFabState extends ConsumerState<CaptureImageFab> {
  File? image;
  final picker = ImagePicker();
  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (!mounted || pickedFile == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ConfirmDataPage(
          type: DataViewType.uploadMode,
          uploadImagePath: pickedFile.path,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: ()  {
        pickImage(ImageSource.camera);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100.0),
      ),
      tooltip: 'Increment',
      child: const Icon(Icons.camera_alt_rounded),
    );
  }
}

