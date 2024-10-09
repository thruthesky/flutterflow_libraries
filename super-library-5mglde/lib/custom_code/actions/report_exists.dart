// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:super_library/custom_code/actions/super_library.dart';

Future<bool> reportExists(String otherUid, String type) async {
  // Add your function code here!
  final newPath = '$myUid-$type/$otherUid';
  print('Checking if report exists at $newPath, ${Report.col.path}');
  final snapshot = await Report.col.where('path', isEqualTo: newPath).get();
  return snapshot.docs.isNotEmpty;
}
