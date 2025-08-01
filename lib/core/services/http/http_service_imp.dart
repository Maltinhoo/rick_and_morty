import 'dart:io';

import 'package:rick_and_morty/app_imports.dart';

class HttpServiceImp implements IHttpService {
  final Dio _dio;

  const HttpServiceImp(this._dio);

  @override
  Future<Map<String, dynamic>?> restRequest({
    required String url,
    required HttpMethodsEnum method,
    Map<String, dynamic>? headers,
    dynamic body,
    Map<String, dynamic>? query,
  }) async {
    try {
      final mergedHeaders = headers ?? {};
      _dio.options.headers.addAll(mergedHeaders);

      final response = await _dio.request(
        '${_dio.options.baseUrl}$url',
        options: Options(method: method.str),
        data: body,
        queryParameters: query,
      );

      final data = response.data;

      if (data is Map && data.containsKey('errors')) {
        final errors = data['errors'];
        final errorMessage = (errors is List && errors.isNotEmpty)
            ? errors.first['message'] ?? 'API returned an unknown error'
            : 'API returned errors';

        throw DataSourceUnknownError(
          exception: errors,
          stackTrace: StackTrace.current,
          message: errorMessage,
        );
      }

      if (data is Map<String, dynamic>) {
        return data;
      }

      throw DataSourceUnknownError(
        exception: data,
        message: 'Resposta inesperada: tipo inválido (${data.runtimeType})',
        stackTrace: StackTrace.current,
      );
    } on DioException catch (e, s) {
      if (e.error is SocketException) {
        throw DataSourceConnectionError(exception: e, stackTrace: s);
      }

      if (e.response?.statusCode == 401) {
        throw DataSourceUnauthorizedError(exception: e, stackTrace: s);
      }

      throw DataSourceUnknownError(
        exception: e,
        message: e.message,
        stackTrace: s,
        statusCode: e.response?.statusCode,
      );
    } catch (e, s) {
      throw DataSourceUnknownError(exception: e, stackTrace: s);
    }
  }
}

class DioFactory {
  static Dio create({List<Interceptor> interceptors = const []}) {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://rickandmortyapi.com/api/',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        responseType: ResponseType.json,
        validateStatus: (status) =>
            status != null && status >= 200 && status < 300,
      ),
    );

    dio.options.headers.addAll({
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    });

    dio.interceptors.addAll([
      CurlLoggerDioInterceptor(printOnSuccess: true),
      ...interceptors,
    ]);

    return dio;
  }
}
