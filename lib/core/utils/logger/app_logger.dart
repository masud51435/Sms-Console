import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../errors/failures.dart';

class AppLogger {
  AppLogger._();

  static void request({
    required String client,
    required String method,
    required Uri uri,
    Object? queryParameters,
    Object? body,
    Object? headers,
  }) {
    _printBlock(
      title: 'HTTP REQUEST',
      icon: '📤',
      accent: '$method ${uri.path}',
      lines: [
        'Client: $client',
        'URL: $uri',
        if (_hasValue(queryParameters))
          'Query:\n${_indent(_pretty(queryParameters))}',
        if (_hasValue(body)) 'Body:\n${_indent(_pretty(body))}',
        if (_hasValue(headers)) 'Headers:\n${_indent(_pretty(headers))}',
      ],
    );
  }

  static void response({
    required String client,
    required String method,
    required Uri uri,
    int? statusCode,
    Object? data,
  }) {
    _printBlock(
      title: 'HTTP RESPONSE',
      icon: '✅',
      accent: '$method ${uri.path}',
      lines: [
        'Client: $client',
        if (statusCode != null) 'HTTP Status: $statusCode',
        'URL: $uri',
        if (_hasValue(data)) 'Data:\n${_indent(_pretty(data))}',
      ],
    );
  }

  static void httpError({
    required String client,
    required String method,
    required Uri uri,
    int? statusCode,
    Object? data,
    String? message,
  }) {
    _printBlock(
      title: 'HTTP ERROR',
      icon: '❌',
      accent: '$method ${uri.path}',
      lines: [
        'Client: $client',
        if (statusCode != null) 'HTTP Status: $statusCode',
        'URL: $uri',
        if (_hasValue(message)) 'Message: $message',
        if (_hasValue(data)) 'Data:\n${_indent(_pretty(data))}',
      ],
    );
  }

  static void failure(Failures failure, {String? context}) {
    if (kDebugMode) {
      final debugMessage = _normalizeDebugMessage(failure.debugMessage);
      final stackPreview = _formatStackPreview(failure.stackTrace);
      _printBlock(
        title: 'FAILURE',
        icon: _emojiForFailure(failure),
        accent: '${_labelForFailure(failure)}: ${failure.message}',
        lines: [
          if (failure.statusCode != null) 'HTTP Status: ${failure.statusCode}',
          if (context != null) 'Where: $context',
          if (debugMessage != null) 'Why: $debugMessage',
          if (stackPreview != null) 'Stack:\n${_indent(stackPreview)}',
        ],
      );
    }
  }

  static void info(String message) {
    _printBlock(title: 'INFO', icon: 'ℹ️', accent: message);
  }

  static void warning(String message) {
    _printBlock(title: 'WARNING', icon: '⚠️', accent: message);
  }

  static void success(String message) {
    _printBlock(title: 'SUCCESS', icon: '✅', accent: message);
  }

  static void exception(
    Object error, {
    StackTrace? stackTrace,
    String? context,
  }) {
    _printBlock(
      title: 'EXCEPTION',
      icon: '💥',
      accent: error.toString(),
      lines: [
        if (context != null) 'Where: $context',
        if (stackTrace != null)
          'Stack:\n${_indent(_formatStackPreview(stackTrace) ?? stackTrace.toString())}',
      ],
    );
  }

  static String _labelForFailure(Failures failure) {
    if (failure is NetworkFailure) return 'Network issue';
    if (failure is TimeoutFailure) return 'Request timeout';
    if (failure is UnauthorizedFailure) return 'Unauthorized';
    if (failure is ForbiddenFailure) return 'Forbidden';
    if (failure is NotFoundFailure) return 'Not found';
    if (failure is ValidationFailure) return 'Validation failed';
    if (failure is ServerFailure) return 'Server error';
    return 'Unexpected error';
  }

  static String _emojiForFailure(Failures failure) {
    if (failure is NetworkFailure) return '📡';
    if (failure is TimeoutFailure) return '⏳';
    if (failure is UnauthorizedFailure) return '🔐';
    if (failure is ForbiddenFailure) return '⛔';
    if (failure is NotFoundFailure) return '🔎';
    if (failure is ValidationFailure) return '⚠️';
    if (failure is ServerFailure) return '🛠️';
    return '❗';
  }

  static String? _normalizeDebugMessage(String? debugMessage) {
    if (debugMessage == null) return null;

    if (debugMessage.contains('is not a subtype of type')) {
      return 'Type Mismatch: $debugMessage';
    }

    final lines = debugMessage
        .split('\n')
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();

    if (lines.isEmpty) return null;
    if (lines.length == 1) return lines.first;
    return '${lines.first}\n${lines.sublist(1, lines.length.clamp(1, 3)).map((line) => '  - $line').join('\n')}';
  }

  static String? _formatStackPreview(StackTrace? stackTrace) {
    if (stackTrace == null) return null;

    final lines = stackTrace
        .toString()
        .split('\n')
        .map((line) => line.trimRight())
        .where((line) => line.trim().isNotEmpty)
        .take(4)
        .toList();

    return lines.join('\n');
  }

  static void _printBlock({
    required String title,
    required String icon,
    required String accent,
    List<String> lines = const [],
  }) {
    if (!kDebugMode) return;

    debugPrint('');
    debugPrint('╔══════════ $title ══════════');
    debugPrint('║ $icon $accent');
    for (final line in lines.where((line) => line.trim().isNotEmpty)) {
      for (final part in line.split('\n')) {
        debugPrint('║ $part');
      }
    }
    debugPrint('╚════════════════════════════');
  }

  static bool _hasValue(Object? value) {
    if (value == null) return false;
    if (value is String) return value.trim().isNotEmpty;
    if (value is Map) return value.isNotEmpty;
    if (value is Iterable) return value.isNotEmpty;
    return true;
  }

  static String _pretty(Object? value) {
    if (value == null) return '';
    if (value is FormData) {
      final data = <String, dynamic>{
        'fields': {for (final field in value.fields) field.key: field.value},
        'files': {
          for (final file in value.files) file.key: file.value.filename,
        },
      };
      return _pretty(data);
    }
    if (value is String) return value;
    try {
      const encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(value);
    } catch (_) {}
    return value.toString();
  }

  static String _indent(String value) {
    return value.split('\n').map((line) => '  $line').join('\n');
  }
}
