 import 'package:intl/intl.dart';

extension FormatStringDateTime on String {
  // String formatTimestamp(Timestamp timestamp) {
  //   DateTime dateTime = timestamp.toDate();
  //   return DateFormat('hh:mm a').format(dateTime); // dd/MM/yyyy hh:mm AM/PM
  // }

  String get toYYYYMMDDHHMMSS {
    //2022-07-14T17:00:00.000000Z
    DateTime tempDate = toDateTime;
    final DateFormat formatter = DateFormat('yyyy年MM月dd日 HH:mm:ss');
    return formatter.format(tempDate);
  }

  String get toDateStringEn {
    //2022-07-14T17:00:00.000000Z
    DateTime tempDate = toDateTime;
    final DateFormat formatter = DateFormat('yyyy/MM/dd HH:mm');
    return formatter.format(tempDate);
  }

  String get toMMDD {
    //2022-07-14T17:00:00.000000Z
    DateTime tempDate = toDateTime;
    final DateFormat formatter = DateFormat('MM/dd');
    return formatter.format(tempDate);
  }

  String get toHHMMSS {
    //2022-07-14T17:00:00.000000Z
    DateTime tempDate = toDateTime;
    final DateFormat formatter = DateFormat('HH:mm:ss');
    return formatter.format(tempDate);
  }

  String get toHHMM{
    //2022-07-14T17:00:00.000000Z
    DateTime tempDate = toDateTime;
    final DateFormat formatter = DateFormat('HH:mm');
    return formatter.format(tempDate);
  }

  String get toYYYYM{
    //2022-07-14T17:00:00.000000Z
    DateTime tempDate = toDateTime;
    final DateFormat formatter = DateFormat('yyyy年M耐');
    return formatter.format(tempDate);
  }

  String get toYYYY{
    //2022-07-14T17:00:00.000000Z
    DateTime tempDate = toDateTime;
    final DateFormat formatter = DateFormat('yyyy年');
    return formatter.format(tempDate);
  }

  DateTime get toDateTime {
    return DateFormat("yyyy-MM-dd HH:mm:ss").parse(this, true);
  }
  DateTime get toDateTimeLocal {
    return DateFormat("yyyy-MM-dd HH:mm:ss").parse(this);
  }
}

class DateTimeValidation {
  static bool isDateTimeBetween(String? start, String? end,
      [DateTime? current]) {
    if (start == null || end == null) return false;
    final current0 = current ?? DateTime.now();
    final start0 = start.toDateTimeLocal;
    final end0 = end.toDateTimeLocal;
    return start0.isBefore(current0) && end0.isAfter(current0);
  }
}
