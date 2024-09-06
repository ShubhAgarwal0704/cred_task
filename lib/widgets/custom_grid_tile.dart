import 'package:cred_assignment/models/api_response_model.dart';
import 'package:cred_assignment/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomGridTile extends StatelessWidget {
  const CustomGridTile({
    super.key,
    required this.item,
  });

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
        const SizedBox(height: 8),
        Text(item.displayData.name,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                color: textColor, fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
