import 'package:flutter/material.dart';
import 'package:super_example/screens/data/data.list.screen.dart';
import 'package:super_example/screens/data/data.test.screen.dart';

class DataScreen extends StatefulWidget {
  static const String routeName = '/Data';
  const DataScreen({super.key});

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => showGeneralDialog(
              context: context,
              pageBuilder: (_, __, ___) {
                return DataTestScreen();
              },
            ),
            child: Text("Unit Test"),
          ),
          ElevatedButton(
            onPressed: () => showGeneralDialog(
              context: context,
              pageBuilder: (_, __, ___) {
                return DataListScreen(
                  category: 'qna',
                );
              },
            ),
            child: Text("QnA"),
          ),
          ElevatedButton(
            onPressed: () => showGeneralDialog(
              context: context,
              pageBuilder: (_, __, ___) {
                return DataListScreen(
                  category: 'discussion',
                );
              },
            ),
            child: Text("Discussion"),
          ),
        ],
      ),
    );
  }
}
