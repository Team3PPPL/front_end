import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void formatCurrencyController(TextEditingController controller) {
  String value = controller.text.replaceAll('.', '').replaceAll(',', '');
  if (value.isEmpty) return;

  final formatter =
      NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0);
  final intValue = int.tryParse(value);
  if (intValue != null) {
    final newValue = formatter.format(intValue).replaceAll(',', '.');
    controller.value = controller.value.copyWith(
      text: newValue,
      selection: TextSelection.collapsed(offset: newValue.length),
    );
  }
}
