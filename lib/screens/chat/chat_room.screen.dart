import 'package:common_library/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:super_example/screens/chat/chat_invite_user.screen.dart';
import 'package:super_example/screens/chat/chat_room_edit_dialog.dart';
import 'package:super_example/screens/user/public_profile.screen.dart';
import 'package:super_library/custom_code/actions/index.dart';
import 'package:super_library/custom_code/actions/super_library.dart';
import 'package:super_library/custom_code/widgets/index.dart';

class ChatRoomScreen extends StatefulWidget {
  static const String routeName = '/ChatRoom';
  const ChatRoomScreen({
    super.key,
    required this.roomId,
  });

  final String roomId;

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ChatRoomIcon(roomId: widget.roomId),
            Expanded(
              child: const Text(
                'ChatRoom',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await showGeneralDialog(
                context: context,
                pageBuilder: (context, a1, a2) {
                  return ChatInviteUserScreen(
                    roomId: widget.roomId,
                  );
                },
              );
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () async {
              await showGeneralDialog(
                context: context,
                pageBuilder: (context, a1, a2) {
                  return ChatRoomEditDialog(
                    roomId: widget.roomId,
                  );
                },
              );
            },
            icon: const Icon(Icons.settings),
          ),
          PopupMenuButton(
            itemBuilder: (_) {
              return [
                PopupMenuItem(
                  value: 'leave',
                  child: const Text('Leave'),
                ),
                PopupMenuItem(child: const Divider()),
                PopupMenuItem(
                  value: 'go-back',
                  child: const Text('Go back'),
                ),
              ];
            },
            icon: const Icon(Icons.menu),
            onSelected: (value) async {
              if (value == 'leave') {
                final result = await confirm(
                  context: context,
                  title: const Text('Leave chat room'),
                  message: const Text('Do you want to leave this chat room?'),
                );
                if (result == true) {
                  await leaveChatRoom(widget.roomId);
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                }
              } else if (value == 'go-back') {
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: ChatMessageListView(
                  uidOrRoomId: widget.roomId,
                  onTapProfilePhoto: (uid, displayName, photoUrl) async {
                    showGeneralDialog(
                      context: context,
                      pageBuilder: (_, __, ___) {
                        return PublicProfileScreen(
                          uid: uid,
                        );
                      },
                    );
                  },
                ),
              ),
              SafeArea(
                child: TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    hintText: 'Enter message',
                    suffixIcon: IconButton(
                      onPressed: () async {
                        final text = textController.text;
                        textController.clear();
                        await sendChatMessage(
                          widget.roomId,
                          text,
                        );
                      },
                      icon: const Icon(Icons.send),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
