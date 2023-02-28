import 'package:flutter/material.dart';

class DateTimeGetter {
  static Future<DateTime?> selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      return picked;
    } else {
      return selectedDate;
    }
  }
}
