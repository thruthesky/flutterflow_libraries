// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:super_library/custom_code/actions/super_library.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future unblockUser(String otherUid) async {
  final myRef = firestore.collection('users').doc(myUid);

  await myRef.set({
    'blockedUsers': FieldValue.arrayRemove([otherUid])
  }, SetOptions(merge: true));
}