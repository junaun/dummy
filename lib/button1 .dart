import 'package:webview_flutter_plus/webview_flutter_plus.dart';
import 'dart:convert';
import 'package:flutter_math_fork/ast.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_math_fork/tex.dart';
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
          children: [
            _mathField(),
            _button1(),
            _button2(),
            _button3(),
            _button4(),
            _button5(),
          ],
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
            controller.loadUrl('assets/html/test5.html');
            ctl = controller;
          },
          //javascriptChannels: ,
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
          ctl.webViewController.runJavascript("addString('2xy')");
          //MathBoxController()._webViewController.webViewController.reload();
        },
      ),
    );
  }

  Widget _button2() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: ElevatedButton(
        child: Text(
          'Del',
          style: TextStyle(fontSize: 20.0),
        ),
        onPressed: () {
          ctl.webViewController.runJavascript("delString()");
          //MathBoxController()._webViewController.webViewController.reload();
        },
      ),
    );
  }

  Widget _button3() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: ElevatedButton(
        child: Math.tex(
          'x^2',
        ),
        onPressed: () {
          ctl.webViewController.runJavascript("addString('^2')");
          //MathBoxController()._webViewController.webViewController.reload();
        },
      ),
    );
  }

  Widget _button4() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: ElevatedButton(
        child: Text(
          'Matrix',
          style: TextStyle(fontSize: 20.0),
        ),
        onPressed: () {
          ctl.webViewController
              .runJavascript(r"addCmd('\\bmatrix', {isOperator: false})");
          //MathBoxController()._webViewController.webViewController.reload();
        },
      ),
    );
  }

  Widget _button5() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: ElevatedButton(
        child: Text(
          '/',
          style: TextStyle(fontSize: 20.0),
        ),
        onPressed: () {
          ctl.webViewController
              .runJavascript(r"addCmd('/', {isOperator: false})");
          //MathBoxController()._webViewController.webViewController.reload();
        },
      ),
    );
  }
}
//\begin{bmatrix}1&2\\3&4\end{bmatrix}
//\hat f(\xi) = \int_{-\infty}^\infty {f(x)e^{- 2\pi i \xi x}\mathrm{d}x}