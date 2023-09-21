import 'dart:convert';

import 'package:http/http.dart' as httpClient;

import 'package:wallpaper/my_exception.dart';

class Apihelper {
  Future<dynamic> getApi(String url, {Map<String, String>? header}) async {
    String baseurl = "https://api.pexels.com/v1/";
    late dynamic jsonResponse;
    try {
      var response = await httpClient
          .get(Uri.parse('$baseurl$url'), headers: header)
          .timeout(Duration(seconds: 20));
      jsonResponse = checkResponse(response);
      return jsonResponse != null
          ? jsonResponse
              as Map<String, dynamic> // Explicitly cast to Map<String, dynamic>
          : <String, dynamic>{};
    }
    //  on SocketException {
    //   throw FetchDataException("No internet connection");
    // }
    catch (e) {
      return <String,
          dynamic>{}; // Return an empty map in case of any other exception
    }
  }

  dynamic checkResponse(httpClient.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJsonData = jsonDecode(response.body.toString());
        return responseJsonData;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        throw UnauthorisedException(response.body.toString());
      case 404:
        throw InvalidInputException(response.body.toString());
      default:
        throw FetchDataException(
            'Error occurred while communicating with the server with status code: ${response.statusCode.toString()}');
    }
  }
}
