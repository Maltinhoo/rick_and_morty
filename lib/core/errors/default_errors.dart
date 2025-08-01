abstract class IDefaultException implements Exception {
  final String? message;
  final StackTrace? stackTrace;
  final Object exception;
  final int? statusCode;

  const IDefaultException(
    this.message,
    this.exception, [
    this.stackTrace,
    this.statusCode,
  ]);

  @override
  String toString() {
    return message ?? 'An unknown error occurred, please try again later!';
  }
}

class DataSourceUnknownError extends IDefaultException {
  DataSourceUnknownError({
    Object? exception,
    String? message,
    StackTrace? stackTrace,
    int? statusCode,
  }) : super(
          message ?? 'Unknown error',
          exception ?? Exception(),
          stackTrace,
          statusCode,
        );
}

class DataSourceConnectionError extends IDefaultException {
  DataSourceConnectionError({
    Object? exception,
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message ?? 'Connection error',
          exception ?? Exception(),
          stackTrace,
        );
}

class DataSourceUnauthorizedError extends IDefaultException {
  DataSourceUnauthorizedError({
    Object? exception,
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message ?? 'Unauthorized',
          exception ?? Exception(),
          stackTrace,
        );
}
