import 'package:flutter_base_riverpod/utils/constant.dart';
import 'package:intl/intl.dart';

String getFormattedDateTime(DateTime dateTime) {
  // Get the current date and time
  DateTime now = DateTime.now();

  // Calculate the time difference
  Duration difference = now.difference(dateTime);

  // Format the difference as a human-readable string
  String formattedDifference = _formatTimeDifference(difference);

  return formattedDifference;
}

String _formatTimeDifference(Duration difference) {
  if (difference.inDays >= 365) {
    int years = difference.inDays ~/ 365;
    return '$years ${years == 1 ? AppConstant.yearText : AppConstant.yearsText} ${AppConstant.agoText}';
  } else if (difference.inDays >= 30) {
    int months = difference.inDays ~/ 30;
    return '$months ${months == 1 ? AppConstant.monthText : AppConstant.monthsText} ${AppConstant.agoText}';
  } else if (difference.inDays > 0) {
    if (difference.inDays == 1) {
      return AppConstant.yesterdayText;
    } else {
      return '${difference.inDays} ${AppConstant.daysText} ${AppConstant.agoText}';
    }
  } else if (difference.inHours > 0) {
    if (difference.inHours == 1) {
      return '${AppConstant.anHourText} ${AppConstant.agoText}';
    } else {
      return '${difference.inHours} ${AppConstant.hoursText} ${AppConstant.agoText}';
    }
  } else if (difference.inMinutes > 0) {
    if (difference.inMinutes == 1) {
      return '${AppConstant.aMinuteText} ${AppConstant.agoText}';
    } else {
      return '${difference.inMinutes} ${AppConstant.minutesText} ${AppConstant.agoText}';
    }
  } else {
    return '${AppConstant.secondsText} ${AppConstant.agoText}';
  }
}

String getFormattedDate(DateTime date) {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(date);
  return formatted;
}
