import 'package:flutter_note_app/core/config/localization/string_constants.dart';

class TimeUtils {
  const TimeUtils._();
  
  static String formatDate(DateTime? date) {
    if (date == null) return '';

    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return StringConstants.timeDaysAgo(difference.inDays);
    } else if (difference.inHours > 0) {
      return StringConstants.timeHoursAgo(difference.inHours);
    } else if (difference.inMinutes > 0) {
      return StringConstants.timeMinutesAgo(difference.inMinutes);
    } else {
      return StringConstants.timeJustNow;
    }
  }
}
