import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:uber_pro_kolkata/services/app_exception.dart';

class NetworkApiService {
  static String baseUrl = "http://13.200.69.54";

  Future getGetApiResponse(String url, String token) async {
    dynamic responseJson;
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': "Token $token"
        },
      ).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  Future postApiResponse(String url, dynamic data, String token) async {
    log("URL $url   data $data");
    dynamic responseJson;
    try {
      Response response = await post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            'Authorization': "Token $token"
          },
          body: jsonEncode(data));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  Future registerApiResponse(String url, dynamic data) async {
    log("URL $url   data $data");
    dynamic responseJson;
    try {
      Response response = await post(Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  Future putApiResponse(String url, dynamic data, String token) async {
    log("URL $url   data $data");
    dynamic responseJson;
    try {
      Response response = await put(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': "Token $token"
        },
        body: jsonEncode(data),
      );

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  Future patchApiResponse(String url, dynamic data, String token) async {
    log("URL $url   data $data");
    dynamic responseJson;
    try {
      Response response = await patch(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': "Token $token"
        },
        body: jsonEncode(data),
      );

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 201:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

      //JUST DOING LIKE THAT DUE TO BACKEND DEVELOPER MISTAKE ...DEMO WITH CLIENT NO TIME TO MANAGE NOW
      case 400:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      // throw BadRequestException(response.body.toString());
      case 500:
      case 404:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException(
            'Error accured while communicating with server' +
                'with status code' +
                response.statusCode.toString());
    }
  }
}
