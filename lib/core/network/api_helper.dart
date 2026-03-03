import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';
import 'package:flutter/foundation.dart';
import 'api_utilities.dart';
import 'base.api.dart';
import 'base_url.dart';


class ApiHelper {
  final Dio _dio;

  ApiHelper(this._dio);

  Future<NetworkResponse<T>> apiCall<T,V>({
        Map<String, dynamic>? queryParameters,
        V?  body,
        required API api,
        Map<String, String>? headers,
        String? pathParam,
        T Function(Map<String, dynamic>)? mapper,
      }) async {

    late Response result;
   if(kDebugMode){
   if(body != null) {
     var jsonBody = (body is String) ? body : (body is List)
    ? body
    : (body as dynamic).toJson?.call();
log(' request body: $jsonBody');
   }}
    try {
      final options = RequestOptions(
        baseUrl: _dio.options.baseUrl,
        headers: {
          ...getHeaders(sessionToken: ''),//will get session token from static method get value from secure storage
          ...?headers,
          ..._dio.options.headers,
        },
        method: api.method.name,
        queryParameters: queryParameters,
        data: body,
        path: "${api.path}${pathParam!= null?"/$pathParam": ""}",
      );
      result =  await _dio.fetch(options);
      if (mapper != null && result.data is Map<String, dynamic>) {
        return NetworkResponse.success(mapper(result.data));
      }

      return NetworkResponse.success(result.data as T);
    } on DioException catch (error) {
      return NetworkResponse.error(error);
    }
  }
}
Dio createDio() {
  const timeOut = Duration(seconds: 30);
  String  baseURL = "${ServiceUrl().baseUrl}/";
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
