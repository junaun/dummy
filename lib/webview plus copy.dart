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
  late WebViewPlusController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('MathQuill')),
        body: Column(children: [
          Row(
            children: [
              Expanded(
                  child: WebViewPlus(
                      javascriptMode: JavascriptMode.unrestricted,
                      initialUrl: 'assets/html/test4.html',
                      onWebViewCreated: (controller) {
                        this.controller = controller;
                      },
                      javascriptChannels: {
                    JavascriptChannel(
                        name: 'demo',
                        onMessageReceived: (JavascriptMessage message) {
                          //function here
                        })
                  })),
            ],
          ),
          /*
          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                child: Text('1'),
                onPressed: () {
                  //mathbox.add expression
                },
              )),
            ],
          ),*/
        ]));
  }
}

class MathBoxController {
  late WebViewController _webViewController;
  late AnimationController clearAnimationController;

  set webViewController(WebViewController controller) {
    this._webViewController = controller;
  }

  void addExpression(String msg, {bool isOperator = false}) {
    assert(_webViewController != null);
    _webViewController.runJavascript(
        "addCmd('$msg', {isOperator: ${isOperator.toString()}})");
  }

  void addString(String msg) {
    assert(_webViewController != null);
    _webViewController.runJavascript("addString('$msg')");
  }

  void equal() {
    assert(_webViewController != null);
    _webViewController.runJavascript("equal()");
  }

  void addKey(String key) {
    assert(_webViewController != null);
    _webViewController.runJavascript("simulateKey('$key')");
  }

  void deleteExpression() {
    assert(_webViewController != null);
    _webViewController.runJavascript("delString()");
  }

  void deleteAllExpression() {
    assert(_webViewController != null);
    _webViewController.runJavascript("delAll()");
  }
}
//\begin{bmatrix}1&2\\3&4\end{bmatrix}
//\hat f(\xi) = \int_{-\infty}^\infty {f(x)e^{- 2\pi i \xi x}\mathrm{d}x}