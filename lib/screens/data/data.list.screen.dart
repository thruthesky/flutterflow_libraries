import 'package:flutter/material.dart';
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
      ),
      body: DataListView(
        category: category,
      ),
    );
  }
}
