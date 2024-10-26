import 'package:flutter/material.dart';
import 'package:super_library/custom_code/actions/index.dart';
import 'package:super_library/custom_code/actions/super_library.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:super_library/custom_code/widgets/index.dart';

class BlockUserListScreen extends StatefulWidget {
  static const String routeName = '/BlockUserList';
  const BlockUserListScreen({super.key});

  @override
  State<BlockUserListScreen> createState() => _BlockUserListScreenState();
}

class _BlockUserListScreenState extends State<BlockUserListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('BlockUserList'),
        ),
        body: MyDoc(
          builder: (userData) {
            if (userData == null) {
              return const Center(child: CircularProgressIndicator());
            }
            print(userData);
            final List<String> blockedUsers =
                List<String>.from((userData['blockedUsers'] as List?) ?? []);

            if (blockedUsers.isEmpty) {
              return const Center(child: Text('No blocked users'));
            }

            return ListView.builder(
              itemCount: blockedUsers.length,
              itemBuilder: (context, index) {
                final blockedUser = blockedUsers[index];
                return ListTile(
                  leading: UserAvatar(uid: blockedUser),
                  title: UserDisplayName(uid: blockedUser),
                  subtitle: Text(blockedUser),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      final result = await confirm(
                        context: context,
                        title: const Text('Unblock user'),
                        message: Text('Do you want to unblock $blockedUser?'),
                      );
                      if (result == true) {
                        unblockUser(blockedUser);
                      }
                    },
                  ),
                );
              },
            );
          },
        ));
  }
}
