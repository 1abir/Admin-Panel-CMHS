
import 'package:intl/intl.dart';

class FormattedDate{

  static DateFormat dateFormat = DateFormat("yyyyMMddaHHmmss");

  static String format(DateTime? dateTime){
    if(dateTime == null) return '';
    return dateFormat.format(dateTime);
  }

  static DateTime? parse(String? dateString){
    if(dateString==null) return null;
    return dateFormat.parse(dateString);
  }
}