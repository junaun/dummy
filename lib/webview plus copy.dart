import 'package:webview_flutter_plus/webview_flutter_plus.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(home: HelpScreen()));
}

class HelpScreen extends StatefulWidget {
  @override
  HelpScreenState createState() {
    return HelpScreenState();
  }
}

class HelpScreenState extends State<HelpScreen> {
  late WebViewPlusController ctl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('MathQuill')),
        body: Column(
          children: [_mathField(), _button1()],
        ));
  }

  Widget _mathField() {
    return Container(
        height: 150,
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: WebViewPlus(
          javascriptMode: JavascriptMode.unrestricted,
          //initialUrl: 'assets/html/test5.html',
          onWebViewCreated: (controller) {
            controller.loadUrl('assets/html/test4.html');
            MathBoxController().webViewPlusController = controller;
          },
        ));
  }

  Widget _button1() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: ElevatedButton(
        child: Text(
          '1',
          style: TextStyle(fontSize: 20.0),
        ),
        onPressed: () {
          MathBoxController().reloaddd();
          //MathBoxController()._webViewController.webViewController.reload();
        },
      ),
    );
  }
}

class MathBoxController {
  late WebViewPlusController _webViewController;
  late AnimationController clearAnimationController;

  set webViewPlusController(WebViewPlusController controller) {
    _webViewController = controller;
  }

  void reloaddd() {
    _webViewController.webViewController.reload();
  }

  void addExpression(String msg, {bool isOperator = false}) {
    _webViewController.webViewController.runJavascript(
        "addCmd('$msg', {isOperator: ${isOperator.toString()}})");
  }

  void addString(String msg) {
    _webViewController.webViewController.runJavascript("addString('$msg')");
  }

  void equal() {
    _webViewController.webViewController.runJavascript("equal()");
  }

  void addKey(String key) {
    _webViewController.webViewController.runJavascript("simulateKey('$key')");
  }

  void deleteExpression() {
    _webViewController.webViewController.runJavascript("delString()");
  }

  void deleteAllExpression() {
    _webViewController.webViewController.runJavascript("delAll()");
  }
}
//\begin{bmatrix}1&2\\3&4\end{bmatrix}
//\hat f(\xi) = \int_{-\infty}^\infty {f(x)e^{- 2\pi i \xi x}\mathrm{d}x}