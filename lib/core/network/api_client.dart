import 'method_types.dart';

abstract class ApiClient {
  Future<T> request<T>({
    required String path,
    required MethodType method,
    Object? payload,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    T Function(Map<String, dynamic> json)? parse,
    T Function(List<dynamic> json)? parseList,
  });
}
