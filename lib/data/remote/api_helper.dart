import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http_clint;
import 'package:sales/domain/constents/app_pref.dart';

import '../../domain/constents/exception.dart';

class ApiHelper {

  Future<dynamic> getApi({
    required String url
  }) async {
    var uri = Uri.parse(url);
    String token = await AppPref().getToken();

    try {
      var res = await http_clint.get(uri,
          headers: {
            "Authorization" : "Bearer $token"
          });
      return returnJsonResponse(res);
    } on SocketException catch (e) {
      FetchDataException(errorMsg: "Internet Not Found $e");
    }
  }
  Future<dynamic> postApi({
    required String url,
    bool isHeaderRequired = false,
    Map<String, dynamic>? mData,
  }) async {
    var uri = Uri.parse(url);
    String token = "";
    if(isHeaderRequired){
      token = await AppPref().getToken();
    }
    try {
      var res = await http_clint.post(uri,
          body: mData,
          headers: isHeaderRequired ? {
        "Authorization" : "Bearer $token"
      } : {});
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
        if(mData['status']){
          return JsonResponse(status: mData['status'], message: mData['message'], token: mData['tokan']);
        } else {
          throw BadResponseException(errorMsg: mData['message']);
        }
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

class JsonResponse {
  bool? status;
  String? message;
  String? token;
  JsonResponse({required this.status, required this.message, required this.token});
}
