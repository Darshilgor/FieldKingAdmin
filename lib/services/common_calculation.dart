import 'package:intl/intl.dart';

class CommonCalculation {
  static calculateGej(String? gej) {
    return (gej == '280') ? 12 : 11;
  }

  static String lastActive({DateTime? lastActive}) {
    final currentTime = DateTime.now();
    final difference = currentTime.difference(lastActive ?? currentTime);

    if (difference.inMinutes < 10) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return DateFormat('hh:mm a').format(lastActive ?? currentTime);
    } else {
      return DateFormat('dd/MM/yyyy hh:mm a').format(lastActive ?? currentTime);
    }
  }
}
