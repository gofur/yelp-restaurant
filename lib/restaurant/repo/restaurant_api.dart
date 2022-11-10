import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:restaurant/config.dart';
import 'package:restaurant/service_locator.dart';
import 'dart:convert';

import 'model.dart';

class RestaurantApi {
  final Config _config = serviceLocator<Config>();

  Map<String, String> get headers => {
        "content-type": "application/json",
        "accept-language": "application/json",
        "Authorization": "Bearer ${_config.apiKey}",
      };

  Future<BusinessListRestModel> fetchData(
      String latitude, String longitude, String term) async {
    final response = await http.get(
        Uri.parse(_config.apiURL +
            "/businesses/search?term=$term&latitude=$latitude&longitude=$longitude"),
        headers: headers);

    if (response.statusCode == 200) {
      List<int> bytes = response.body.toString().codeUnits;
      var responseString = utf8.decode(bytes);
      return BusinessListRestModel.fromJson(jsonDecode(responseString));
    } else {
      throw Exception();
    }
  }

  Future<BusinessRestModel> fetchDetail(String id) async {
    final response =  await http.get(Uri.parse(_config.apiURL+"/businesses/$id"),headers: headers);

    if (response.statusCode == 200) {
      List<int> bytes = response.body.toString().codeUnits;
      var responseString = utf8.decode(bytes);
      return BusinessRestModel.fromJson(jsonDecode(responseString));
    } else {
      throw Exception();
    }
  }

}
