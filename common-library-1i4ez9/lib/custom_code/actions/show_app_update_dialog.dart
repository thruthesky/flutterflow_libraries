// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:upgrader/upgrader.dart';

/// [showAppUpdateDialog] shows a dialog to the user to update the app.
///
/// [alertAgainInterval] is the interval in minutes to alert the user again.
/// The default value is 1000 and this is 16.6 hours.
/// For testing purposes, you can set it to 0 to always show the dialog.
Future showAppUpdateDialog(
  BuildContext context,
  String? title,
  String? message,
  String? logoUrl,
  bool force,
  bool showReleaseNotes,
  int? alertAgainInterval,
  Future Function()? onIgnore,
  Future Function()? onLater,
  Future Function()? onUpdate,
) async {
  // Add your function code here!

  // If the platform is not Android or iOS, return
  if (Platform.isAndroid == false && Platform.isIOS == false) {
    return;
  }

  //
  final upgrader = Upgrader(
    debugLogging: true,
    durationUntilAlertAgain: Duration(minutes: alertAgainInterval ?? 1000),
  );
  await upgrader.initialize();

  // print(
  //     'upgrader: verifyInit: ${upgrader.verifyInit()}, shouldDisplayUpgrade: ${upgrader.shouldDisplayUpgrade()}, blocked: ${upgrader.blocked()}, releaseNotes: ${upgrader.releaseNotes}, versionInfo: ${upgrader.state.versionInfo}');
  if (context.mounted &&
      upgrader.verifyInit() &&
      upgrader.state.versionInfo != null &&
      upgrader.shouldDisplayUpgrade()) {
    final messageData = upgrader.determineMessages(context);
    final isBlocked = force || upgrader.blocked();
    final isNotBlocked = !isBlocked;
    final isCupertino = Platform.isIOS;
    title = title ?? messageData.message(UpgraderMessage.title) ?? 'No title';
    final releaseNotes = showReleaseNotes ? upgrader.releaseNotes : null;

    final content = Container(
      constraints: const BoxConstraints(maxHeight: 400),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: isCupertino
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (logoUrl != null && logoUrl.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(logoUrl),
              ),
            const SizedBox(height: 14),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(message ?? messageData.message(UpgraderMessage.prompt) ?? ''),
            const SizedBox(height: 8),
            if (releaseNotes != null)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Column(
                  crossAxisAlignment: isCupertino
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      messageData.message(UpgraderMessage.releaseNotes) ?? '',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(releaseNotes),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
    final actions = [
      actionButton(
          isCupertino, messageData.message(UpgraderMessage.buttonTitleUpdate),
          () {
        if (upgrader.state.debugLogging) {
          debugPrint('upgrader: button tapped: update now');
        }
        onUpdate?.call();
        upgrader.sendUserToAppStore();
        if (isNotBlocked) Navigator.of(context).pop();
      }, style: const TextStyle(fontWeight: FontWeight.bold)),
      if (isNotBlocked)
        actionButton(
            isCupertino, messageData.message(UpgraderMessage.buttonTitleLater),
            () {
          if (upgrader.state.debugLogging) {
            debugPrint('upgrader: button tapped: later');
          }
          onLater?.call();
          Navigator.of(context).pop();
        }),
      if (isNotBlocked)
        actionButton(
            isCupertino, messageData.message(UpgraderMessage.buttonTitleIgnore),
            () {
          if (upgrader.state.debugLogging) {
            debugPrint('upgrader: button tapped: ignore');
          }
          onIgnore?.call();
          upgrader.saveIgnored();
          Navigator.of(context).pop();
        }),
    ];

    await upgrader.saveLastAlerted();
    if (context.mounted) {
      showDialog(
        context: context,
        barrierDismissible: isNotBlocked,
        builder: (context) => isCupertino
            ? CupertinoAlertDialog(content: content, actions: actions)
            : AlertDialog(content: content, actions: actions),
      );
    }
  }
}

Widget actionButton(
  bool isCupertino,
  String? text,
  VoidCallback? onPressed, {
  TextStyle? style,
}) {
  return isCupertino
      ? CupertinoDialogAction(
          onPressed: onPressed, child: Text(text ?? '', style: style))
      : TextButton(onPressed: onPressed, child: Text(text ?? '', style: style));
}
