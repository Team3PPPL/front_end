import 'package:intl/intl.dart';

String dateTimeFormat(DateTime date) {
  final DateFormat formatter = DateFormat('d MMMM yyyy', 'id_ID');
  return formatter.format(date);
}
