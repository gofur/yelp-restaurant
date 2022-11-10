import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as Http;
import 'package:restaurant/config.dart';
import 'package:restaurant/service_locator.dart';

// Custom Http Client used for both REST and GraphQL
// Configured to work with the Yelp API
class YelpHttpClient extends Http.BaseClient {
  final Http.Client client = Http.Client();
  final Config _config = serviceLocator<Config>();

  Future<Http.StreamedResponse> send(Http.BaseRequest request) {
    request.headers['Authorization'] = "Bearer ${_config.apiKey}";
    request.headers['content-type'] = "application/json";
    request.headers['accept-language'] = "en_US";
    return client.send(request);
  }
}

extension HttpClientExtension on YelpHttpClient {
  Future<T> getData<T>(String url, T Function(dynamic) fn) async {
    Http.Response response;
      response = await get(Uri.parse(url));

    if (response.statusCode == 200) {
      return fn(jsonDecode(response.body));
    } else {
      throw Exception("HTTP Error(${response.statusCode}): ${response.reasonPhrase}");
    }
  }
}
