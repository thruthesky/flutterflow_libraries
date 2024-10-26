// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import '/custom_code/actions/super_library.dart';

class UserSearch extends StatefulWidget {
  const UserSearch({
    super.key,
    this.width,
    this.height,
    this.horizontalScroll,
    this.reverse,
    required this.builder,
    this.searchText,
  });

  final double? width;
  final double? height;
  final bool? horizontalScroll;
  final bool? reverse;
  final Widget Function(dynamic data) builder;
  final String? searchText;

  @override
  State<UserSearch> createState() => _UserSearchState();
}

class _UserSearchState extends State<UserSearch> {
  final usersRef = UserService.instance.databaseUsersRef;

  Query get query {
    // return usersRef
    //     .orderByChild('displayNameLowerCase')
    //     .equalTo(widget.searchText ?? '');
    return usersRef
        .orderByChild('displayNameLowerCase')
        .startAt(widget.searchText ?? '')
        .endAt("${widget.searchText ?? ''}\uf8ff");
  }

  @override
  Widget build(BuildContext context) {
    return ValueListView(
      reverseQuery: widget.reverse == true,
      query: query,
      builder: (snapshot, fetchMore) {
        return ListView.separated(
          itemCount: snapshot.docs.length,
          separatorBuilder: (context, index) => const Divider(
            height: 0,
          ),
          scrollDirection:
              widget.horizontalScroll == true ? Axis.horizontal : Axis.vertical,
          itemBuilder: (context, index) {
            fetchMore(index);
            final DataSnapshot doc = snapshot.docs[index];
            final UserData user = UserData.fromSnapshot(doc);

            return widget.builder(user.toJson());
          },
        );
      },
      emptyBuilder: () => const Center(
        child: Text('No users found'),
      ),
      errorBuilder: (error) => Center(
        child: Text('Error: $error'),
      ),
      loadingBuilder: () => const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}