import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DataCardWidget extends StatefulWidget {
  const DataCardWidget({
    super.key,
    required this.data,
  });

  final dynamic data;

  @override
  State<DataCardWidget> createState() => _DataCardWidgetState();
}

class _DataCardWidgetState extends State<DataCardWidget> {
  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'Hello World',
        ),
      ],
    );
  }
}
