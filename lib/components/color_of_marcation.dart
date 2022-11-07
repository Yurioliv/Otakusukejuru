import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Color colorForMarcation(String Data) {
  var dateTime1 = DateFormat('d/M/y').parse(Data);

  if (dateTime1.difference(DateTime.now()).inDays > -7) {
    return const Color.fromARGB(255, 226, 0, 0);
  } else if (dateTime1.difference(DateTime.now()).inDays > -14) {
    return const Color.fromARGB(255, 9, 12, 194);
  } else {
    return Colors.grey;
  }
}
