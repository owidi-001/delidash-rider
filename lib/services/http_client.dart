import 'package:dio/dio.dart';
import 'package:rider/domain/exception.dart';
import 'package:rider/routes/app_router.dart';
import 'package:rider/utility/shared_preference.dart';


class HttpClient {
  static Dio dio = Dio(BaseOptions(baseUrl: baseURL))
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: ((options, handler) async {
          String token = await UserPreferences().getToken();
          if (token.isNotEmpty) {
            options.headers["Authorization"] = "Token $token";
          }
          return handler.next(options);
        }),
      ),
    );
  // get
  static Future<Response> get(String url) {
    return dio.get(url);
  }

  // post
  static Future<Response> post(String url, dynamic data) {
    return dio.post(url, data: data);
  }

  static Future<Response> put(String url, dynamic data) {
    return dio.put(url, data: data);
  }

  // post
  static Future<HttpResult<T>> post2<T>(
    String url, {
    dynamic data,
    T Function(dynamic data)? der,
  }) async {
    try {
      final results = await HttpClient.post(    
        url,
        data,
      );

      return HttpResult.success(
        der != null ? der(results.data) : results.data,
      );
    } catch (e) {
      return HttpResult.error(getException(e));
    }
  }

   // put
  static Future<HttpResult<T>> put2<T>(
    String url, {
    dynamic data,
    T Function(dynamic data)? der,
  }) async {
    try {
      final results = await HttpClient.put(    
        url,
        data,
      );

      return HttpResult.success(
        der != null ? der(results.data) : results.data,
      );
    } catch (e) {
      return HttpResult.error(getException(e));
    }
  }

  // get
  static Future<HttpResult<T>> get2<T>(
    String url, {
    T Function(dynamic data)? der,
  }) async {
    try {
      final results = await HttpClient.get(url);

      return HttpResult.success(
        der != null ? der(results.data) : results.data,
      );
    } catch (e) {
      return HttpResult.error(getException(e));
    }
  }
}
