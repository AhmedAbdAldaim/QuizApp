import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static initDio() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://quizu.okoul.com/', receiveDataWhenStatusError: true));
  }

  static Future<Response> getData(
      {required String path,
       Map<String, dynamic>? query,
       String? token 
       }) async {
    dio.options.headers = {
      'Authorization': token
    };
    return await dio.get(path, queryParameters: query);
  }

  static Future<Response> postData(
      {required String path,
      Map<String, dynamic>? data,
       Map<String, dynamic>? query,
       String? token 
       }) async {
    dio.options.headers = {
      'Authorization': token
    };
    return await dio.post(path, queryParameters: query, data: data);
  }


}
