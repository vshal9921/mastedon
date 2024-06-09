import 'package:flutter/material.dart';
import '/constants/color.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebWidget extends StatefulWidget {

  final String webUrl;

  WebWidget({super.key, required this.webUrl});

  @override
  State<WebWidget> createState() => _WebWidgetState();
  
}

class _WebWidgetState extends State<WebWidget> {

  late final WebViewController webViewController;

  @override
  void initState() {

    super.initState();
    webViewController = WebViewController();
    webViewController.setJavaScriptMode(JavaScriptMode.unrestricted);
    webViewController.setBackgroundColor(MyColors.background);
    webViewController.setNavigationDelegate(NavigationDelegate(
      onProgress: (int progress) {},
      onWebResourceError: (WebResourceError error) {},
    ));
    webViewController.loadRequest(Uri.parse(widget.webUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('images/icon-480.png', height: 40),
        centerTitle: true,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          child: Container(
            color: MyColors.background,
            height: 1.0,
          ),
        ),
      ),
      body: WebViewWidget(controller: webViewController),
    );
  }
}