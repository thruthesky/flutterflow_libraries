import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'user_list_tile_model.dart';
export 'user_list_tile_model.dart';

class UserListTileWidget extends StatefulWidget {
  const UserListTileWidget({
    super.key,
    this.data,
  });

  final dynamic data;

  @override
  State<UserListTileWidget> createState() => _UserListTileWidgetState();
}

class _UserListTileWidgetState extends State<UserListTileWidget> {
  late UserListTileModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UserListTileModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return custom_widgets.UserListTile(
      width: double.infinity,
      height: 100.0,
      data: widget!.data!,
      onTap: (data) async {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'User (${getJsonField(
                widget!.data,
                r'''$.uid''',
              ).toString()} ) has tapped.',
              style: TextStyle(
                color: FlutterFlowTheme.of(context).primaryText,
              ),
            ),
            duration: Duration(milliseconds: 4000),
            backgroundColor: FlutterFlowTheme.of(context).secondary,
          ),
        );
      },
    );
  }
}
