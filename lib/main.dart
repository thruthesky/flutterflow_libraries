import 'dart:async';
import 'dart:math';

import 'package:common_library/custom_code/actions/index.dart';
import 'package:common_library/custom_code/widgets/index.dart' as common;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:super_example/components/chat_room_list_tile_widget.dart';
import 'package:super_example/components/open_chat_room_list_tile_widget.dart';
import 'package:super_example/components/data_list_tile.dart';
import 'package:super_example/screens/chat/chat_room.list.screen.dart';
// import 'package:super_example/chat_room.screen.dart';
import 'package:super_example/firebase_options.dart';
import 'package:super_example/screens/chat/open_chat_room.list.screen.dart';
import 'package:super_example/screens/common_safe_area/common_safe_area.screen.dart';
import 'package:super_example/screens/data/data.screen.dart';
import 'package:super_example/screens/data/data.test.screen.dart';
import 'package:super_example/screens/site_preview/site_preview.screen.dart';
import 'package:super_example/screens/user/block_user_list.screen.dart';
import 'package:super_example/screens/user/profile.screen.dart';
import 'package:super_example/screens/user/user_list_view.screen.dart';
import 'package:super_library/custom_code/actions/index.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:super_library/custom_code/actions/super_library.dart';
import 'package:super_library/custom_code/widgets/index.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SuperLibrary.instance.databaseURL =
      'https://withcenter-test-4-default-rtdb.firebaseio.com';

  SuperLibrary.instance.debugLog = true;

  UserService.instance.collectionName = 'users';

  // Component.userListTile = (user) => CustomTile(user: user);
  // Component.chatRoomListTile = (join) => ChatRoomListTileWidget(
  //       roomId: join.roomId,
  //       name: join.name,
  //       iconUrl: join.iconUrl,
  //       displayName: join.displayName,
  //       photoUrl: join.photoUrl,
  //       group: join.group,
  //       single: join.single,
  //       open: join.open,
  //       lastMessageAt: join.lastMessageAt,
  //       lastMessageDeleted: join.lastMessageDeleted,
  //       lastText: join.lastText,
  //       lastUrl: join.lastUrl,
  //       lastProtocol: join.lastProtocol,
  //       newMessageCount: join.newMessageCount,
  //     );

  // Component.openChatRoomListTile = (room) => OpenChatRoomListTileWidget(
  //       roomId: room.id,
  //       name: room.name,
  //       description: room.description,
  //       iconUrl: room.iconUrl,
  //       users: room.users,
  //       blockedUsers: room.blockedUids,
  //       masterUsers: room.masterUsers,
  //       createdAt: room.createdAt,
  //       updatedAt: room.updatedAt,
  //       open: room.open,
  //       openCreatedAt: room.openCreatedAt,
  //       single: room.single,
  //       group: room.group,
  //       lastMessageAt: room.lastMessageAt,
  //       allMembersCanInvite: room.allMembersCanInvite,
  //     );

  // Component.dataCard = (Data data) => PostCard(data: data.data);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  StreamSubscription? userSubscription;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Timer(Duration(milliseconds: 100), test);
    });
  }

  /// Write test code here
  void test() async {
    // showGeneralDialog(
    //   context: context,
    //   pageBuilder: (_, __, ___) {
    //     return DataTestScreen();
    //   },
    // );

    await showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: false,
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: MediaQuery.viewInsetsOf(context),
            child: const ReplyForm(data: {
              'key': 'data-key-1',
              'title': 'This is the title',
              'uid': 'B3vgtXhd3TSsAp1Tk3XJPkfFGGx2',
            }),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Super Library Flutter Sample'),
        actions: [
          AuthStateChanges(builder: (user) {
            return PopupMenuButton(itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: ListTile(
                    title: const Text('Create 10 test users'),
                    onTap: () async {
                      final String id = 'id${Random().nextInt(1000) + 9999}';

                      for (int i = 0; i < 10; i++) {
                        final String email = '$id-$i@test.com';
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: email,
                          password: '12345a,*',
                        );
                        String uid = FirebaseAuth.instance.currentUser!.uid;
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(uid)
                            .set({
                          'display_name': 'User-$id',
                          'created_time': FieldValue.serverTimestamp(),
                          'email': email,
                          'photo_url': 'https://picsum.photos/id/${i}0/200/300',
                        });
                        print(
                          'User $email created with uid: $uid',
                        );
                      }
                    },
                  ),
                ),
                if (user != null)
                  PopupMenuItem(
                    child: ListTile(
                      title: const Text('Sign Out'),
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                      },
                    ),
                  ),
              ];
            });
          })
        ],
      ),
      body: AuthStateChanges(builder: (user) {
        if (user == null) {
          return Center(
            child: Column(
              children: [
                const Text('User is NOT signed in'),
                ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signInAnonymously();
                    String uid = FirebaseAuth.instance.currentUser!.uid;
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(uid)
                        .set({
                      'display_name': 'Anonymous $uid',
                      'created_time': FieldValue.serverTimestamp(),
                      'photo_url': 'https://picsum.photos/id/123/200/300',
                    });
                  },
                  child: const Text('Sign in Anonymously'),
                ),

                /// Firebase email & password registration or login
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: const Text('Register'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          );
        }
        //
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    children: [
                      UserAvatar(
                        uid: myUid,
                        width: 56,
                        height: 56,
                        radius: 24,
                      ),
                      const Positioned(
                        right: 0,
                        bottom: 0,
                        child: ChatNewMessageCounter(),
                      ),
                    ],
                  ),
                  Value(
                      ref: myRef.child(UserData.field.displayName),
                      builder: (v, r) => Text('Name: $v')),
                  Text('UID: ${FirebaseAuth.instance.currentUser!.uid}'),
                  Wrap(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          showGeneralDialog(
                            context: context,
                            pageBuilder: (_, __, ___) {
                              return const ProfileScreen();
                            },
                          );
                        },
                        child: const Text('Profile Edit'),
                      ),
                      ElevatedButton(
                        onPressed: () => showGeneralDialog(
                            context: context,
                            pageBuilder: (_, __, ___) => BlockUserListScreen()),
                        child: Text("Blocked Users"),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                        },
                        child: const Text('Sign Out'),
                      ),
                      ElevatedButton(
                          onPressed: () => showGeneralDialog(
                                context: context,
                                pageBuilder: (_, __, ___) {
                                  return const UserListViewScreen();
                                },
                              ),
                          child: const Text('User List')),
                    ],
                  ),
                  Text('Unit Tests & Integration Tests'),
                  Divider(),
                  Wrap(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          final String id =
                              'id${Random().nextInt(1000) + 9999}';

                          for (int i = 0; i < 10; i++) {
                            final String email = '$id-$i@test.com';
                            await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                              email: email,
                              password: '12345a,*',
                            );
                            String uid = FirebaseAuth.instance.currentUser!.uid;
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(uid)
                                .set({
                              'display_name': 'User-$id',
                              'created_time': FieldValue.serverTimestamp(),
                              'email': email,
                              'photo_url':
                                  'https://picsum.photos/id/${i}0/200/300',
                            });
                            print(
                              'User $email created with uid: $uid',
                            );
                          }
                        },
                        child: const Text('Create 10 test users'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showGeneralDialog(
                            context: context,
                            pageBuilder: (_, __, ___) {
                              return const DataTestScreen();
                            },
                          );
                        },
                        child: const Text('Data Tests'),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Chat, '),
                      Text('New Messages: '),
                      ChatNewMessageCounter(),
                    ],
                  ),
                  Divider(),
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => showGeneralDialog(
                          context: context,
                          pageBuilder: (_, __, ___) {
                            return const ChatRoomListScreen();
                          },
                        ),
                        child: const Text('My chat rooms'),
                      ),
                      ElevatedButton(
                        onPressed: () => showGeneralDialog(
                          context: context,
                          pageBuilder: (_, __, ___) {
                            return const OpenChatRoomListScreen();
                          },
                        ),
                        child: const Text('Open chat rooms'),
                      ),
                    ],
                  ),
                  Text('Data, Comment & Relations'),
                  Divider(),
                  Wrap(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          showGeneralDialog(
                            context: context,
                            pageBuilder: (_, __, ___) {
                              return DataScreen();
                            },
                          );
                        },
                        child: Text('Data'),
                      ),
                    ],
                  ),
                  Text('ETC'),
                  Divider(),
                  Wrap(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            showGeneralDialog(
                              context: context,
                              pageBuilder: (_, __, ___) {
                                return const CommonSafeAreaScreen();
                              },
                            );
                          },
                          child: const Text('CommonSafeArea')),
                      ElevatedButton(
                          onPressed: () {
                            showGeneralDialog(
                              context: context,
                              pageBuilder: (_, __, ___) {
                                return const SitePreviewScreen();
                              },
                            );
                          },
                          child: Text('Site Preview')),
                      ElevatedButton(
                          onPressed: () async {
                            final String url = 'https://www.google.com';
                            if (await canLaunchUrl(Uri.parse(url))) {
                              await launchUrl(Uri.parse(url));
                            } else {
                              print('Could not launch $url');
                            }
                          },
                          child: Text('Launch a URL')),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
