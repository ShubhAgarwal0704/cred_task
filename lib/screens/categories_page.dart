import 'package:animated_toggle_switch/animated_toggle_switch.dart';
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
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.075,
                      ),
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
                      const SizedBox(height: 20),
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
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                  horizontal: 16,
                                ),
                                child: Text(
                                  section.templateProperties.header.title,
                                  style: const TextStyle(
                                      color: subtextColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: isGrid
                                    ? ((section.templateProperties.items!
                                                    .length +
                                                1) *
                                            50)
                                        .toDouble()
                                    : (section.templateProperties.items!
                                                .length *
                                            120)
                                        .toDouble(),
                                child: Stack(
                                  children: section.templateProperties.items!
                                      .asMap()
                                      .entries
                                      .map((entry) {
                                    int index = entry.key;
                                    Item item = entry.value;
                                    double itemWidth =
                                        MediaQuery.of(context).size.width /
                                            (isGrid ? 3 : 1);
                                    double itemHeight = 120;

                                    return AnimatedPositioned(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut,
                                      left:
                                          isGrid ? (index % 3) * itemWidth : 0,
                                      top: isGrid
                                          ? (index ~/ 3) * itemHeight
                                          : index * itemHeight,
                                      right: 2,
                                      child: AnimatedOpacity(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        opacity: 1.0,
                                        child: SizedBox(
                                          width: itemWidth,
                                          height: itemHeight,
                                          child: isGrid
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 16),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: 84,
                                                        height: 84,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  borderColor,
                                                              width: 1.5),
                                                        ),
                                                        child: ClipRRect(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(20.0),
                                                            child:
                                                                Image.network(
                                                              item.displayData
                                                                  .iconUrl,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Text(
                                                          item.displayData.name,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  color:
                                                                      textColor,
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal)),
                                                    ],
                                                  ),
                                                )
                                              : Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 16),
                                                      child: Container(
                                                        width: 84,
                                                        height: 84,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  borderColor,
                                                              width: 1.5),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(20),
                                                          child: ClipRRect(
                                                            child:
                                                                Image.network(
                                                              item.displayData
                                                                  .iconUrl,
                                                              fit: BoxFit
                                                                  .fitHeight,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                              item.displayData
                                                                  .name,
                                                              style: GoogleFonts.poppins(
                                                                  color:
                                                                      textColor,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          const SizedBox(
                                                              height: 4),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 30),
                                                            child: Text(
                                                                item.displayData
                                                                    .description,
                                                                style: GoogleFonts.poppins(
                                                                    color:
                                                                        subtextColor,
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
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
