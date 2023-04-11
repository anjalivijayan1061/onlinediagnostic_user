import 'package:intl/intl.dart';

String getDate(DateTime dateTime, {bool onlyTime = false}) {
  String date = onlyTime
      ? DateFormat('hh : mm a').format(dateTime)
      : DateFormat('dd/MM/yyyy').format(dateTime);

  return date;
}
