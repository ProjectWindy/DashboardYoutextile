
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../util/constants.dart';


class DioClient {
  late Dio _dio;
  static DioClient? _instance;

  factory DioClient() {
    _instance ??= DioClient._internal();
    return _instance!;
  }
  DioClient._internal() {
    _dio = Dio();
    BaseOptions options = BaseOptions(
      baseUrl: NetworkConstants.baseUrl,
      // connectTimeout: NetworkConstants.connectionTimeout,
      // receiveTimeout: NetworkConstants.receiveTimeout,
      contentType: 'application/json;',
          // ' multipart/form-data',
      responseType: ResponseType.json,
    );
    _dio = Dio(options);
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
      ));
    }
  }
  Dio get dio => _dio;
  Future<Response> get(String path, {Map<String, dynamic>? headers, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(
        path,
        options: Options(headers: headers),
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      if (kDebugMode) {
        print('DioException: ${e.message}');
      }
      if (e.response != null) {
        if (kDebugMode) {
          print('Error response data: ${e.response?.data}');
        }
      } else {
        if (kDebugMode) {
          print('Error request: ${e.requestOptions}');
        }
      }
      rethrow;
    } catch (e) {
      if (kDebugMode) {
        print('Other error: $e');
      }
      rethrow;
    }
  }

  Future<Response> post(String path, {Map<String, dynamic>? headers, Map<String, dynamic>? queryParameters, dynamic body}) async {
    try {
      final response = await _dio.post(
        path,
        options: Options(headers: headers),
        queryParameters: queryParameters,
        data: body,
      );
      return response;
    } on DioException catch (e) {
      if (kDebugMode) {
        print('DioException: ${e.message}');
      }
      if (e.response != null) {
        if (kDebugMode) {
          print('Error response data: ${e.response?.data}');
        }
      } else {
        if (kDebugMode) {
          print('Error request: ${e.requestOptions}');
        }
      }
      rethrow;
    } catch (e) {
      if (kDebugMode) {
        print('Other error: $e');
      }
      rethrow;
    }
  }
  Future<Response> put(String path, {Map<String, dynamic>? headers, Map<String, dynamic>? queryParameters, dynamic body}) async {
    try {
      final response = await _dio.put(
        path,
        options: Options(headers: headers),
        queryParameters: queryParameters,
        data: body,
      );
      return response;
    } on DioException catch (e) {
      if (kDebugMode) {
        print('DioException: ${e.message}');
      }
      if (e.response != null) {
        if (kDebugMode) {
          print('Error response data: ${e.response?.data}');
        }
      } else {
        if (kDebugMode) {
          print('Error request: ${e.requestOptions}');
        }
      }
      rethrow;
    } catch (e) {
      if (kDebugMode) {
        print('Other error: $e');
      }
      rethrow;
    }
  }
  Future<Response> postFormData(String path, Map<String, dynamic> data, {Map<String, dynamic>? headers, Map<String, dynamic>? queryParameters}) async {
    FormData formData = FormData.fromMap(data);

    try {
      final response = await _dio.post(
        path,
        options: Options(headers: headers),
        queryParameters: queryParameters,
        data: formData,
      );
      return response;
    } on DioException catch (e) {
      if (kDebugMode) {
        print('DioException: ${e.message}');
      }
      if (e.response != null) {
        if (kDebugMode) {
          print('Error response data: ${e.response?.data}');
        }
      } else {
        if (kDebugMode) {
          print('Error request: ${e.requestOptions}');
        }
      }
      rethrow;
    } catch (e) {
      if (kDebugMode) {
        print('Other error: $e');
      }
      rethrow;
    }
  }
  Future<Response> delete(String path, {Map<String, dynamic>? headers, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.delete(
        path,
        options: Options(headers: headers),
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      if (kDebugMode) {
        print('DioException: ${e.message}');
      }
      if (e.response != null) {
        if (kDebugMode) {
          print('Error response data: ${e.response?.data}');
        }
      } else {
        if (kDebugMode) {
          print('Error request: ${e.requestOptions}');
        }
      }
      rethrow;
    } catch (e) {
      if (kDebugMode) {
        print('Other error: $e');
      }
      rethrow;
    }
  }
}
