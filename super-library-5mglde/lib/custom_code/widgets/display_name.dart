// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/super_library.dart';

/// Display name from the Realtime Database
///
/// [nameIfEmpty] is displayed if the name is empty.
///
/// [nameIfBlockedUser] is displayed if the user is blocked. The default is
/// 'Blocked user'. If you want to display nothing, set it to an empty string.
///
/// TODO: Does this widget need to have a initialData parameter?
class DisplayName extends StatefulWidget {
  const DisplayName({
    super.key,
    this.width,
    this.height,
    required this.uid,
    this.nameIfEmpty,
    this.nameIfBlockedUser,
    this.fontSize,
    this.fontColor,
  });

  final double? width;
  final double? height;
  final String uid;
  final String? nameIfEmpty;
  final String? nameIfBlockedUser;
  final double? fontSize;
  final Color? fontColor;

  @override
  State<DisplayName> createState() => _DisplayNameState();
}

class _DisplayNameState extends State<DisplayName> {
  @override
  Widget build(BuildContext context) {
    return BlockedUser(
        uid: widget.uid,
        builder: (blocked) {
          /// Is the user blocked?
          if (blocked) {
            return text(widget.nameIfBlockedUser ?? 'Blocked user');
          }

          dog('initialData: ${Memory.get<UserData>(widget.uid)?.toJson()}');
          String displayName = '';
          final Map<String, dynamic>? data =
              Memory.get<UserData>(widget.uid)?.toJson();
          if (data != null) {
            displayName = data[UserData.field.displayName] as String;
          }

          return Value(
            ref: UserService.instance
                .databaseUserRef(widget.uid)
                .child(UserData.field.displayName),
            initialData: displayName,
            sync: true,
            builder: (v, r) {
              if (v == null) {
                return const SizedBox();
              }
              String name = v.toString();
              if (name.isEmpty) {
                name = widget.nameIfEmpty ?? '';
              }
              return text(name);
            },
          );
        });
  }

  Widget text(String name) {
    return Text(
      name,
      style: TextStyle(
        color: widget.fontColor,
        fontSize: widget.fontSize ?? 16.0,
      ),
    );
  }
}
