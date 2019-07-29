import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../util/view_util.dart';


class WebViewPage extends StatelessWidget {
  final String url;
  final String title;

  WebViewPage(this.url, this.title);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ViewUtil.getAppBar(title, context),
      body: _Webview(),
    );
  }

  _Webview() {
    if (Platform.isIOS) {
//      return WebView(
//          javascriptMode: JavascriptMode.unrestricted,
//          initialUrl: url);
    } else {
      return AndroidView(
        viewType: 'webview',
        onPlatformViewCreated: (i) {
          MethodChannel _channel = MethodChannel('huanggan/webview');
          _channel.invokeMethod('loadUrl', {'url': url});
        },
      );
    }
  }
}
