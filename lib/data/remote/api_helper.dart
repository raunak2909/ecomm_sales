import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http_clint;

import '../../domain/constents/exception.dart';

class ApiHelper {
  Future<dynamic> postApi({
    required String url,
    Map<String, dynamic>? mData,
  }) async {
    var uri = Uri.parse(url);
    try {
      var res = await http_clint.post(uri, body: mData);
      return returnJsonResponse(res);
    } on SocketException catch (e) {
      FetchDataException(errorMsg: "Internet Not Found $e");
    }
  }
}

dynamic returnJsonResponse(http_clint.Response res) {
  print(res.statusCode);
  print(res.body);
  switch (res.statusCode) {
    case 200:
      {
        var mData = jsonDecode(res.body);
        return JsonRespose(status: mData['status'], message: mData['message']);
      }
    case 400:
      throw BadRequestException(errorMsg: res.body.toString());
    case 401:
    case 403:
      throw UnauthorisedException(errorMsg: res.body.toString());
    case 500:
    default:
      throw FetchDataException(
          errorMsg: "error occurred while Communication  with server");
  }
}

class JsonRespose {
  String? status;
  String? message;
  JsonRespose({required this.status, required this.message});
}
