import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  static final DateFormat _formatter = DateFormat('MMM dd, yyyy • hh:mm:ss a');

  /// Example:
  /// Jul 03, 2026 • 10:35:21 AM
  static String format(DateTime dateTime) {
    return _formatter.format(dateTime);
  }
}
