import 'dart:io';

import 'package:flutter/material.dart';

import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final cookieManager = WebviewCookieManager();

  final String _url = 'https://www.facebook.com';
  final List<String> cookieValue = ['list các giá trị tương ứng với bên dưới'];
  final String domain = 'facebook.com';
  final List<String> cookieName = ['c_user','datr','fr','sb','m_pixel_ratio','wd','xs'];

  @override
  void initState() {
    super.initState();
    cookieManager.clearCookies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
          actions: [
            IconButton(
              icon: Icon(Icons.ac_unit),
              onPressed: () async {
                // TEST CODE
                await cookieManager.getCookies(null);
              },
            )
          ],
        ),
        body: WebView(
          initialUrl: _url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (controller) async {
            await cookieManager.setCookies(
            // for (var i=;i<cookieName.length;i++)
              [for (var i=0;i<cookieName.length;i++)
              Cookie(cookieName[i], cookieValue[i])
                ..domain = domain
                ..expires = DateTime.now().add(Duration(days: 10))
                ..httpOnly = false
            ]);
          },
          onPageFinished: (_) async {
            final gotCookies = await cookieManager.getCookies(_url);
            for (var item in gotCookies) {
              print(item);
            }
          },
        ),
      ),
    );
  }
}