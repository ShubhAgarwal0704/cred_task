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

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          //wavey design
          Image.asset(waveyLine, width: double.maxFinite),
          Padding(
            padding: const EdgeInsets.all(homePagePadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                categoryProvider.selectedCategoryImageURL == null
                    ? const SizedBox(height: 120)
                    : Image.network(
                        categoryProvider.selectedCategoryImageURL.toString(),
                        height: 120,
                        fit: BoxFit.fitHeight),
                const SizedBox(height: 80),
                categoryProvider.selectedCategoryTitle == null
                    ? const Text("")
                    : Text(categoryProvider.selectedCategoryTitle.toString(),
                        style: GoogleFonts.poppins(
                            color: textColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                categoryProvider.selectedCategoryDescription == null
                    ? const Text("")
                    : Text(
                        categoryProvider.selectedCategoryDescription.toString(),
                        style: GoogleFonts.tinos(
                            color: subtextColor2,
                            fontSize: 25,
                            letterSpacing: 0.75,
                            fontWeight: FontWeight.w100)),
                const SizedBox(height: 30),
                NeoPopButton(
                  color: Colors.white,
                  onTapUp: () {
                    HapticFeedback.vibrate();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const CategoryPage()));
                  },
                  onTapDown: () => HapticFeedback.vibrate(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(goToCategories,
                            style: GoogleFonts.poppins(
                              color: buttonTextColor,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            )),
                        const SizedBox(width: 4),
                        const Icon(Icons.arrow_forward_sharp,
                            color: Colors.black),
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
