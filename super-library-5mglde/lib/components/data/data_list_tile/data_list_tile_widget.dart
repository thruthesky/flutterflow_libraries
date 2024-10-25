import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'data_list_tile_model.dart';
export 'data_list_tile_model.dart';

class DataListTileWidget extends StatefulWidget {
  const DataListTileWidget({
    super.key,
    required this.data,
    required this.onTap,
    required this.onTapProfilePhoto,
  });

  final dynamic data;
  final Future Function(dynamic data)? onTap;
  final Future Function(String uid)? onTapProfilePhoto;

  @override
  State<DataListTileWidget> createState() => _DataListTileWidgetState();
}

class _DataListTileWidgetState extends State<DataListTileWidget> {
  late DataListTileModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DataListTileModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return custom_widgets.DataListTile(
      width: double.infinity,
      height: 100.0,
      data: widget!.data!,
      onTapProfilePhoto: (uid, displayName, photoUrl) async {
        await widget.onTapProfilePhoto?.call(
          getJsonField(
            widget!.data,
            r'''$.uid''',
          ).toString(),
        );
      },
      onTap: (data) async {
        await widget.onTap?.call(
          widget!.data!,
        );
      },
    );
  }
}
