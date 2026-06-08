import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class BrowserCommands {
  Future<Map<String, dynamic>> handle(
    dynamic payload,
    InAppWebViewController controller,
  ) async {
    final command = payload is Map ? payload['type']?.toString() : null;

    switch (command) {
      case 'LOAD_URL':
        final url = payload['url']?.toString() ?? 'https://example.com';
        await controller.loadUrl(urlRequest: URLRequest(url: WebUri(url)));
        return {'ok': true, 'type': command, 'url': url};

      case 'GO_BACK':
        if (await controller.canGoBack()) {
          await controller.goBack();
        }
        return {'ok': true, 'type': command};

      case 'GO_FORWARD':
        if (await controller.canGoForward()) {
          await controller.goForward();
        }
        return {'ok': true, 'type': command};

      case 'RELOAD':
        await controller.reload();
        return {'ok': true, 'type': command};

      case 'CLEAR_CACHE':
        await controller.clearCache();
        return {'ok': true, 'type': command};

      case 'SET_DESKTOP_SITE':
        final enabled = payload['enabled'] == true;
        await controller.setSettings(
          settings: InAppWebViewSettings(
            userAgent: enabled
                ? 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 Chrome/120 Safari/537.36'
                : null,
          ),
        );
        await controller.reload();
        return {'ok': true, 'type': command, 'enabled': enabled};

      default:
        return {'ok': false, 'error': 'Unknown command', 'type': command};
    }
  }
}
