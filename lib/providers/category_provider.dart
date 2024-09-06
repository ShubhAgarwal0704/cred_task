import 'package:cred_assignment/models/api_response_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';

class DataProvider with ChangeNotifier {
  ExploreCred? exploreCred;
  List<Section>? sections;
  bool isLoading = true;
  String? selectedCategoryTitle;
  String? selectedCategoryDescription;
  String? selectedCategoryImageURL;

  final ApiService _apiService = ApiService();

  DataProvider() {
    fetchData();
    loadSelectedCategory();
  }

  Future<void> fetchData() async {
    try {
      exploreCred = await _apiService.getExploreCred();
      sections = await _apiService.getSections();
    } catch (e) {
      // Handle error
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Save selected category in SharedPreferences
  Future<void> saveSelectedCategory(
      String categoryTitle, String categoryDesc, String categoryImage) async {
    selectedCategoryTitle = categoryTitle;
    selectedCategoryDescription = categoryDesc;
    selectedCategoryImageURL = categoryImage;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedCategory', categoryTitle);
    await prefs.setString('selectedCategoryDesc', categoryDesc);
    await prefs.setString('selectedCategoryImage', categoryImage);
    notifyListeners();
  }

  // Load selected category from SharedPreferences
  Future<void> loadSelectedCategory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    selectedCategoryTitle = prefs.getString('selectedCategory');
    selectedCategoryDescription = prefs.getString('selectedCategoryDesc');
    selectedCategoryImageURL = prefs.getString('selectedCategoryImage');
    notifyListeners();
  }
}
