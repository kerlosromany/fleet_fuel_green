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
      {required String url, Map<String, dynamic>? query , String? token}) async {
        dio!.options.headers = {
      'Content-Type': 'application/json',
      'Accept' : 'application/json',
      'appKey' : 524,
      'Authorization': token ?? '',
    };
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> body,
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Accept' : 'application/json',
      'appKey' : 524,
      'Authorization': token ?? '',
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