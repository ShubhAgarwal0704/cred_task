import 'package:cred_assignment/models/api_response_model.dart';
import 'package:cred_assignment/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GridBuild extends StatelessWidget {
  const GridBuild({
    super.key,
    required this.screenWidth,
    required this.item,
    required this.screenHeight,
  });

  final double screenWidth;
  final Item item;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: screenWidth * 0.04,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: screenWidth * 0.2,
            height: screenWidth * 0.2,
            decoration: BoxDecoration(
              border: Border.all(color: borderColor, width: 1.5),
            ),
            child: ClipRRect(
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.04),
                child: Image.network(
                  item.displayData.iconUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Expanded(
            child: Text(item.displayData.name,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    color: textColor,
                    fontSize: screenWidth * 0.0275,
                    fontWeight: FontWeight.normal)),
          ),
        ],
      ),
    );
  }
}
