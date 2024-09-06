import 'package:cred_assignment/models/api_response_model.dart';
import 'package:cred_assignment/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.item,
  });

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
          child: Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(
              border: Border.all(color: borderColor, width: 1.5),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: ClipRRect(
                child: Image.network(
                  item.displayData.iconUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.displayData.name,
                  style: GoogleFonts.poppins(
                      color: textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(item.displayData.description,
                  style: GoogleFonts.poppins(
                      color: subtextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.normal)),
            ],
          ),
        ),
      ],
    );
  }
}
