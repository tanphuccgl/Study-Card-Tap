import 'package:intl/intl.dart';

class DateTimeUtils {
  String formatTimeRange(String startTime, String endTime) {
    try {
      DateFormat inputFormat = DateFormat("HH:mm:ss");
      DateFormat outputFormat = DateFormat("h:mm a");

      DateTime startTimeDateTime = inputFormat.parse(startTime);
      DateTime endTimeDateTime = inputFormat.parse(endTime);

      String formattedStartTime = outputFormat.format(startTimeDateTime);
      String formattedEndTime = outputFormat.format(endTimeDateTime);

      return "$formattedStartTime - $formattedEndTime";
    } catch (e) {
      return "";
    }
  }

  bool isTimePast(String timeString) {
    try {
      List<String> timeParts = timeString.split(":");
      DateTime yourTime = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          int.parse(timeParts.first),
          int.parse(timeParts[1]),
          int.parse(timeParts[2]));

      DateTime currentTime = DateTime.now();

      return yourTime.isBefore(currentTime);
    } catch (e) {
      return false;
    }
  }

  DateTime parseDateString(String dateString) {
    try {
      return DateFormat("yyyy-MM-dd").parse(dateString);
    } catch (e) {
      return DateTime.fromMillisecondsSinceEpoch(0);
    }
  }
}
