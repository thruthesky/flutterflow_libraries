import '/components/user_avatar/user_avatar_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'user_list_icon_model.dart';
export 'user_list_icon_model.dart';

class UserListIconWidget extends StatefulWidget {
  const UserListIconWidget({
    super.key,
    required this.uid,
    String? displayName,
    required this.photoUrl,
  }) : this.displayName = displayName ?? '';

  final String? uid;
  final String displayName;
  final String? photoUrl;

  @override
  State<UserListIconWidget> createState() => _UserListIconWidgetState();
}

class _UserListIconWidgetState extends State<UserListIconWidget> {
  late UserListIconModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UserListIconModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            wrapWithModel(
              model: _model.userAvatarModel,
              updateCallback: () => safeSetState(() {}),
              child: UserAvatarWidget(
                photoUrl: widget!.photoUrl,
                initials:
                    widget!.displayName != null && widget!.displayName != ''
                        ? widget!.displayName
                        : widget!.uid!,
                size: 48.0,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
              child: Text(
                widget!.displayName,
                style: FlutterFlowTheme.of(context).titleLarge.override(
                      fontFamily: 'Inter Tight',
                      letterSpacing: 0.0,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}