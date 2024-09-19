import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:cred_assignment/components/grib_build.dart';
import 'package:cred_assignment/components/list_build.dart';
import 'package:cred_assignment/models/api_response_model.dart';
import 'package:cred_assignment/providers/category_provider.dart';
import 'package:cred_assignment/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool isGrid = false;

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: dataProvider.isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  backgroundColor: textColor,
                  color: subtextColor,
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                      vertical: screenHeight * 0.01),
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenHeight * 0.025,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: screenHeight * 0.003),
                                child: Text(
                                  dataProvider.exploreCred!.templateProperties
                                      .header.title,
                                  style: GoogleFonts.roboto(
                                    color: subtextColor,
                                    fontSize: screenWidth * 0.04,
                                    letterSpacing: 1.5,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              subtitle: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: screenHeight * 0.001),
                                child: Text(
                                  dataProvider.exploreCred!.templateProperties
                                          .header.subtitleTitle ??
                                      '',
                                  style: GoogleFonts.montserrat(
                                    color: textColor,
                                    fontSize: screenWidth * 0.07,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(bottom: screenHeight * 0.03),
                            child: AnimatedToggleSwitch.rolling(
                              current: isGrid,
                              values: const [false, true],
                              iconList: [
                                Icon(Icons.list_alt,
                                    size: screenWidth * 0.05,
                                    color: isGrid
                                        ? Colors.transparent
                                        : Colors.black),
                                Icon(Icons.grid_view_rounded,
                                    size: screenWidth * 0.05,
                                    color: isGrid
                                        ? Colors.black
                                        : Colors.transparent),
                              ],
                              indicatorSize:
                                  Size(screenWidth * 0.05, screenWidth * 0.05),
                              borderWidth: 1,
                              inactiveOpacity: 0,
                              fittingMode:
                                  FittingMode.preventHorizontalOverlapping,
                              height: screenWidth * 0.05,
                              style: ToggleStyle(
                                backgroundColor: backgroundColor,
                                indicatorColor: Colors.white,
                                borderColor: Colors.white,
                                borderRadius: BorderRadius.circular(0),
                              ),
                              onChanged: (bool newValue) {
                                setState(() {
                                  isGrid = newValue;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.08,
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(bottom: screenHeight * 0.03),
                            child: Container(
                              width: screenWidth * 0.05,
                              height: screenWidth * 0.05,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white)),
                              child: const Center(
                                  child: Icon(
                                size: 16,
                                Icons.keyboard_arrow_down_outlined,
                                color: Colors.white,
                              )),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: dataProvider.sections?.length ?? 0,
                        itemBuilder: (context, listIndex) {
                          final section = dataProvider.sections![listIndex];

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: screenHeight * 0.005,
                                  horizontal: screenWidth * 0.04,
                                ),
                                child: Text(
                                  section.templateProperties.header.title,
                                  style: TextStyle(
                                      color: subtextColor,
                                      fontSize: screenWidth * 0.035,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.025),
                              SizedBox(
                                height: isGrid
                                    ? ((section.templateProperties.items!
                                                    .length +
                                                1) *
                                            screenHeight *
                                            0.065)
                                        .toDouble()
                                    : (section.templateProperties.items!
                                                .length *
                                            screenHeight *
                                            0.15)
                                        .toDouble(),
                                child: Stack(
                                  children: section.templateProperties.items!
                                      .asMap()
                                      .entries
                                      .map((entry) {
                                    int index = entry.key;
                                    Item item = entry.value;
                                    double itemWidth =
                                        screenWidth / (isGrid ? 3 : 1);
                                    double itemHeight = screenHeight * 0.15;

                                    return AnimatedPositioned(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                      left:
                                          isGrid ? (index % 3) * itemWidth : 0,
                                      top: isGrid
                                          ? (index ~/ 3) * itemHeight
                                          : index * itemHeight,
                                      right: 2,
                                      child: AnimatedOpacity(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        opacity: 1,
                                        curve: Curves.bounceIn,
                                        child: SizedBox(
                                          width: itemWidth,
                                          height: itemHeight,
                                          child: GestureDetector(
                                            onTap: () async {
                                              dataProvider.saveSelectedCategory(
                                                item.displayData.name,
                                                item.displayData.description,
                                                item.displayData.iconUrl,
                                              );
                                              await Future.delayed(
                                                  const Duration(
                                                      milliseconds: 100));
                                              Navigator.of(context).pop();
                                            },
                                            child: isGrid
                                                ? GridBuild(
                                                    screenWidth: screenWidth,
                                                    item: item,
                                                    screenHeight: screenHeight)
                                                : ListBuild(
                                                    screenWidth: screenWidth,
                                                    item: item,
                                                    itemHeight: itemHeight,
                                                    screenHeight: screenHeight),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
