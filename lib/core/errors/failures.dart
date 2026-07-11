sealed class Failures implements Exception {
  final String message;
  final String? debugMessage;
  final int? statusCode;
  final StackTrace? stackTrace;
  final dynamic metaData;
  final bool hasErrorKey;

  const Failures(
    this.message, {
    this.statusCode,
    this.debugMessage,
    this.stackTrace,
    this.metaData,
    this.hasErrorKey = false,
  });

  @override
  String toString() => message;

  bool get hasMetaData {
    if (metaData == null) return false;
    if (metaData is Map) return (metaData as Map).isNotEmpty;
    if (metaData is List) return (metaData as List).isNotEmpty;
    return true;
  }

  bool get shouldShowToast => !(hasErrorKey && hasMetaData);
}

class NetworkFailure extends Failures {
  NetworkFailure([String? message])
    : super(message ?? "Check your internet connection");

  NetworkFailure.withDebug({
    String? message,
    String? debugMessage,
    StackTrace? stackTrace,
  }) : super(
         message ?? "Check your internet connection",
         debugMessage: debugMessage,
         stackTrace: stackTrace,
       );
}

class TimeoutFailure extends Failures {
  TimeoutFailure([String? message])
    : super(message ?? "Request timed out, please try again");

  TimeoutFailure.withDebug({
    String? message,
    String? debugMessage,
    StackTrace? stackTrace,
  }) : super(
         message ?? "Request timed out, please try again",
         debugMessage: debugMessage,
         stackTrace: stackTrace,
       );
}

class ServerFailure extends Failures {
  ServerFailure([String? message])
    : super(message ?? "Server error, try again later");

  ServerFailure.withDebug({
    String? message,
    int? statusCode,
    String? debugMessage,
    StackTrace? stackTrace,
    dynamic metaData,
    bool hasErrorKey = false,
  }) : super(
         message ?? "Server error, try again later",
         statusCode: statusCode,
         debugMessage: debugMessage,
         stackTrace: stackTrace,
         metaData: metaData,
         hasErrorKey: hasErrorKey,
       );
}

class UnauthorizedFailure extends Failures {
  UnauthorizedFailure([String? message]) : super(message ?? "Session expired");

  UnauthorizedFailure.withDebug({
    String? message,
    int? statusCode,
    String? debugMessage,
    StackTrace? stackTrace,
    bool hasErrorKey = false,
  }) : super(
         message ?? "Session expired",
         statusCode: statusCode,
         debugMessage: debugMessage,
         stackTrace: stackTrace,
         hasErrorKey: hasErrorKey,
       );
}

class ForbiddenFailure extends Failures {
  ForbiddenFailure([String? message])
    : super(message ?? "You do not have permission");

  ForbiddenFailure.withDebug({
    String? message,
    int? statusCode,
    String? debugMessage,
    StackTrace? stackTrace,
    bool hasErrorKey = false,
  }) : super(
         message ?? "You do not have permission",
         statusCode: statusCode,
         debugMessage: debugMessage,
         stackTrace: stackTrace,
         hasErrorKey: hasErrorKey,
       );
}

class ConflictFailure extends Failures {
  ConflictFailure([String? message]) : super(message ?? "Data conflict occurred");

  ConflictFailure.withDebug({
    String? message,
    int? statusCode,
    String? debugMessage,
    StackTrace? stackTrace,
    bool hasErrorKey = false,
  }) : super(
         message ?? "Data conflict occurred",
         statusCode: statusCode,
         debugMessage: debugMessage,
         stackTrace: stackTrace,
         hasErrorKey: hasErrorKey,
       );
}

class NotFoundFailure extends Failures {
  NotFoundFailure([String? message]) : super(message ?? "Content not found");

  NotFoundFailure.withDebug({
    String? message,
    int? statusCode,
    String? debugMessage,
    StackTrace? stackTrace,
    bool hasErrorKey = false,
  }) : super(
         message ?? "Content not found",
         statusCode: statusCode,
         debugMessage: debugMessage,
         stackTrace: stackTrace,
         hasErrorKey: hasErrorKey,
       );
}

class ValidationFailure extends Failures {
  ValidationFailure([String? message])
    : super(message ?? "Please check your input and try again");

  ValidationFailure.withDebug({
    String? message,
    int? statusCode,
    String? debugMessage,
    StackTrace? stackTrace,
    dynamic metaData,
    bool hasErrorKey = false,
  }) : super(
         message ?? "Please check your input and try again",
         statusCode: statusCode,
         debugMessage: debugMessage,
         stackTrace: stackTrace,
         metaData: metaData,
         hasErrorKey: hasErrorKey,
       );
}

class UnexpectedFailure extends Failures {
  UnexpectedFailure([String? message])
    : super(message ?? "Unexpected error occurred");

  UnexpectedFailure.withDebug({
    String? message,
    int? statusCode,
    String? debugMessage,
    StackTrace? stackTrace,
    bool hasErrorKey = false,
  }) : super(
         message ?? "Unexpected error occurred",
         statusCode: statusCode,
         debugMessage: debugMessage,
         stackTrace: stackTrace,
         hasErrorKey: hasErrorKey,
       );
}
