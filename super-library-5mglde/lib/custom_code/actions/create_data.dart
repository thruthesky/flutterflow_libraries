// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/super_library.dart';

Future<String> createData(
  String category,
  String? title,
  String? content,
  List<String>? urls,
  dynamic data,
) async {
  // Add your function code here!
  final ref = await Data.create(
    category: category,
    title: title,
    content: content,
    urls: urls,
    data: data,
  );
  return ref.key!;
}
