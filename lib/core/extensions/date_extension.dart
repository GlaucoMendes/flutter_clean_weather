part of '../core.dart';

extension DateExtension on DateTime {
  DateTime get toTimeZone => add(timeZoneOffset);
  String weekdayName(BuildContext context) {
    return DateFormat('EEEE', context.locale.toLanguageTag()).format(this);
  }
}
