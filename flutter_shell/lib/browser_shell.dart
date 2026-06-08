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
  InAppWebViewController? _controller;
  final BrowserCommands _commands = BrowserCommands();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: InAppWebView(
          initialSettings: InAppWebViewSettings(
            javaScriptEnabled: true,
            mediaPlaybackRequiresUserGesture: true,
            allowsBackForwardNavigationGestures: true,
            clearCache: false,
            thirdPartyCookiesEnabled: false,
          ),
          initialData: InAppWebViewInitialData(
            data: _fallbackPage,
            mimeType: 'text/html',
            encoding: 'utf-8',
            baseUrl: WebUri('https://neonretro.local'),
          ),
          onWebViewCreated: (controller) {
            _controller = controller;
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

const String _fallbackPage = '''
<!doctype html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
body{margin:0;background:#05040a;color:#fff;font-family:system-ui;min-height:100vh;display:grid;place-items:center;padding:24px} .card{max-width:360px;border:1px solid rgba(255,255,255,.14);border-radius:28px;padding:28px;background:linear-gradient(145deg,rgba(255,64,198,.18),rgba(101,255,241,.08))} h1{font-size:44px;margin:0;letter-spacing:-.06em}.sub{color:#ff6fd8;font-weight:700}.tag{color:#65fff1;letter-spacing:.26em;font-size:12px}.btn{margin-top:20px;padding:14px 18px;border-radius:16px;background:#ff40c6;color:#05040a;font-weight:800;display:inline-block}
</style>
</head>
<body><section class="card"><p class="tag">TEKDEV</p><h1>Neon Retro</h1><p class="sub">a browser</p><p>Android shell is ready. The local React bundle will be loaded here after build copy.</p><span class="btn">Ready</span></section></body>
</html>
''';
