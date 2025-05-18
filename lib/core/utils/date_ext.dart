final vnTimeZoneOffset = Duration(hours: 7);
extension DateExt on DateTime {
  DateTime removeTime() {
    return DateTime(year, month, day);
  }

  bool isTheSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

