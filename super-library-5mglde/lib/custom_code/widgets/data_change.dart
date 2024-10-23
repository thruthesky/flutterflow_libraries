// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/super_library.dart';

class DataChange extends StatefulWidget {
  const DataChange({
    super.key,
    this.width,
    this.height,
    required this.dataKey,
    required this.initialData,
    required this.builder,
  });

  final double? width;
  final double? height;
  final String dataKey;
  final dynamic initialData;
  final Widget Function(dynamic data) builder;

  @override
  State<DataChange> createState() => _DataChangeState();
}

class _DataChangeState extends State<DataChange> {
  @override
  Widget build(BuildContext context) {
    return Value(
      initialData: widget.initialData,
      ref: Ref.data.child(widget.dataKey),
      sync: true,
      builder: (v, r) {
        return widget.builder(v);
      },
    );
  }
}
