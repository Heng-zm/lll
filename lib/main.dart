import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WebViewPage(
        url: 'https://heng-zm.github.io/tretr.github.io/oo.html', // URL to load
      ),
    );
  }
}


class WebViewPage extends StatefulWidget {
  final String url;

  WebViewPage({Key? key, required this.url}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize WebView platform
    WebViewPlatform.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(
        controller: _controller,  // Set the WebViewController
      ),
    );
  }
}
