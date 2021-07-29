import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormattedDate {
  static DateFormat dateFormat = DateFormat("yyyyMMddaHHmmss");

  FormattedDate._();

  static String? format(DateTime? dateTime) {
    if (dateTime == null) return null;
    try {
      String ret = dateFormat.format(dateTime);

      debugPrint(ret);
      return ret;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static DateTime? parse(String? dateString) {
    if (dateString == null || dateString == 'null') return null;
    try {
      String dateWithT =
          dateString.substring(0, 8) + 'T' + dateString.substring(10);
      DateTime dateTime = DateTime.parse(dateWithT);
      return dateTime;
    } catch (e) {
      debugPrint("Error in parsing dateString :${dateString.toString()}:");
      debugPrint(e.toString());
      return null;
    }
  }
}
