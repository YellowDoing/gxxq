import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gxxq/view/webview.dart';
import '../constant.dart';
import '../model/element.dart' as E;
import 'package:html/dom.dart' as DOM;
import 'package:flutter/cupertino.dart';

class ElementParser {
  static bool hasE(String text) {
    return text.contains('<e') &&
        text.contains('/>') &&
        text.contains('type') &&
        text.contains('title');
  }

  static E.Element parseE(String text) {
    var e = DOM.Element
        .html(text)
        .attributes;
    final element = E.Element(e['type']);
    if (e['hid'] != null) element.hid = e['hid'];
    if (e['href'] != null) element.href = Uri.decodeFull(e['href']);
    if (e['title'] != null) element.title = Uri.decodeFull(e['title']);

    return element;
  }

  static String getE(String text) {
    return text.substring(text.indexOf('<e'), text.indexOf('/>') + 2);
  }

  static ParseResult genEText(String text, BuildContext context) {
    final textSpans = List<TextSpan>();
    final styleBlack = TextStyle(color: Colors.black87);
    final styleBlue = TextStyle(color: BLUE_DARK);
    String textResult = text;

    do {
      //取出一段e
      String elementStr = ElementParser.getE(textResult);
      var element = ElementParser.parseE(elementStr);
      var texts = textResult.split(elementStr);
      textSpans.add(TextSpan(text: texts[0], style: styleBlack));

      var tap = TapGestureRecognizer();
      tap.onTap = () {
        if (element.type == 'web') {
          if (Platform.isAndroid)
            Navigator.push(context, CupertinoPageRoute(builder: (context) {
              return WebViewPage(element.href, element.title);
            }));
        }
      };
      textSpans.add(TextSpan(
        text: (element.type == 'web' ? "链接:" : "") + element.title,
        style: styleBlue,
        recognizer: tap,
      ));
      textResult = texts[1];
    } while (ElementParser.hasE(textResult));

    return ParseResult(textSpans, textResult);
  }
}



class ParseResult {
  List<TextSpan> textSpans;
  String textResult;

  ParseResult(this.textSpans, this.textResult);
}
