import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'services/browser_commands.dart';

class BrowserShell extends StatefulWidget {
  const BrowserShell({super.key});

  @override
  State<BrowserShell> createState() => _BrowserShellState();
}

class _BrowserShellState extends State<BrowserShell> {
  final BrowserCommands _commands = BrowserCommands();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: InAppWebView(
          initialFile: 'assets/react_ui/index.html',
          initialSettings: InAppWebViewSettings(
            javaScriptEnabled: true,
            mediaPlaybackRequiresUserGesture: true,
            allowsBackForwardNavigationGestures: true,
            clearCache: false,
            thirdPartyCookiesEnabled: false,
            allowFileAccessFromFileURLs: true,
            allowUniversalAccessFromFileURLs: true,
          ),
          onWebViewCreated: (controller) {
            controller.addJavaScriptHandler(
              handlerName: 'browserCommand',
              callback: (args) async {
                final payload = args.isNotEmpty ? args.first : <String, dynamic>{};
                final result = await _commands.handle(payload, controller);
                return jsonEncode(result);
              },
            );
          },
          androidOnPermissionRequest: (controller, origin, resources) async {
            return PermissionRequestResponse(
              resources: resources,
              action: PermissionRequestResponseAction.DENY,
            );
          },
        ),
      ),
    );
  }
}
