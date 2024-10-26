import 'package:flutter/material.dart';
import 'package:super_example/screens/data/data.create.screen.dart';
import 'package:super_example/screens/data/data.detail.screen.dart';
import 'package:super_example/screens/user/profile.screen.dart';
import 'package:super_example/screens/user/public_profile.screen.dart';
import 'package:super_library/custom_code/widgets/index.dart';

class DataListScreen extends StatelessWidget {
  static const String routeName = '/DataList';
  const DataListScreen({super.key, required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DataList'),
        actions: [
          IconButton(
            onPressed: () async {
              await showGeneralDialog(
                context: context,
                pageBuilder: (context, a1, a2) {
                  return DataCreateScreen(category: category);
                },
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: DataListView(
        category: category,
        builder: (data) => DataListTile(
          data: data,
          onTapProfilePhoto: (uid, displayName, photoUrl) async {
            await showGeneralDialog(
              context: context,
              pageBuilder: (context, a1, a2) {
                return PublicProfileScreen(
                  uid: uid,
                );
              },
            );
          },
          onTap: (data) async {
            await showGeneralDialog(
              context: context,
              pageBuilder: (context, a1, a2) {
                return DataDetailScreen(
                  data: data,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
