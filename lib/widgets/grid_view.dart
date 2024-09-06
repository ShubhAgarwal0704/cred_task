// ignore_for_file: use_build_context_synchronously

import 'package:cred_assignment/providers/category_provider.dart';
import 'package:cred_assignment/utils/colors.dart';
import 'package:cred_assignment/widgets/custom_grid_tile.dart';
import 'package:flutter/material.dart';

Widget buildGrid(DataProvider dataProvider) {
  return ListView.builder(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: dataProvider.sections?.length ?? 0,
    itemBuilder: (context, listIndex) {
      final section = dataProvider.sections![listIndex];

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ),
            child: Text(
              section.templateProperties.header.title,
              style: const TextStyle(
                  color: subtextColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: section.templateProperties.items?.length ?? 0,
            itemBuilder: (context, gridIndex) {
              final item = section.templateProperties.items![gridIndex];
              return GestureDetector(
                onTap: () async {
                  dataProvider.saveSelectedCategory(
                    item.displayData.name,
                    item.displayData.description,
                    item.displayData.iconUrl,
                  );
                  await Future.delayed(const Duration(milliseconds: 100));
                  Navigator.of(context).pop();
                },
                child: CustomGridTile(item: item),
              );
            },
          ),
          const SizedBox(height: 40),
        ],
      );
    },
  );
}
