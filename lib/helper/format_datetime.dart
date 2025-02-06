import 'package:intl/intl.dart';

class FormatDatetime {
  static convertDateTime(datetimeString) {
    DateTime dateTime = datetimeString;
    String splitToDate = DateFormat('dd MMM yy').format(dateTime);
    String splitToTime = DateFormat('HH:mm').format(dateTime);

    dynamic convert = [splitToDate, splitToTime];

    return convert;
  }
}