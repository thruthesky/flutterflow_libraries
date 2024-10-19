import 'package:flutter/material.dart';
import 'package:super_example/screens/chat/chat_room.screen.dart';
import 'package:super_library/custom_code/actions/index.dart';
import 'package:super_library/custom_code/actions/super_library.dart';
import 'package:super_library/custom_code/widgets/index.dart';

class PublicProfileScreen extends StatefulWidget {
  static const String routeName = '/PublicProfile';
  const PublicProfileScreen({super.key, required this.uid});

  final String uid;

  @override
  State<PublicProfileScreen> createState() => _PublicProfileScreenState();
}

class _PublicProfileScreenState extends State<PublicProfileScreen> {
  UserData? user;

  @override
  void initState() {
    super.initState();
    UserData.get(widget.uid).then((value) {
      setState(() {
        user = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PublicProfile'),
      ),
      body: Column(
        children: [
          const Text("PublicProfile"),
          Text('Uid: ${widget.uid}'),
          UserAvatar(uid: widget.uid),
          if (user != null) Text(user!.displayName),
          Wrap(
            children: [
              ElevatedButton(
                onPressed: () {
                  showGeneralDialog(
                    context: context,
                    pageBuilder: (_, __, ___) {
                      return ChatRoomScreen(
                        roomId: widget.uid,
                      );
                    },
                  );
                },
                child: const Text('Chat'),
              ),
              BlockedUser(
                  uid: widget.uid,
                  builder: (v) {
                    return ElevatedButton(
                      onPressed: () async {
                        final String t = v ? 'Un-Block' : 'Block';
                        final re = await confirm(
                          context: context,
                          title: Text(t),
                          message:
                              Text('Are you sure you want to $t this user?'),
                        );
                        if (re != true) {
                          return;
                        }
                        if (v) {
                          await unblockUser(widget.uid);
                        } else {
                          await blockUser(widget.uid);
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('User blocked'),
                          ),
                        );
                      },
                      child: Text(v ? 'Un-Block' : 'Block'),
                    );
                  }),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Report'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
