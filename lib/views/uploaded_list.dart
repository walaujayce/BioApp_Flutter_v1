import 'package:bio_app/components/uploaded_list_card.dart';
import 'package:bio_app/models/species.dart';
import 'package:bio_app/providers/uploaded_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class UploadedList extends ConsumerWidget {
  const UploadedList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final speciesList = [
    //   ...speciesTemplateList,
    //   ...ref.watch(uploadedListProvider),
    // ];
    final speciesList = ref.watch(uploadedListProvider);
    return Container(
      decoration: BoxDecoration(color: Color(0xF3F6F9FF)),
      // padding: EdgeInsets.all(10.0),
      child: ListView.separated(
        itemBuilder: (context, index) =>
            UploadedListCard(species: speciesList[index]),
        separatorBuilder: (_, i) => SizedBox(
          height:
              0.5, // Controls the total height of the divider area, including padding
          child: Center(
            child: Container(
              height: 1, // Controls the thickness of the line
              margin: EdgeInsetsDirectional.only(
                start: 10,
                end: 10,
              ), // Optional: add indents
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.grey.shade200,
                    Colors.grey,
                    Colors.grey.shade600,
                    Colors.grey,
                    Colors.grey.shade200,
                  ], // Your gradient colors
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
          ),
        ),
        itemCount: speciesList.length,
      ),
    );
  }
}
