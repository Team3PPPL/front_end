import 'package:intl/intl.dart';

String formatCurrencyString(String value) {
  final number =
      int.tryParse(value.replaceAll('.', '').replaceAll('.', '')) ?? 0;
  final format =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
  return format.format(number);
}
