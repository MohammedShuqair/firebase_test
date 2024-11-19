import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

/// dealing with network requests
class NetworkHelper {



  static Future<Map<String, dynamic>> getData(final String url,) async {
    String token = "28|jnOAf06U0bJeOpkUE41iqii7vHvQtQwBHRgXHWJY";
    final response = await http.get(Uri.parse(url),
        headers: {
      HttpHeaders.authorizationHeader:"Bearer $token",
      HttpHeaders.acceptHeader:"application/json"
    });
    return handleResponse(response);
  }

  static Future<Map<String, dynamic>> postData(final String url,Map<String,dynamic> body) async {
    try {
      String token = "28|jnOAf06U0bJeOpkUE41iqii7vHvQtQwBHRgXHWJY";
      final response = await http.post(Uri.parse(url),
          body: body,
          headers: {
            HttpHeaders.authorizationHeader:"Bearer $token",
            HttpHeaders.acceptHeader:"application/json"
          });
      return handleResponse(response);
    } on SocketException catch (e) {
      throw AppException(message: "no internet connection",statusCode:-1) ;
    }
  }

  static handleResponse(http.Response response) {
    var json;
    try{
      print("body");
      print(response.body);
      json = jsonDecode(response.body);
      print("json");
      print(json);
    }catch(e){
      throw AppException(message: "not json",statusCode:response.statusCode) ;
    }
    switch (response.statusCode){
      case 200:
      case 201:
        return json;
      case 401:
        throw AppException(message: json["message"]??"unauthorized",statusCode:401 ) ;
      case 404:
        throw AppException(message: json["message"]??"not found",statusCode:404 ) ;
      case 500:
        throw AppException(message: json["message"]??"server error",statusCode:500 ) ;
      default:
        throw AppException(message: json["message"]??"unknown error",statusCode:response.statusCode ) ;
    }
  }

}

class AppException implements Exception {
  final String message;
  final int statusCode;

  AppException({this.message = "", required this.statusCode});

  @override
  String toString() {
    return message;
  }
}