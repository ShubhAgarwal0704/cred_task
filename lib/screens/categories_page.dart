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
            : SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
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
                                    letterSpacing: 1.5,
                                    fontWeight: FontWeight.w700,
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
                                  style: GoogleFonts.montserrat(
                                    color: textColor,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 23),
                            child: AnimatedToggleSwitch.rolling(
                              current: isGrid,
                              values: const [false, true],
                              iconList: [
                                Icon(Icons.list_alt,
                                    size: 21,
                                    color: isGrid
                                        ? Colors.transparent
                                        : Colors.black),
                                Icon(Icons.grid_view_rounded,
                                    size: 21,
                                    color: isGrid
                                        ? Colors.black
                                        : Colors.transparent),
                              ],
                              indicatorSize: const Size(21, 21),
                              borderWidth: 1,
                              inactiveOpacity: 0,
                              fittingMode:
                                  FittingMode.preventHorizontalOverlapping,
                              height: 21,
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
                          const SizedBox(
                            width: 32,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 23),
                            child: Container(
                              width: 21,
                              height: 21,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white)),
                              child: const Center(
                                  child: Icon(
                                size: 20,
                                Icons.keyboard_arrow_down_outlined,
                                color: Colors.white,
                              )),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      isGrid
                          ? buildGrid(dataProvider)
                          : buildList(dataProvider),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
