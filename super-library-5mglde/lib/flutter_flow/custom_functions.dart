import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';

String endRange(String str) {
  return '$str\uf8ff';
}

DateTime dateTimeOf(int? timestamp) {
  if (timestamp == null || timestamp == 0) return DateTime.now();
  if (timestamp < 0) {
    throw Exception('Timestamp cannot be negative');
  }
  if (timestamp < 10000000000) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  }
  return DateTime.fromMillisecondsSinceEpoch(timestamp);
}
