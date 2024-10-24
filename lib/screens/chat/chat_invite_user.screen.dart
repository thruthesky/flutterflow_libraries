import 'package:flutter/material.dart';
import 'package:super_library/custom_code/actions/index.dart';
import 'package:super_library/custom_code/widgets/index.dart';

class ChatInviteUserScreen extends StatefulWidget {
  static const String routeName = '/ChatInviteUser';
  const ChatInviteUserScreen({super.key, required this.roomId});
  final String roomId;

  @override
  State<ChatInviteUserScreen> createState() => _ChatInviteUserScreenState();
}

class _ChatInviteUserScreenState extends State<ChatInviteUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatInviteUser'),
      ),
      body: UserListView(
        reverse: true,
        builder: (user) => UserListTile(
          data: user,
          onTap: (data) async {
            await inviteChatUser(widget.roomId, data['uid']);
            if (context.mounted) {
              Navigator.pop(context);
            }
          },
        ),
      ),
    );
  }
}
