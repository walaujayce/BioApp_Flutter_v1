import 'dart:io';
import 'package:bio_app/providers/uploaded_list_provider.dart';
import 'package:bio_app/views/confirm_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../models/species.dart';

class UploadedListCard extends ConsumerStatefulWidget {
  final Species species;

  const UploadedListCard({super.key, required this.species});

  @override
  ConsumerState<UploadedListCard> createState() => _UploadedListCardState();
}

class _UploadedListCardState extends ConsumerState<UploadedListCard> {
  void onUploadButtonPressed() {
    if (widget.species.isLocalImage && !widget.species.isUploaded) {
      final updatedSpecies = widget.species.copyWith(
        isUploaded: true,
        isLocalImage: false,
      );
      ref.read(uploadedListProvider.notifier).update(updatedSpecies);

      debugPrint("Species count: ${ref.read(uploadedListProvider).length}");

      // Optional: Add a small feedback for the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(backgroundColor: Colors.green,content: Text("Upload successfully!")),
      );
    }
  }

  void onDeleteButtonPressed(BuildContext context, Species species) {
    ref.read(uploadedListProvider.notifier).remove(species);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Background color is required for shadows to show
        // borderRadius: BorderRadius.circular(20.0), // 2px rounded corners
        // border: Border.all(
        //   color: Colors.grey, // Solid black
        //   width: 0.2, // 1px width
        // ),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withValues(alpha: 0.1), // Soft shadow
        //     blurRadius: 3,
        //     offset: const Offset(0, 2), // Shadow position
        //   ),
        // ],
      ),
      child: Slidable(
        enabled: widget.species.isLocalImage,
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (_) => onDeleteButtonPressed(context, widget.species),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: ListTile(
          // ICON
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: AspectRatio(
              aspectRatio: 1,
              child: widget.species.isLocalImage
                  ? Image.file(File(widget.species.imageUrl), fit: BoxFit.cover)
                  : (widget.species.imageUrl.contains("data") //TODO: need to fix this imageurl
                        ? Image.file(
                            File(widget.species.imageUrl),
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            widget.species.imageUrl,
                            fit: BoxFit.cover,
                          )),
            ),
          ),
          // TITLE
          title: Text(
            widget.species.speciesName,
            style: TextStyle(fontSize: 14.0),
          ),
          // SUBTITLE
          subtitle: Text(
            widget.species.description ?? "",
            // widget.species.id,
            style: TextStyle(fontSize: 10.0),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          // TRIALING ICON
          trailing: IconButton(
            onPressed: widget.species.isUploaded ? null : onUploadButtonPressed,
            icon: Icon(
              widget.species.isUploaded
                  ? Icons.cloud_done_rounded
                  : Icons.cloud_upload_rounded,
              color: widget.species.isUploaded ? Colors.green : Colors.grey,
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ConfirmDataPage(
                  type: DataViewType.modifyMode,
                  existedSpecies: widget.species,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
