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
                child: SafeArea(
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
                          IconButton(
                            icon: Icon(isGrid ? Icons.list : Icons.grid_view,
                                color: textColor),
                            onPressed: () {
                              setState(() {
                                isGrid = !isGrid;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
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
