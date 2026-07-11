import 'package:dio/dio.dart';

import '../errors/api_error_handler.dart';
import 'api_client.dart';
import 'api_interceptors.dart';
import 'method_types.dart';

class DioClient implements ApiClient {
  late Dio _client;

  DioClient({
    required String baseUrl,
    String tag = 'Dio',
    Future<String?> Function()? tokenProvider,
    Future<String?> Function()? tenantIdProvider,
    Future<bool> Function()? onRefreshToken,
  }) {
    _client = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        followRedirects: false,
      ),
    );

    _client.interceptors.add(
      AppInterceptor(
        tag: tag,
        tokenProvider: tokenProvider,
        tenantIdProvider: tenantIdProvider,
        onRefreshToken: onRefreshToken,
        dio: _client,
      ),
    );
  }

  @override
  Future<T> request<T>({
    required String path,
    required MethodType method,
    Object? payload,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    T Function(Map<String, dynamic> json)? parse,
    T Function(List<dynamic> json)? parseList,
  }) async {
    Response? response;
    try {
      response = await _client.request(
        path,
        data: payload,
        queryParameters: queryParams,
        options: Options(method: method.name.toUpperCase(), headers: headers),
      );

      return _parseResponse(response, parse, parseList);
    } catch (e, stackTrace) {
      ApiErrorHandler.handle(
        e,
        stackTrace,
        context: 'Request: ${method.name.toUpperCase()} -> $path',
        response: response,
      );
    }
  }

  T _parseResponse<T>(
    Response response,
    T Function(Map<String, dynamic> json)? parse,
    T Function(List<dynamic> json)? parseList,
  ) {
    final data = response.data;
    if (data is List && parseList != null) {
      return parseList(data);
    } else if (data is Map && parse != null) {
      return parse(data as Map<String, dynamic>);
    } else {
      return data as T;
    }
  }
}
