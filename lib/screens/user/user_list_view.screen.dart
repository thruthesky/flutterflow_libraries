import 'package:flutter/material.dart';
import 'package:super_example/screens/user/public_profile.screen.dart';
import 'package:super_library/custom_code/actions/index.dart';
import 'package:super_library/custom_code/widgets/index.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:super_library/custom_code/actions/super_library.dart';
import 'package:super_library/custom_code/widgets/index.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UserListViewScreen extends StatefulWidget {
  static const String routeName = '/UserListView';
  const UserListViewScreen({super.key});

  @override
  State<UserListViewScreen> createState() => _UserListViewScreenState();
}

class _UserListViewScreenState extends State<UserListViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UserListView'),
      ),
      body: Column(
        children: [
          const Text("UserListView"),
          Expanded(
            child: UserListView(
              reverse: true,
              builder: (data) {
                return UserListTile(
                    data: data,
                    onTap: (data) => showGeneralDialog(
                          context: context,
                          pageBuilder: (_, __, ___) {
                            return PublicProfileScreen(uid: data['uid']);
                          },
                        ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
