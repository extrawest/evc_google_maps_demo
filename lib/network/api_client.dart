import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

import '../common/services/secure_cache.dart';
import '../common/utils/logger.dart';

import 'network.dart';

const String headerAccessToken = 'Authorization';

abstract class ApiClient {
  Future<dynamic> get(String url, {Map<String, String>? addHeaders, Map<String, String>? params});

  Future<dynamic> post(String url, String jsonBody,
      {Map<String, String>? addHeaders, Map<String, String>? params});
}

class ApiClientImpl extends ApiClient with SecureStorageMixin {
  late Dio _dio;
  final String apiDomain;

  final headers = <String, String>{'Content-type': 'application/json'};

  //todo: add refresh token feature https://stackoverflow.com/a/68409485/3473445
  ApiClientImpl({required this.apiDomain}) {
    _dio = Dio(BaseOptions(baseUrl: apiDomain));
    // _dio.interceptors.add(
    //   RetryOnConnectionChangeInterceptor(
    //     requestRetrier: DioConnectivityRequestRetrier(
    //       dio: _dio,
    //       connectivity: Connectivity(),
    //     ),
    //   ),
    // );
  }

  @override
  Future<dynamic> get(
    String url, {
    Map<String, String>? addHeaders,
    Map<String, String>? params,
  }) async {
    dynamic responseJson;
    final updatedHeaders = await _setupHeaders(headers);
    try {
      log.fine('[HTTP GET REQUEST: $url, headers: $updatedHeaders]');
      final Response response = await _dio.get(
        url,
        queryParameters: params,
        options: Options(headers: updatedHeaders),
      );
      log.fine('[HTTP GET RESPONSE: $url, ${response.data}]');
      responseJson = _response(response);
      log.fine('responseJson $responseJson');
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on DioError catch (e) {
      log.fine('DioError error e: $e');
    }
    return responseJson;
  }

  @override
  Future<dynamic> post(
    String url,
    String jsonBody, {
    Map<String, String>? addHeaders,
    Map<String, String>? params,
  }) async {
    dynamic responseJson;
    final updatedHeaders = await _setupHeaders(headers);

    try {
      log.fine('[HTTP POST REQUEST: $url, headers: $updatedHeaders]');
      final Response response = await _dio.post(
        url,
        queryParameters: params,
        options: Options(headers: updatedHeaders),
        data: jsonEncode(params),
      );
      log.fine('[HTTP POST RESPONSE: $url, ${response.data}]');

      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on DioError catch (e) {
      log.fine('DioError error e: $e');
    }
    return responseJson;
  }

  Future<Map<String, dynamic>?> put(
    String url, {
    Map<String, String>? headers,
    Map<String, String>? params,
  }) async {
    dynamic responseJson;
    final updatedHeaders = await _setupHeaders(headers);
    try {
      log.fine('[HTTP PUT REQUEST: $url, headers: $updatedHeaders]');
      final response = await _dio.put(
        url,
        queryParameters: params,
        options: Options(headers: updatedHeaders),
        data: jsonEncode(params),
      );
      log.fine('[HTTP PUT RESPONSE: $url, headers: $updatedHeaders, body: ${response.data}]');
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<Map<String, String>> _setupHeaders(Map<String, String>? newHeaders) async {
    final updatedHeaders = <String, String>{};

    updatedHeaders.addAll(headers);
    if (newHeaders != null) {
      updatedHeaders.addAll(newHeaders);
    }

    final authToken = await readAuthToken();
    log.fine('cached authToken $authToken');
    if (authToken != null) {
      updatedHeaders.addAll({headerAccessToken: 'Bearer $authToken'});
    }
    return updatedHeaders;
  }

  dynamic _response(Response response) {
    log.fine('response.statusCode ${response.statusCode}');
    switch (response.statusCode) {
      case 200:
        final responseJson = response.data;
        log.fine('responseJson $responseJson');
        return responseJson;
      case 400:
        throw BadRequestException(response.data);
      case 401:
      case 403:
        throw UnauthorisedException(response.data);
      case 500:

      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
