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
        body: WebViewPlus(
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: 'assets/html/test4.html',
            onWebViewCreated: (controller) {
              this.controller = controller;
            }));
  }
}


//\begin{bmatrix}1&2\\3&4\end{bmatrix}
//\hat f(\xi) = \int_{-\infty}^\infty {f(x)e^{- 2\pi i \xi x}\mathrm{d}x}