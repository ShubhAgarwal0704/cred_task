import 'dart:convert';
import 'package:cred_assignment/models/api_response_model.dart';
import 'package:cred_assignment/utils/constants.dart';
import 'package:http/http.dart' as http;

class ApiService {

  Future<Map<String, dynamic>> fetchData() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<ExploreCred> getExploreCred() async {
    final data = await fetchData();
    return ExploreCred.fromJson(data['explore_cred']);
  }

  Future<List<Section>> getSections() async {
    final data = await fetchData();
    return (data['sections'] as List).map((i) => Section.fromJson(i)).toList();
  }
}
