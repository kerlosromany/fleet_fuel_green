import 'package:dio/dio.dart';
import 'package:magdsoft_flutter_structure/constants/end_points.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseURL,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData(
      {required String url, Map<String, dynamic>? query , String? token , bool isMultipart = false}) async {
       dio!.options.headers = {
      if (isMultipart) 'Content-Type': 'multipart/form-data',
      if (!isMultipart) 'Content-Type': 'application/json',
      if (!isMultipart) 'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
      'appKey': 524,
    };
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required  body,
    String? token,
    bool isMultipart = false
  }) async {
    dio!.options.headers = {
      if (isMultipart) 'Content-Type': 'multipart/form-data',
      if (!isMultipart) 'Content-Type': 'application/json',
      if (!isMultipart) 'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
      'appKey': 524,
    };
    return await dio!.post(url, data: body);
  }

  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? qury,
    String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Accept' : 'application/json',
      'appKey' : 524,
      'Authorization': token ?? '',
    };
    return await dio!.put(
      url,
      data: data,
      queryParameters: qury,
    );
  }

}