// import 'dart:convert';

// import 'package:dio/dio.dart';

// class AppClient {
//   late Dio _dio;
//   late Dio _dioAuthen;

//   final BaseOptions baseOptions = BaseOptions(
//       baseUrl: AppConstant.baseApiUrl,
//       connectTimeout: const Duration(seconds: 20),
//       receiveTimeout: const Duration(seconds: 20),
//       contentType: 'application/json');

//   AppClient() {
//     _dio = Dio(baseOptions);
//     _dioAuthen = Dio(baseOptions);

//     Future<Response> getDioAuth(
//         {String endPoint = '',
//         Map<String, dynamic> queryParameters = const {},
//         String accessToken = ''}) {
//       _dioAuthen.options.headers["Authorization"] = "Bearer $accessToken";
//       return _dioAuthen.get(endPoint, queryParameters: queryParameters);
//     }

//     Future<Response> getDio(
//         {String endPoint = '',
//         Map<String, dynamic> queryParameters = const {}}) {
//       return _dio.get(endPoint, queryParameters: queryParameters);
//     }

//     Future<Response> postDioAuth(
//         {String endPoint = '', String accessToken = '', dynamic data}) {
//       _dioAuthen.options.headers["Authorization"] = "Bearer $accessToken";
//       return _dioAuthen.post(endPoint, data: jsonEncode(data));
//     }

//     Future<Response> postDio(String endPoint, {dynamic data}) {
//       return _dio.post(endPoint, data: jsonEncode(data));
//     }
//   }
// }
