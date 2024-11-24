import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../core/base/base_dio.dart';
import '../models/ShippingUnit.dart';
import '../util/constants.dart';

abstract class ApiPath {
  ApiPath._();

  static const String login = 'login';
  static const String logout = 'auth/logout';
  static const String shippingUnits = 'admin/shipping-units';

  static String shippingUnitsUpdate(uuid) => 'admin/shipping-unit/$uuid';

  static String addCart(uuid) => 'buyer/product/$uuid/add-cart';

  static String deleteCart(id) => 'buyer/cart/item/$id';
}

class RestfulApiProviderImpl {
  final DioClient dioClient = DioClient();
  static const String authType = 'Bearer';

  ///******************************************************************
  ///---------------------------Auth-----------------------------------
  ///******************************************************************
  Future login({
    required String userName,
    required String password,
  }) async {
    try {
      final response = await dioClient.post(
        ApiPath.login,
        body: {
          "email": userName,
          "password": password,
        },
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to login');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error login: $error');
      }
      rethrow;
    }
  }

  Future logout({
    required String token,
  }) async {
    try {
      final response = await dioClient.get(
        ApiPath.logout,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to login');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error login: $error');
      }
      rethrow;
    }
  }

  Future<List<ShippingUnit>> fetchShippingUnits({required String token}) async {
    final response = await dioClient.get(
      ApiPath.shippingUnits,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return (response.data['shipping_units'] as List)
          .map((unit) => ShippingUnit.fromJson(unit))
          .toList();
    } else {
      throw Exception('Failed to fetch shipping units');
    }
  }

  Future<void> addShippingUnit({required MultipartFile img,required String name,required String status} ) async {
    try {
      final formData = FormData.fromMap({
        "image": img,
        "name": name,
        "status": status,
      });

      final response = await dioClient.post(
        ApiPath.shippingUnits,
        body: formData,
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to add shipping unit');
      }
    } on DioError catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }
  /// Sửa đơn vị vận chuyển
  Future<void> updateShippingUnit({required String uuid,required MultipartFile img,required String name,required String status}) async {
    try {
      final formData = FormData.fromMap({
        "image": img,
        "name": name,
        "status": status,
      });
      final response = await dioClient.put(
        ApiPath.shippingUnitsUpdate(uuid),
        body: formData,
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to update shipping unit');
      }
    } on DioError catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  /// Xóa đơn vị vận chuyển
  Future<void> deleteShippingUnit({required String uuid}) async {
    try {
      final response = await dioClient.delete(ApiPath.shippingUnitsUpdate(uuid));
      if (response.statusCode != 200) {
        throw Exception('Failed to delete shipping unit');
      }
    } on DioError catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  /// Xử lý lỗi từ Dio
  void _handleDioError(DioError e) {
    if (e.response != null) {
      print('Dio Error [${e.response?.statusCode}]: ${e.response?.data}');
    } else {
      print('Dio Error: ${e.message}');
    }
  }
}
