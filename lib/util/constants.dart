import 'package:flutter/cupertino.dart';

class NetworkConstants {
  NetworkConstants._();
  static const String baseUrl =
      "http://api.youtextile.info/api/v1/";

  static const String urlImage = 'http://api.youtextile.info/storage/';

  static const Duration receiveTimeout = Duration(milliseconds: 5000);

  static const Duration connectionTimeout = Duration(milliseconds: 5000);

  static hideKeyBoard() async {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static String convertToUnaccentedNoSpace(String input) {
    const accents =
        'áàảãạăắằẳẵặâấầẩẫậéèẻẽẹêếềểễệíìỉĩịóòỏõọôốồổỗộơớờởỡợúùủũụưứừửữựýỳỷỹỵđ';
    const unaccented =
        'aaaaaaaaaaaaaaaaaeeeeeeeeeeeiiiiiooooooooooooooooouuuuuuuuuuuyyyyyd';

    String result = '';
    for (int i = 0; i < input.length; i++) {
      final char = input[i];
      final index = accents.indexOf(char);
      if (index != -1) {
        result += unaccented[index];
      } else if (char != ' ') {
        result += char;
      }
    }

    return result;
  }
}
