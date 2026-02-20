import 'package:dio/dio.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';
import 'api_utilities.dart';


class ApiHelper {
  final Dio _dio;

  ApiHelper(this._dio);

  Future<NetworkResponse> apiCall<T>(
      String url, {
       Map<String, dynamic>? queryParameters,
        Map<String, dynamic>?  body,
        String? sessionToken,
        required RequestType requestType,
        Map<String, String>? headers,
        T Function(Map<String, dynamic>)? mapper,
      }) async {

    late Response result;

    try {
      final options = Options(
        headers: {
          ...getHeaders(sessionToken: sessionToken),
          ...?headers,
        },
      );
      switch (requestType) {
        case RequestType.get:
          result = await _dio.get(url,
              queryParameters: queryParameters, options: options);
          break;

        case RequestType.post:
          result =
          await _dio.post(url, data: body, options: options,);
          break;

        case RequestType.put:
          result =
          await _dio.put(url, data: body, options: options);
          break;

        case RequestType.delete:
          result =
          await _dio.delete(url, data: body, options: options);
          break;

        case RequestType.patch:
          result =
          await _dio.patch(url, data: body, options: options);
          break;
      }
      if (mapper != null && result.data is Map<String, dynamic>) {
        return NetworkResponse.success(mapper(result.data));
      }

      return NetworkResponse.success(result.data);
    } on DioException catch (error) {
      return NetworkResponse.error(error);
    }
  }
}
Dio createDio() {
  const timeOut = Duration(seconds: 20);
  const baseURL = "https://dummyjson.com/";
  final dio = Dio(BaseOptions(
    baseUrl: baseURL,
    receiveTimeout: timeOut,
    connectTimeout: timeOut,
    sendTimeout: timeOut,
    headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    },
  ));

  dio.interceptors.addAll([
    AuthInterceptor(dio),
    ErrorInterceptors(dio),
    HttpFormatter(
      includeResponseHeaders: false,
      loggingFilter: (request, response, error) => true,
    ),
  ]);

  return dio;
}
class NetworkResponse<T>  {
  T ? data;
  dynamic error;
  NetworkResponse({this.data, this.error});
  NetworkResponse.success(this.data);
  NetworkResponse.error(this.error);
  NetworkResponse.loading();
  maybeWhen({required Function(T? data) ok,required Function(dynamic error) onError,}) {
    if(isSuccess) {
      ok(data);
    }
    if(isError) {
      onError(error);
    }
  }

  bool get isLoading => error == null && data == null;
  bool get isSuccess => data != null;
  bool get isError => error != null;
}
