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

  static String userLastActive(dynamic timestamp) {
    if (timestamp == null || timestamp is! Timestamp) {
      return "Offline";
    }

    DateTime date = timestamp.toDate();
    DateTime now = DateTime.now();
    Duration diff = now.difference(date);

    if (diff.inMinutes == 0) {
      return "Recently active";
    } else if (diff.inMinutes < 60) {
      return "${diff.inMinutes} min ago";
    }

    bool isToday = now.day == date.day &&
        now.month == date.month &&
        now.year == date.year;

    bool isYesterday = now.subtract(Duration(days: 1)).day == date.day &&
        now.subtract(Duration(days: 1)).month == date.month &&
        now.subtract(Duration(days: 1)).year == date.year;

    final timeFormat = DateFormat('h:mm a');

    if (isToday) {
      return "Today at ${timeFormat.format(date)}";
    } else if (isYesterday) {
      return "Yesterday at ${timeFormat.format(date)}";
    } else {
      final dateFormat = DateFormat('MMM d');
      return "${dateFormat.format(date)} at ${timeFormat.format(date)}";
    }
  }

}
