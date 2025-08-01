abstract class IHttpService {
  Future<Map<String, dynamic>?> restRequest({
    required String url,
    required HttpMethodsEnum method,
    Map<String, dynamic>? headers,
    dynamic body,
    Map<String, dynamic>? query,
  });
}

enum HttpMethodsEnum {
  post('POST'),
  get('GET'),
  put('PUT'),
  delete('DELETE'),
  patch('PATCH');

  final String str;
  const HttpMethodsEnum(this.str);
}
