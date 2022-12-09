import 'dart:io';

import 'package:dio/dio.dart';

import '../common/utils/logger.dart';
import 'dio_connectivity_request_retrier.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  final DioConnectivityRequestRetrier requestRetrier;

  RetryOnConnectionChangeInterceptor({
    required this.requestRetrier,
  });

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      try {
        return requestRetrier.scheduleRequestRetry(err.requestOptions);
      } catch (e) {
        // Let any new error from the retrier pass through
        return e;
      }
    }
    // Let the error pass through if it's not the error we're looking for
    return err;
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log.fine('onRequest: ${options.method}');
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log.fine('onResponse: ${response.data}');
  }

  bool _shouldRetry(DioError err) {
    return err.type == DioErrorType.other && err.error != null && err.error is SocketException;
  }
}
