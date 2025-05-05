import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DateUtilities {
  static const ddMMyyyy = "dd/MM/yyyy";
  static const yyyyMMdd = "yyyy-MM-dd";

  static dateFormate(String date) {
    if (date.isEmpty) {
      return "Invalid Date";
    }
    try {
      DateTime dateTime = DateFormat(DateUtilities.yyyyMMdd).parse(date);
      return DateFormat(DateUtilities.ddMMyyyy).format(dateTime);
    } catch (e) {
      return "Invalid Date";
    }
  }

  static dateTimeFormate(String? dateTime) {
    return DateFormat('dd/MM/yyyy').format(DateTime.parse(dateTime ?? ''));
  }

  static formatDate(String date) {
    final DateFormat inputFormat = DateFormat('yyyy-MM-dd');
    final DateFormat outputFormat = DateFormat('dd MMM yyyy');

    DateTime dateTime = inputFormat.parse(date);
    return outputFormat.format(dateTime);
  }


  static String formatFirestoreDate(Timestamp? timestamp) {
    if (timestamp == null) return 'Invalid Date';
    DateTime dateTime = timestamp.toDate();
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }
}
