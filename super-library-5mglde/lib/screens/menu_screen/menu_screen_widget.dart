import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'menu_screen_model.dart';
export 'menu_screen_model.dart';

class MenuScreenWidget extends StatefulWidget {
  const MenuScreenWidget({super.key});

  @override
  State<MenuScreenWidget> createState() => _MenuScreenWidgetState();
}

class _MenuScreenWidgetState extends State<MenuScreenWidget> {
  late MenuScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MenuScreenModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          title: Text(
            'MenuScreen',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Inter Tight',
                  color: Colors.white,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                child: Text(
                  'User Menu',
                  style: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Inter Tight',
                        letterSpacing: 0.0,
                      ),
                ),
              ),
              Divider(
                thickness: 2.0,
                color: FlutterFlowTheme.of(context).alternate,
              ),
              Material(
                color: Colors.transparent,
                child: ListTile(
                  leading: FaIcon(
                    FontAwesomeIcons.lock,
                  ),
                  title: Text(
                    'Login',
                    style: FlutterFlowTheme.of(context).titleLarge.override(
                          fontFamily: 'Inter Tight',
                          letterSpacing: 0.0,
                        ),
                  ),
                  subtitle: Text(
                    'Email & Password Sign In',
                    style: FlutterFlowTheme.of(context).labelMedium.override(
                          fontFamily: 'Inter',
                          letterSpacing: 0.0,
                        ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    size: 24.0,
                  ),
                  tileColor: FlutterFlowTheme.of(context).secondaryBackground,
                  dense: false,
                  contentPadding:
                      EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                child: ListTile(
                  leading: FaIcon(
                    FontAwesomeIcons.userTie,
                  ),
                  title: Text(
                    'Guest A',
                    style: FlutterFlowTheme.of(context).titleLarge.override(
                          fontFamily: 'Inter Tight',
                          letterSpacing: 0.0,
                        ),
                  ),
                  subtitle: Text(
                    'Login as Guest A',
                    style: FlutterFlowTheme.of(context).labelMedium.override(
                          fontFamily: 'Inter',
                          letterSpacing: 0.0,
                        ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    size: 24.0,
                  ),
                  tileColor: FlutterFlowTheme.of(context).secondaryBackground,
                  dense: false,
                  contentPadding:
                      EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                child: ListTile(
                  leading: FaIcon(
                    FontAwesomeIcons.userTie,
                  ),
                  title: Text(
                    'Guest B',
                    style: FlutterFlowTheme.of(context).titleLarge.override(
                          fontFamily: 'Inter Tight',
                          letterSpacing: 0.0,
                        ),
                  ),
                  subtitle: Text(
                    'Login as Guest B',
                    style: FlutterFlowTheme.of(context).labelMedium.override(
                          fontFamily: 'Inter',
                          letterSpacing: 0.0,
                        ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    size: 24.0,
                  ),
                  tileColor: FlutterFlowTheme.of(context).secondaryBackground,
                  dense: false,
                  contentPadding:
                      EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
