import 'package:date_time_format/date_time_format.dart';

class DateTimeHelper {
  const DateTimeHelper._();

  static String? stringToDddMMyyyyHHMMA(String? dateTime) {
    return dateTime != null
        ? DateTime.parse(dateTime).toLocal().format('D, j M Y, h:i A')
        : null;
  }

  static String? stringToddMMyyyy(String? dateTime) {
    return dateTime != null
        ? DateTime.parse(dateTime).toLocal().format('j M, Y')
        : null;
  }

//2019-10-15T19:42:05-08:00
  static String? timeToHHMMA(String? time) {
    return time != null
        ? DateTime.parse("0000-00-00T$time-00:00").format('h : i A')
        : null;
  }
}
