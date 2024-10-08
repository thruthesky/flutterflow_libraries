import 'package:flutter/material.dart';
import 'package:super_library/custom_code/widgets/index.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});
  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReportScreen'),
      ),
      body: const ReportListView(),
    );
  }
}
