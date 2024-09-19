import 'package:cred_assignment/models/api_response_model.dart';
import 'package:cred_assignment/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListBuild extends StatelessWidget {
  const ListBuild({
    super.key,
    required this.screenWidth,
    required this.item,
    required this.itemHeight,
    required this.screenHeight,
  });

  final double screenWidth;
  final Item item;
  final double itemHeight;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          child: Container(
            width: screenWidth * 0.2,
            height: screenWidth * 0.2,
            decoration: BoxDecoration(
              border: Border.all(color: borderColor, width: 1.5),
            ),
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Image.network(
                item.displayData.iconUrl,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: itemHeight * 0.1,
              ),
              Text(item.displayData.name,
                  style: GoogleFonts.poppins(
                      color: textColor,
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: screenHeight * 0.005),
              Padding(
                padding: EdgeInsets.only(right: screenWidth * 0.08),
                child: Text(item.displayData.description,
                    style: GoogleFonts.poppins(
                        color: subtextColor,
                        fontSize: screenWidth * 0.03,
                        fontWeight: FontWeight.normal)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
