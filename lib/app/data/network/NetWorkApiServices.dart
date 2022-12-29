// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:movie_hub/app/data/app_exceptions/app_exceptions.dart';

import 'BaseApiServices.dart';

import 'package:http/http.dart ' as http;

class NetWorkApiServices extends BaseApiService {
  @override
  Future getGetResponse(String url) async {
    dynamic responseJson;

    try {
      final response =
          await http.get(Uri.parse(url)).timeout(Duration(seconds: 5));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataExceptions("No Internet Connection...!");
    }

    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

      case 400:
        throw BadRequestExceptions(
            "Wrong Url Error${response.statusCode.toString()}");

      default:
        throw FetchDataExceptions(
            "Server Error${response.statusCode.toString()}");
    }
  }
}
