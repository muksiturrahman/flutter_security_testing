import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class BaseClient {
  //GET
  static const TIME_OUT = 30;
  static const TIME_OUT_FILE = 300;

  get httpClient => null;

  Future<dynamic> postMethod(String api, Map body) async {
    var url = Uri.parse(api);

    Map bodyMap = body;
    try {
      var response = await http
          .post(url, body: bodyMap)
          .timeout(Duration(seconds: TIME_OUT));
      print(response);
      return _processResponse(response);
    } on SocketException {
      print('No Internet connection');
    } on TimeoutException {
      print('Api not responding');
    } catch (e) {
      print('Unknown error ' + e.toString());
    }
  }

  Future<dynamic> postMethodWithHeader(
      String api, Map body, Map<String, String> headerMap) async {
    var url = Uri.parse(api);

    final bodyMap = jsonEncode(body);
    try {
      var response = await http
          .post(url, headers: headerMap, body: bodyMap)
          .timeout(Duration(seconds: TIME_OUT));
      print(response.toString());
      return _processResponse(response);
    } on SocketException {
      print('No Internet connection');
    } on TimeoutException {
      print('Api not responding');
    } catch (e) {
      print('Unknown error ' + e.toString());
    }
  }

  Future<dynamic> initPostWithHeader(
      String api, Map body, Map<String, String> headerMap) async {
    var url = Uri.parse(api);

    // final bodyMap = jsonEncode(body);
    Map bodyMap = body;

    try {
      var response = await http
          .post(url, headers: headerMap, body: bodyMap)
          .timeout(Duration(seconds: TIME_OUT));
      print(response.toString());
      return _processResponse(response);
    } on SocketException {
      print('No Internet connection');
    } on TimeoutException {
      print('Api not responding');
    } catch (e) {
      print('Unknown error ' + e.toString());
    }
  }

  Future<dynamic> getMethodWithoutHeader(String baseUrl) async {
    var url = Uri.parse(baseUrl);
    try {
      final response = await http.get(url);
      return _processResponse(response);
    } on SocketException {
      print('No Internet connection');
      return "{\"errorMessage\":\"No Internet connection\"}";
    } on TimeoutException {
      print('Api not responding');
      return "{\"errorMessage\":\"Api not responding\"}";
    } catch (e) {
      print('Unknown error ' + e.toString());
    }
  }

  dynamic _processResponse(http.Response response) {
    if (response.statusCode == 200) {
      var responseJson = utf8.decode(response.bodyBytes);

      //var responseJson =response.body;
      print(responseJson);
      return responseJson;
    } else {
      print(response.statusCode);

      return null;
    }
  }

  /***
   * files should be created by ---
   * http.MultipartFile(
      'profile_photo', /// Field name on the server
      profile_photo!.readAsBytes().asStream(), /// File stream
      profile_photo.lengthSync(), /// File length in bytes
      filename: 'profile_photo.jpg',
      )
   */
  Future<dynamic> initPostWithFilesMultipart(
      String api,
      Map<String, String> headerMap,
      Map<String, String> body,
      List<http.MultipartFile> files) async {
    final request = http.MultipartRequest('POST', Uri.parse(api))
      ..fields.addAll(body)
      ..headers.addAll(headerMap)
      ..headers["Content-Type"] = 'multipart/form-data;charset=utf-8';

    // request.files.add(http.MultipartFile(
    //   'profile_photo', // Field name on the server
    //   profile_photo!.readAsBytes().asStream(), // File stream
    //   profile_photo.lengthSync(), // File length in bytes
    //   filename: 'profile_photo.jpg',
    // ));

    request.files.addAll(files);

    try {
      var res = await request.send().timeout(Duration(seconds: TIME_OUT_FILE));
      print(res.toString());
      return _processFileUploadResponse(res);
    } on SocketException {
      print('No Internet connection');
    } on TimeoutException catch (e) {
      print('Api not responding' + e.toString());
    } catch (e) {
      print('Unknown error ' + e.toString());
    }
  }

  dynamic _processFileUploadResponse(StreamedResponse response) {
    if (response.statusCode == 200) {
      var responseJson = response.stream.bytesToString();

      //var responseJson =response.body;
      print(responseJson);
      return responseJson;
    } else if (response.statusCode == 201) {
      var responseJson = response.stream.bytesToString();

      print(responseJson);
      return responseJson;
    } else if (response.statusCode == 422) {
      var responseJson = response.stream.bytesToString();

      print(responseJson);
      return responseJson;
    } else {
      var responseJson = response.stream.bytesToString();
      return getHttpResponseMessage(response.statusCode);
    }
  }

  String getHttpResponseMessage(int statusCode) {
    switch (statusCode) {
      case 200:
        return 'Success';
      case 201:
        return 'Created';
      case 204:
        return 'No Content';
      case 400:
        return 'Bad Request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return 'Not Found';
      case 500:
        return 'Internal Server Error';
      default:
        return 'Unknown Error: The status code is $statusCode';
    }
  }

  Future<dynamic> initGetWithoutHeader(String baseUrl) async {
    var url = Uri.parse(baseUrl);
    try {
      final response = await http.get(url);
      return _processResponse(response);
    } on SocketException {
      print('No Internet connection');
      return "{\"errorMessage\":\"No Internet connection\"}";
    } on TimeoutException {
      print('Api not responding');
      return "{\"errorMessage\":\"Api not responding\"}";
    } catch (e) {
      print('Unknown error ' + e.toString());
    }
  }

  Future<dynamic> initGetWithHeader(
      String api, Map<String, String> headerMap) async {
    var url = Uri.parse(api);
    try {
      var response = await http
          .get(url, headers: headerMap)
          .timeout(Duration(seconds: TIME_OUT));
      print(response.toString());
      return _processResponse(response);
    } on SocketException {
      print('No Internet connection');
    } on TimeoutException catch (e) {
      print('Api not responding' + e.toString());
    } catch (e) {
      print('Unknown error ' + e.toString());
    }
  }

}
