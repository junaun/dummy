import 'package:webview_flutter_plus/webview_flutter_plus.dart';
import 'dart:convert';
import 'package:flutter_math_fork/ast.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_math_fork/tex.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(home: MathField()));
}

class MathField extends StatefulWidget {
  @override
  MathFieldState createState() {
    return MathFieldState();
  }
}

class MathFieldState extends State<MathField> {
  late WebViewPlusController ctl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('MathQuill')),
        body: Column(
          children: [_mathField(), _row1(), _row2(), _row3(), _row4()],
        ));
  }

  Widget _mathField() {
    return Container(
        height: 150,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
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
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: ElevatedButton(
        child: const Text(
          '1',
          style: TextStyle(fontSize: 20.0),
        ),
        onPressed: () {
          ctl.webViewController.runJavascript("addString('1')");
          //MathBoxController()._webViewController.webViewController.reload();
        },
      ),
    );
  }

  Widget _button2() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: ElevatedButton(
        child: Math.tex(
          r'\pi',
        ),
        onPressed: () {
          ctl.webViewController
              .runJavascript(r"addCmd('\pi', {isOperator: false})");
          //MathBoxController()._webViewController.webViewController.reload();
        },
      ),
    );
  }

  Widget _button3() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: ElevatedButton(
        child: const Text(
          'Del',
          style: TextStyle(fontSize: 20.0),
        ),
        onPressed: () {
          //"addString('^2')"
          ctl.webViewController.runJavascript("delString()");
          //MathBoxController()._webViewController.webViewController.reload();
        },
      ),
    );
  }

  Widget _button4() {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: ElevatedButton(
            onPressed: () {
              ctl.webViewController.runJavascript(r"addString('^2')");
            },
            child: Math.tex(r"\square^2")));
  }

  Widget _button5() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: ElevatedButton(
        child: Math.tex(
          r'\frac{\square}{\square}',
        ),
        onPressed: () {
          ctl.webViewController
              .runJavascript(r"addCmd('/', {isOperator: false})");
        },
      ),
    );
  }

  Widget _button6() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: ElevatedButton(
        child: Math.tex(
          r'\begin{bmatrix}\square&\square\\\square&\square\end{bmatrix}',
        ),
        onPressed: () {
          ctl.webViewController
              .runJavascript(r"addCmd('\\bmatrix', {isOperator: false})");
        },
      ),
    );
  }

  Widget _button7() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: ElevatedButton(
        child: Math.tex(
          r'\int\mathrm{d}x',
        ),
        onPressed: () {
          ctl.webViewController
              .runJavascript(r"addCmd('\int', {isOperator: false})");
        },
      ),
    );
  }

  Widget _button8() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: ElevatedButton(
        child: Math.tex(
          r'\sqrt\square',
        ),
        onPressed: () {
          ctl.webViewController
              .runJavascript(r"addCmd('\sqrt', {isOperator: false})");
        },
      ),
    );
  }

  Widget _button9() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: ElevatedButton(
        child: const Text(
          'Add Row',
          style: TextStyle(fontSize: 20.0),
        ),
        onPressed: () {
          ctl.webViewController.runJavascript("simulateKey('Shift-Spacebar')");
        },
      ),
    );
  }

  Widget _button10() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: ElevatedButton(
        child: const Text(
          '<',
          style: TextStyle(fontSize: 20.0),
        ),
        onPressed: () {
          ctl.webViewController.runJavascript("simulateKey('Left')");
        },
      ),
    );
  }

  Widget _button11() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: ElevatedButton(
        child: const Text(
          '>',
          style: TextStyle(fontSize: 20.0),
        ),
        onPressed: () {
          ctl.webViewController.runJavascript("simulateKey('Right')");
        },
      ),
    );
  }

  Widget _row1() {
    return Row(
      children: [_button1(), _button2(), _button3()],
    );
  }

  Widget _row2() {
    return Row(
      children: [_button4(), _button5(), _button6()],
    );
  }

  Widget _row3() {
    return Row(
      children: [_button7(), _button8(), _button9()],
    );
  }

  Widget _row4() {
    return Row(
      children: [_button10(), _button11()],
    );
  }
}
//\begin{bmatrix}1&2\\3&4\end{bmatrix}
//\hat f(\xi) = \int_{-\infty}^\infty {f(x)e^{- 2\pi i \xi x}\mathrm{d}x}