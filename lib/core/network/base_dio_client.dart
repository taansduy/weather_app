import 'package:dio/dio.dart';
class BaseDioClient {
  late final Dio dio;

  BaseDioClient(String baseUrl,
      {Duration? connectTimeout,
      Duration? receiveTimeout,
      Duration? sendTimeout,
      List<Interceptor>? interceptors})
      : dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: connectTimeout ?? Duration(seconds: 10),
          receiveTimeout: receiveTimeout ?? Duration(seconds: 10),
          sendTimeout: sendTimeout ?? Duration(seconds: 10),
        )) {
    dio.interceptors.addAll(interceptors ?? []);
  }

  Future<Response<T>> get<T>(String path, {Map<String, dynamic>? queryParams}) {
    return dio.get<T>(path, queryParameters: queryParams);
  }

  Future<Response<T>> post<T>(String path, {dynamic data}) {
    return dio.post<T>(path, data: data);
  }

}
