import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:cred_assignment/providers/category_provider.dart';
import 'package:cred_assignment/utils/colors.dart';
import 'package:cred_assignment/widgets/grid_view.dart';
import 'package:cred_assignment/widgets/list_view.dart';
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
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          Expanded(
                            child: ListTile(
                              title: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3),
                                child: Text(
                                  dataProvider.exploreCred!.templateProperties
                                      .header.title,
                                  style: GoogleFonts.roboto(
                                    color: subtextColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              subtitle: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3),
                                child: Text(
                                  dataProvider.exploreCred!.templateProperties
                                          .header.subtitleTitle ??
                                      '',
                                  style: GoogleFonts.roboto(
                                    color: textColor,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          AnimatedToggleSwitch.rolling(
                            current: isGrid,
                            values: const [false, true],
                            iconList: [
                              Icon(Icons.list_alt,
                                  size: 25,
                                  color: isGrid
                                      ? Colors.transparent
                                      : Colors.black),
                              Icon(Icons.grid_view_rounded,
                                  size: 25,
                                  color: isGrid
                                      ? Colors.black
                                      : Colors.transparent),
                            ],
                            indicatorSize: const Size(25, 25),
                            borderWidth: 1,
                            inactiveOpacity: 0,
                            fittingMode:
                                FittingMode.preventHorizontalOverlapping,
                            height: 26,
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
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white)),
                            child: const Center(
                                child: Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: Colors.white,
                            )),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SingleChildScrollView(
                        child: isGrid
                            ? buildGrid(dataProvider)
                            : buildList(dataProvider),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
