import 'package:cred_assignment/providers/category_provider.dart';
import 'package:cred_assignment/utils/colors.dart';
import 'package:cred_assignment/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';

Widget buildList(DataProvider dataProvider) {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: dataProvider.sections?.length ?? 0,
    itemBuilder: (context, index) {
      final section = dataProvider.sections![index];
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
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: section.templateProperties.items?.length ?? 0,
            itemBuilder: (context, itemIndex) {
              final item = section.templateProperties.items![itemIndex];
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
                  child: CustomListTile(item: item));
            },
          ),
          const SizedBox(height: 40),
        ],
      );
    },
  );
}
