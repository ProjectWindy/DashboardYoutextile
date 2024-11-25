import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ipad_dashboard/core/base_dio.dart';

import '../util/constants.dart';

abstract class ApiPath {
  ApiPath._();

  static const String login = 'login';
  static const String logout = 'auth/logout';
  static const String customer = 'auth/profile';
  static const String forgotPassword = 'forgot-password';
  static const String searchByPhone = 'buyer/user/';
  static const String register = 'register';
  static const String buyerAddress = 'buyer/addresses';
  static const String buyerDeleteAddress = 'buyer/address';
  static const String buyerAddAddress = 'buyer/address';
  static const String paymentMethods = 'buyer/payment-methods';
  static const String bankAccount = 'buyer/bank-account';
  static const String creditCard = 'buyer/credit-card';

  ///*******************************BuyerProduct*******************************
  ///******************************GET************************************
  ///

  static const String BuyerproductsGet = 'buyer/products';
  static const String BuyerbestproductsGet = 'buyer/products/best-sellers';
  static const String BuyersearcnproductsGet = 'buyer/search/products';
  static const String BuyerindustryproductsGet = 'buyer/products';
  static const String BuyerUUIDproductsGet = 'buyer/products';
  static const String BuyeIndustrysGet = 'buyer/industries';
  static const String buyerGetCart = 'buyer/cart';
  static const String buyerGetCartCheckout = 'buyer/cart/checkout';
  static const String buyerPayment = 'buyer/order';
  static const String buyerGetOrder = 'buyer/orders';

  static String buyerGetProductDetail(uuid) => 'buyer/product/$uuid';
  static String buyerGetProductStore(uuid) => 'buyer/store/$uuid/products';

  static String addCart(uuid) => 'buyer/product/$uuid/add-cart';
  static String deleteCart(id) => 'buyer/cart/item/$id';

  ///*******************************ALL***********************************
  ///*******************************POST***********************************

  static const String sellerRegistorPost = 'seller/store';

  static const String sellerRAddressPost = 'seller/address';
  static const String sellerTaxPost = 'seller/tax';
  static const String selleridentificationPost = 'seller/identification';
  static const String sellershippingunitsPost = 'seller/shipping-unit';

  static const String sellerscategoriesPost = 'seller/category';
  static const String sellersproductsPost = 'seller/products';
  static const String sellersproductdetailsPost = 'seller/product-detail';
  static const String sellersproductsalesPost = 'seller/product-sales';
  static const String sellersproductshippingPost = 'seller/product-shipping';
  static const String sellersproductextra = 'seller/product-extra';
  static const String sellerRBankAccountPost = 'seller/bank-account';

  ///******************************GET************************************

  static const String sellerRegistorGet = 'seller/store';
  static const String sellerRAddressGet = 'seller/addresses';
  static const String sellerTaxGet = 'seller/tax';
  static const String selleridentificationGet = 'seller/identification';
  static const String sellershippingunitsGet = 'seller/shipping-units';
  static const String sellerpaymentmethodssGet = 'seller/payment-methods';
  static const String sellerswalletGet = 'seller/shipping-wallet';

  static const String sellerscategoriesGet = 'seller/categories';
  static const String sellersindustriesGet = 'seller/industries';
  static const String sellersproductsGet = 'seller/products';
  static const String sellershippingunitspost = 'seller/shipping-unit';

  static const String sellersproductdetailsGet = 'seller/product-detail/:id';
  static const String sellersproductshippingGet = 'seller/product-shipping/id';
  static const String sellersproductextraGet = 'seller/product-extra/id';
  static const String sellerstorestatusGet = '/seller/store/status';
  static const String sellerstorestatussGetGet = '/seller/product/:id/status';

  ///*******************************DELETE***********************************
  static const String sellerRAddressDelete = 'seller/address/id';

  ///*******************************Update***********************************
  ///---------------------------Product-----------------------------------
  ///******************************GET************************************
  static const String sellerRegisterProductGet = '/seller/products';

  ///*******************************POST***********************************
  static const String sellerRegisterProductPost = '/seller/product';

  // Thêm path mới cho service packages
  static const String servicePackages = 'admin/service-packages';
  static const String postservicePackages = 'admin/service-package';

  static const String users = 'admin/users';
  static const String usersdetails = 'admin/user';
}

class RestfulApiProviderImpl {
  final DioClient dioClient = DioClient();
  static const String authToken =
      '26|Y4HoSC3Rlbegkjw47OKBdf1m1EXMeLyiLx5V8WsY20be74d7';
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

  ///******************************************************************
  ///---------------------------GET-----------------------------------
  ///******************************************************************

  Future postProductExtra({
    required String token,
    required String product_id,
    required String is_pre_order,
    required String status,
    required String sku,
  }) async {
    try {
      // final url = '${ApiPath.sellersproductextra}/$product_id';
      final url = 'http://52.77.246.91/api/v1/seller/product/$product_id/extra';

      final response = await dioClient.post(
        url,
        body: {
          "product_id": product_id,
          "is_pre_order": is_pre_order,
          "status": status,
          "sku": 'SKU5332485739845348539845',
        },
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print(response);
      if (response.statusCode == 201) {
        return response;
      } else {
        throw Exception('Failed to post  ');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error post  : $error');
      }
      rethrow;
    }
  }

  ///******************************************************************
  ///---------------------------DELETE-----------------------------------
  ///******************************************************************
  Future deleteAddresses({
    required String token,
    required String id,
  }) async {
    try {
      final response = await dioClient.delete(
        "${ApiPath.buyerDeleteAddress}/$id",
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 201) {
        return response;
      } else {
        throw Exception('Failed to fetch addresses');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error fetch addresses: $error');
      }
      rethrow;
    }
  }

  Future deleteCart({
    required String token,
    required String id,
  }) async {
    try {
      final response = await dioClient.delete(
        ApiPath.deleteCart(id),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 201) {
        return response;
      } else {
        throw Exception('Failed to delete cart');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error delete cart: $error');
      }
      rethrow;
    }
  }

  Future<bool> sendShippingData(
      {String shippingUnit = 'Default Shipping Unit',
      String description = 'Default Description',
      required String token,
      Map<String, dynamic> settings = const {
        'is_cod': 1,
        'is_active': 1
      }}) async {
    // Tạo requestBody với dữ liệu mặc định
    Map<String, dynamic> requestBody = {
      "shipping_units": [
        {
          "id": 1,
          "name": shippingUnit,
          "description": description,
          "settings": settings,
        }
      ]
    };

    // In thông tin yêu cầu khi ở chế độ debug
    if (kDebugMode) {
      print(
          'Request URL: ${NetworkConstants.baseUrl}${ApiPath.sellershippingunitsPost}');
      print('Request Data: $requestBody');
    }

    try {
      // Gửi yêu cầu POST
      final response = await dioClient.post(
        '${NetworkConstants.baseUrl}${ApiPath.sellershippingunitsPost}',
        body:
            requestBody, // Sử dụng 'data' thay vì 'body' cho yêu cầu POST với Dio
        headers: {
          'Content-Type':
              'application/json', // Đảm bảo gửi dữ liệu dưới dạng JSON
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      // In thông tin phản hồi khi ở chế độ debug
      if (kDebugMode) {
        print('POST Response Status Code: ${response.statusCode}');
        print('POST Response Data: ${response.data}');
      }

      // Kiểm tra mã trạng thái phản hồi
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Shipping data posted successfully');
        return true; // Trả về true khi gửi thành công
      } else if (response.statusCode == 401) {
        throw 'Không có quyền truy cập. Vui lòng đăng nhập lại.';
      } else {
        throw Exception(
            'Failed to post shipping data. Status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // Xử lý lỗi khi sử dụng Dio
      if (kDebugMode) {
        print('DioError Type: ${e.type}');
        print('DioError Message: ${e.message}');
        print('DioError Response: ${e.response?.data}');
      }

      // Xử lý theo loại lỗi Dio
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          throw 'Kết nối tới server bị timeout. Vui lòng thử lại.';
        case DioExceptionType.badResponse:
          final statusCode = e.response?.statusCode;
          if (statusCode == 404) {
            throw '${e.response}.';
          }
          throw 'Lỗi từ server: $statusCode';
        case DioExceptionType.cancel:
          throw 'Yêu cầu đã bị hủy';
        default:
          throw 'Lỗi kết nối: ${e.message}';
      }
    } catch (error) {
      // Xử lý lỗi chung khi có lỗi ngoài Dio
      if (kDebugMode) {
        print('General Error: $error');
      }
      throw 'Đã xảy ra lỗi khng xác định khi gửi thông tin tài khoản ngân hàng';
    }
  }

  Future<Response> getStatus({
    required String token,
  }) async {
    if (kDebugMode) {
      print(
          'Request URL: ${NetworkConstants.baseUrl}${ApiPath.sellerstorestatusGet}');
    }

    try {
      final response = await dioClient.get(
        ApiPath.sellerstorestatusGet,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (kDebugMode) {
        print('Getg Response Status Code: ${response.statusCode}');
        print('GetG Response Data: ${response.data}');
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Tax Get successfully');
        return response;
      } else if (response.statusCode == 401) {
        throw 'Không có quyền truy cập. Vui lòng đăng nhập lại.';
      } else {
        throw Exception(
            'Failed to post address. Status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print('DioError Type: ${e.type}');
        print('DioError Message: ${e.message}');
        print('DioError Response: ${e.response?.data}');
      }

      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          throw 'Kết nối tới server bị timeout. Vui lòng thử lại.';
        case DioExceptionType.badResponse:
          final statusCode = e.response?.statusCode;
          if (statusCode == 404) {
            throw '${e.response}.';
          }
          throw 'Lỗi từ server: $statusCode';
        case DioExceptionType.cancel:
          throw 'Yêu cầu đã bị hủy';
        default:
          throw 'Lỗi kết nối: ${e.message}';
      }
    } catch (error) {
      if (kDebugMode) {
        print('General Error: $error');
      }
      throw 'Đã xảy ra lỗi không xác định khi gửi Tax';
    }
  }

  Future<Response> getServicePackages({
    required String token,
  }) async {
    if (kDebugMode) {
      print(
          'Request URL: ${NetworkConstants.baseUrl}${ApiPath.servicePackages}');
    }

    try {
      final response = await dioClient.get(
        ApiPath.servicePackages,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (kDebugMode) {
        print('Get Response Status Code: ${response.statusCode}');
        print('Get Response Data: ${response.data}');
      }

      if (response.statusCode == 200) {
        return response;
      } else if (response.statusCode == 401) {
        throw 'Không có quyền truy cập. Vui lòng đăng nhập lại.';
      } else {
        throw Exception(
            'Failed to get service packages. Status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print('DioError Type: ${e.type}');
        print('DioError Message: ${e.message}');
        print('DioError Response: ${e.response?.data}');
      }

      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          throw 'Kết nối tới server bị timeout. Vui lòng thử lại.';
        case DioExceptionType.badResponse:
          final statusCode = e.response?.statusCode;
          if (statusCode == 404) {
            throw '${e.response}.';
          }
          throw 'Lỗi từ server: $statusCode';
        case DioExceptionType.cancel:
          throw 'Yêu cầu đã bị hủy';
        default:
          throw 'Lỗi kết nối: ${e.message}';
      }
    } catch (error) {
      if (kDebugMode) {
        print('General Error: $error');
      }
      throw 'Đã xảy ra lỗi không xác định khi lấy danh sách service packages';
    }
  }

  Future<Response> getUsers({
    required String token,
  }) async {
    try {
      final response = await dioClient.get(
        ApiPath.users,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to get users');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error getting users: $error');
      }
      rethrow;
    }
  }

  Future<Response> createServicePackage({
    required String token,
    required Map<String, dynamic> packageData,
  }) async {
    try {
      final response = await dioClient.post(
        ApiPath.postservicePackages,
        body: packageData,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw Exception(
            response.data['message'] ?? 'Failed to create service package');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error creating service package: $error');
      }
      rethrow;
    }
  }

  Future<Response> updateServicePackage({
    required String token,
    required String uuid,
    required Map<String, dynamic> packageData,
  }) async {
    try {
      final response = await dioClient.put(
        '${ApiPath.postservicePackages}/$uuid',
        body: packageData,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw Exception(
            response.data['message'] ?? 'Failed to update service package');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error updating service package: $error');
      }
      rethrow;
    }
  }

  Future<Response> deleteServicePackage({
    required String token,
    required String uuid,
  }) async {
    try {
      final response = await dioClient.delete(
        '${ApiPath.postservicePackages}/$uuid',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw Exception(
            response.data['message'] ?? 'Failed to delete service package');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error deleting service package: $error');
      }
      rethrow;
    }
  }

  Future<Response> getUserDetails({
    required String token,
    required String uuid,
  }) async {
    try {
      final response = await dioClient.get(
        '${ApiPath.usersdetails}/$uuid',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception(
            response.data['message'] ?? 'Failed to get user details');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error getting user details: $error');
      }
      rethrow;
    }
  }
}
