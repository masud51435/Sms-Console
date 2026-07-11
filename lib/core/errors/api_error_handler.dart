import 'package:dio/dio.dart';

import '../utils/logger/app_logger.dart';
import '../utils/snackbar/toast_service.dart';
import 'dio_exception_handler.dart';
import 'failures.dart';

class ApiErrorHandler {
  ApiErrorHandler._();

  static Never handle(
    Object error,
    StackTrace stackTrace, {
    String? context,
    Response? response,
  }) {
    if (error is DioException) {
      final failure = error.error;
      if (failure is Failures) {
        throw failure;
      }
      throw DioExceptionHandler.handle(error);
    }

    String debugMsg = error.toString();
    if (error is TypeError) {
      debugMsg = 'Type Mismatch: ${error.toString()}';
    }

    final failure = UnexpectedFailure.withDebug(
      message: debugMsg,
      debugMessage: debugMsg,
      stackTrace: stackTrace,
    );

    AppLogger.exception(
      failure,
      stackTrace: stackTrace,
      context:
          '${context ?? 'Unknown Context'}\nResponse Data: ${response?.data}',
    );

    // Show toast for unexpected system errors
    ToastService.showError(failure.message);

    throw failure;
  }
}
