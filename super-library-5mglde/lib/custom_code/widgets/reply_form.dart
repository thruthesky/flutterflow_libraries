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

/// Displays the comment reply form.
class ReplyForm extends StatefulWidget {
  const ReplyForm({
    super.key,
    this.width,
    this.height,
    required this.path,
    required this.data,
  });

  final double? width;
  final double? height;
  final String path;
  final dynamic data;

  @override
  State<ReplyForm> createState() => _ReplyFormState();
}

class _ReplyFormState extends State<ReplyForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('You are replying to:'),
            const SizedBox(height: 16),
            Row(
              children: [
                UserAvatar(uid: widget.data['uid']),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UserDisplayName(uid: widget.data['uid']),
                    Text(widget.data['title'] ?? '',
                        style: FlutterFlowTheme.of(context).titleSmall),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Type reply',
                hintText: 'Type your reply here...',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              maxLines: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Spacer(),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      'Cancel',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: ElevatedButton(
                      onPressed: () async {
                        await Comment.create(
                          root: widget.data,
                          content: 'Reply content',
                        );

                        Navigator.pop(context);
                      },
                      child: Text(
                        'Reply',
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
