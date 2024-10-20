import 'package:flutter/material.dart';
import 'package:super_library/custom_code/actions/super_library.dart';
import 'package:firebase_database/firebase_database.dart';

class DataTestScreen extends StatefulWidget {
  static const String routeName = '/DataTest';
  const DataTestScreen({super.key});

  @override
  State<DataTestScreen> createState() => _DataTestScreenState();
}

class _DataTestScreenState extends State<DataTestScreen> {
  @override
  void initState() {
    super.initState();

    (() async {
      await testOnCrud();
      await testOnContentSize();
      await testOnDeletingDataWithKey();
      await testOnDeletingOtherUserData();
    })();
  }

  /// Test on deleting data with key
  testOnDeletingDataWithKey() async {
    dog('testOnDeletingDataWithKey begin;');
    final ref = await Data.create(category: 'cat-1', data: {'key': 'value'});

    await Data.deleteByKey(ref.key!);

    try {
      await Data.read(ref.key!);
      assert(false, "Data.read() should throw an error if data is deleted.");
    } catch (e) {
      // Success if an exception is thrown: data is deleted.
    }
  }

  /// Test on content size
  ///
  /// Steps:
  /// 1. Set the security rule to limit the content size lest than 20 characters
  /// 2. Create a new data with content size 24
  /// 3. You will see an error in the console
  testOnContentSize() async {
    await Data.create(category: 'cat-1', content: '1234567890123456789012345');
  }

  testOnCrud() async {
    // Wait for app boot
    await Future.delayed(const Duration(milliseconds: 500));
    dog("Data Test begin;");

    try {
      await Data.create(category: '', data: {});
      assert(false, "Data.write() should throw an error if category is empty.");
    } catch (e) {
      // Success if an exception is thrown: category is empty.
    }

    DatabaseReference? ref;
    try {
      ref = await Data.create(
        category: 'cat-1',
        title: 'title-1',
        data: {'extra-key': 'extra-value'},
      );
    } catch (e) {
      print(e);
      assert(false, "Data.write() should not throw an exception.");
    }

    final data = await Data.read(ref!.key!);

    assert(data.category == 'cat-1', "Data.read() category is not correct.");
    assert(data.title == 'title-1', "Data.read() title is not correct.");

    try {
      await data.update(data: {'uid': 'fake-uid'});
      assert(false,
          "Data.update() should throw an error because wrong-uid is not allowed.");
    } catch (e) {
      // Success if an exception is thrown: uid is wrong
    }

    await data.update(title: 'title-2', data: {'extra': 'v1'});
    final updatedData = await Data.read(ref.key!);
    assert(
        updatedData.title == 'title-2', "Data.update() title is not correct.");
    assert(updatedData.data['extra'] == 'v1');
    assert(updatedData.value('extra', '') == 'v1');

    await data.delete();

    dog('Data Test end;');
  }

  /// Test on deleting other user data
  ///
  /// Steps:
  /// 1. Create a new data
  /// 2. Change the uid in the Firebase console
  /// 3. Read data
  /// 4. Delete data
  testOnDeletingOtherUserData() async {
    // final readData = await Data.read('-O9dhHGuFB29RpCqn_VQ');
    // await readData.delete();
    // return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DataTest'),
      ),
      body: const Column(
        children: [
          Text("DataTest"),
        ],
      ),
    );
  }
}
