// Automatic FlutterFlow imports
import 'package:firebase_database/firebase_database.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/super_library.dart';

Future<String> createChatRoom(
  String name,
  String? description,
  String? iconUrl,
  bool? open,
  bool? canInvite,
) async {
  // Add your function code here!
  final DatabaseReference ref = await ChatRoom.create(
    users: <String, bool>{},
    name: name,
    description: description,
    iconUrl: iconUrl,
    open: open ?? true,
    allMembersCanInvite: canInvite ?? true,
  );
  return ref.key!;
}
