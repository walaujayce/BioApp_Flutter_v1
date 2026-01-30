import 'dart:io';
import 'package:bio_app/providers/location_provider.dart';
import 'package:bio_app/views/nearby_species.dart';
import 'package:bio_app/views/uploaded_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../components/google_map.dart';
import '../components/loading_screen.dart';
import '../components/text_field.dart';
import '../models/species.dart';
import '../providers/uploaded_list_provider.dart';

enum DataViewType { uploadMode, modifyMode }

class ConfirmDataPage extends ConsumerStatefulWidget {
  final DataViewType type;
  final Species? existedSpecies;
  final String? uploadImagePath;

  const ConfirmDataPage({
    super.key,
    required this.type,
    this.existedSpecies,
    this.uploadImagePath,
  });

  @override
  ConsumerState<ConfirmDataPage> createState() => _ConfirmDataPageState();
}

class _ConfirmDataPageState extends ConsumerState<ConfirmDataPage> {
  final formKey = GlobalKey<FormState>();
  final _speciesNameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.type == DataViewType.modifyMode) {
      _speciesNameController.text = widget.existedSpecies!.speciesName;
      _descriptionController.text = widget.existedSpecies!.description ?? "";

      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(locationProvider.notifier)
            .updateLocation(
              LatLng(
                widget.existedSpecies!.latitude,
                widget.existedSpecies!.longitude,
              ),
            );
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        context.loaderOverlay.show();
        await ref.read(locationProvider.notifier).fetchCurrentLocation();
        if (!mounted) return;
        context.loaderOverlay.hide();
      });
    }
  }

  @override
  void dispose() {
    _speciesNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void onSubmit() {
    final location = ref.read(locationProvider).value;

    if (location == null) return;
    final int speciesListLength = ref.watch(uploadedListProvider).length + 1;
    ref
        .read(uploadedListProvider.notifier)
        .add(
          Species(
            id: speciesListLength.toString(),
            speciesName: _speciesNameController.text.trim(),
            description: _descriptionController.text.trim(),
            imageUrl: widget.uploadImagePath ?? "",
            imageTakenTime: DateTime.now(),
            latitude: location.latitude,
            longitude: location.longitude,
            isLocalImage: true,
          ),
        );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final imagePath = widget.type == DataViewType.uploadMode
        ? widget.uploadImagePath!
        : widget.existedSpecies!.imageUrl;
    final imageTakenTime = widget.type == DataViewType.uploadMode
        ? DateTime.now()
        : widget.existedSpecies!.imageTakenTime;
    final location = ref.watch(locationProvider).value;
    bool readOnly = widget.type == DataViewType.uploadMode
        ? false
        : (widget.existedSpecies!.isUploaded ? true : false);

    return LoaderOverlay(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
              expandedHeight: screenSize.height * 0.7,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  widget.type == DataViewType.uploadMode ? "確認上傳資料" : "詳細資訊",
                  style: TextStyle(color: Colors.white),
                ),
                background: widget.type == DataViewType.modifyMode
                    ? (widget.existedSpecies!.imageUrl.contains("data")
                          ? Image.file(File(imagePath), fit: BoxFit.cover)
                          : Image.asset(imagePath, fit: BoxFit.cover))
                    : Image.file(
                        File(widget.uploadImagePath!),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  InputTextFormField(
                    title: "物種名稱",
                    inputController: _speciesNameController,
                    readOnly: readOnly,
                  ),
                  SizedBox(height: 20.0),
                  Text("發現時間"),
                  Text(
                    "${imageTakenTime.year}/${imageTakenTime.month}/${imageTakenTime.day} ${imageTakenTime.hour.toString().padLeft(2, '0')}:${imageTakenTime.minute.toString().padLeft(2, '0')}",
                  ),
                  SizedBox(height: 20.0),
                  Text("發現地點"),
                  Text(
                    "${location?.latitude.toStringAsFixed(4)}, ${location?.longitude.toStringAsFixed(4)}",
                  ),
                  SizedBox(height: 12.0),
                  FoundPositionMap(),
                  SizedBox(height: 28.0),
                  InputTextField(
                    title: "詳細資訊",
                    inputController: _descriptionController,
                    readOnly: readOnly,
                  ),
                  SizedBox(height: 20.0),
                  if (!readOnly)
                    TextButton(
                      onPressed: onSubmit,
                      style: TextButton.styleFrom(
                        backgroundColor:
                            Colors.blue, // Set the background color
                        foregroundColor: Colors.white, // Set the text color
                      ),
                      child: Text("Submit"),
                    ),
                ]),
              ),
            ),
          ],
        ),
      ),
      // progressIndicator: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     CircularProgressIndicator(),
      //     SizedBox(height: 12),
      //     Text(
      //       _loadingMessage,
      //       style: TextStyle(
      //           color: Colors.black,
      //           fontSize: 18,
      //           decoration: TextDecoration.none),
      //     )
      //   ],
      // ),
    );
  }
}

class FoundPositionMap extends ConsumerWidget {
  const FoundPositionMap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationAsync = ref.watch(locationProvider);

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width * 0.6,
        child: locationAsync.when(
          // 🟡 定位中 → Loading UX
          loading: () => const LocationLoading(),

          // 🔴 定位失敗
          error: (err, _) => LocationError(err.toString()),

          // 🟢 定位成功 → 顯示地圖
          data: (location) {
            if (location == null) {
              return const LocationLoading();
            }
            return GoogleMapView(location: location);
          },
        ),
      ),
    );
  }
}
