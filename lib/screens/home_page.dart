import 'package:cred_assignment/providers/category_provider.dart';
import 'package:cred_assignment/screens/categories_page.dart';
import 'package:cred_assignment/utils/colors.dart';
import 'package:cred_assignment/utils/constants.dart';
import 'package:cred_assignment/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<DataProvider>(context, listen: false).loadSelectedCategory();
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<DataProvider>(context);
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          // Wavey design
          Image.asset(waveyLine, width: double.maxFinite),
          Padding(
            padding:
                EdgeInsets.all(screenWidth * 0.05), // Dynamically set padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                categoryProvider.selectedCategoryImageURL == null
                    ? SizedBox(height: screenHeight * 0.15)
                    : Image.network(
                        categoryProvider.selectedCategoryImageURL.toString(),
                        height: screenHeight * 0.15, // Dynamic image height
                        fit: BoxFit.fitHeight,
                      ),
                SizedBox(height: screenHeight * 0.1), // Dynamic space
                categoryProvider.selectedCategoryTitle == null
                    ? const Text("")
                    : Text(
                        categoryProvider.selectedCategoryTitle.toString(),
                        style: GoogleFonts.poppins(
                          color: textColor,
                          fontSize: screenWidth * 0.05, // Dynamic font size
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                SizedBox(height: screenHeight * 0.03),
                categoryProvider.selectedCategoryDescription == null
                    ? const Text("")
                    : Text(
                        categoryProvider.selectedCategoryDescription.toString(),
                        style: GoogleFonts.tinos(
                          color: subtextColor2,
                          fontSize: screenWidth * 0.06, // Dynamic font size
                          letterSpacing: 0.75,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                SizedBox(height: screenHeight * 0.05), // Dynamic space
                NeoPopButton(
                  color: Colors.white,
                  onTapUp: () {
                    HapticFeedback.vibrate();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const CategoryPage()));
                  },
                  onTapDown: () => HapticFeedback.vibrate(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                        vertical:
                            screenHeight * 0.02), // Dynamic button padding
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(goToCategories,
                            style: GoogleFonts.poppins(
                              color: buttonTextColor,
                              fontSize:
                                  screenWidth * 0.045, // Dynamic font size
                              fontWeight: FontWeight.bold,
                            )),
                        SizedBox(width: screenWidth * 0.02), // Dynamic spacing
                        Icon(Icons.arrow_forward_sharp,
                            color: Colors.black,
                            size: screenWidth * 0.05), // Dynamic icon size
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
