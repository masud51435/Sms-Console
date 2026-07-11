import 'package:dio/dio.dart';

import 'failures.dart';

class DioExceptionHandler {
  static Failures handle(DioException e) {
    final response = e.response;
    final statusCode = response?.statusCode;
    final data = response?.data;

    String? serverMessage;
    dynamic metaData;
    bool hasErrorKey = false;

    if (data is Map<String, dynamic>) {
      final errorData = data['error'];
      if (errorData is Map<String, dynamic>) {
        serverMessage = errorData['message'] ?? errorData['code'];
      } else {
        serverMessage = data['message'] ?? errorData;
      }

      metaData = data['errors'] ?? data['data'];
      hasErrorKey = data.containsKey('message') || data.containsKey('error');
    }

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutFailure.withDebug(
          debugMessage: e.message,
          stackTrace: e.stackTrace,
        );

      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        return NetworkFailure.withDebug(
          debugMessage: e.message,
          stackTrace: e.stackTrace,
        );

      case DioExceptionType.badResponse:
        return _handleBadResponse(
          statusCode,
          serverMessage,
          metaData,
          e,
          hasErrorKey,
        );

      case DioExceptionType.cancel:
        return UnexpectedFailure.withDebug(
          message: 'Request cancelled',
          debugMessage: e.message,
        );

      default:
        return UnexpectedFailure.withDebug(
          message: 'Unexpected error occurred',
          debugMessage: e.message,
          stackTrace: e.stackTrace,
        );
    }
  }

  static Failures _handleBadResponse(
    int? statusCode,
    String? message,
    dynamic metaData,
    DioException e,
    bool hasErrorKey,
  ) {
    switch (statusCode) {
      case 400:
      case 422:
        return ValidationFailure.withDebug(
          message: message,
          statusCode: statusCode,
          metaData: metaData,
          debugMessage: e.message,
          stackTrace: e.stackTrace,
          hasErrorKey: hasErrorKey,
        );
      case 401:
        return UnauthorizedFailure.withDebug(
          message: message,
          statusCode: statusCode,
          debugMessage: e.message,
          stackTrace: e.stackTrace,
          hasErrorKey: hasErrorKey,
        );
      case 403:
        return ForbiddenFailure.withDebug(
          message: message,
          statusCode: statusCode,
          debugMessage: e.message,
          stackTrace: e.stackTrace,
          hasErrorKey: hasErrorKey,
        );
      case 404:
        return NotFoundFailure.withDebug(
          message: message,
          statusCode: statusCode,
          debugMessage: e.message,
          stackTrace: e.stackTrace,
          hasErrorKey: hasErrorKey,
        );
      case 409:
        return ConflictFailure.withDebug(
          message: message,
          statusCode: statusCode,
          debugMessage: e.message,
          stackTrace: e.stackTrace,
          hasErrorKey: hasErrorKey,
        );
      case 500:
      case 502:
      case 503:
        return ServerFailure.withDebug(
          message: message,
          statusCode: statusCode,
          debugMessage: e.message,
          stackTrace: e.stackTrace,
          hasErrorKey: hasErrorKey,
        );
      default:
        return UnexpectedFailure.withDebug(
          message: message,
          statusCode: statusCode,
          debugMessage: e.message,
          stackTrace: e.stackTrace,
          hasErrorKey: hasErrorKey,
        );
    }
  }
}
