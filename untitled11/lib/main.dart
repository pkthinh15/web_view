import 'dart:async';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart' as in_app_web_view;
import 'dart:io';
import 'package:dio_cookie_manager/dio_cookie_manager.dart' as dio_cookie;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import 'web_view.dart';
import 'getcookie.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:webview_flutter/webview_flutter.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Webview(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState(title:title);
}

class _MyHomePageState extends State<MyHomePage> {
  final title;




  _MyHomePageState({Key? key, required this.title});
  late InAppWebViewController _webViewController;

  List<String> cookievalue = [];
  List<String> cookiename = [];

  int _counter = 0;
  String myurl = 'https://devlearner.elitelearning.vn/#/lesson/course-v1:Horusoftaceae+APPSTORE_01+2021_T1/block-v1:Horusoftaceae+APPSTORE_01+2021_T1+type@chapter+block@1bf38d4834c94a2581d2fc4f346cf4ec';
  String domain = '.elitelearning.vn';
  var list;
  var expire;
  var check;
  final Completer<InAppWebViewController> _controller =
  Completer<InAppWebViewController>();


  @override
  Widget build(BuildContext context) {

    CookieManager cookieManager = CookieManager.instance();


    return Scaffold(
        appBar: AppBar(

          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('title'),
          actions: <Widget>[
            IconButton (
              icon: const Icon(Icons.replay),
                onPressed:  () async {
                  var cookies = await cookieManager.getCookies(url: Uri.parse('https://devlearner.elitelearning.vn/#/lesson/course-v1:Horusoftaceae+APPSTORE_01+2021_T1/block-v1:Horusoftaceae+APPSTORE_01+2021_T1+type@chapter+block@1bf38d4834c94a2581d2fc4f346cf4ec'));

                  await cookieManager.setCookie(
                    url: Uri.parse(myurl),
                    name:'sessionid',
                    value: 'fake',
                    domain: domain,
                    expiresDate: 0,
                    isHttpOnly: false,


                  );
                  setState(() {

                  });

                }

            ),
            // NavigationControls(_controller.future);


          ],
        ),
        body:


            cookiename.length==0 ?

            IconButton(
                icon: const Icon(Icons.replay),
                onPressed:  () async{
                  list = await getcookie(title);
                  setState(() {
                    expire=list[2].expires;


                    if (list[2].expires.isAfter(DateTime.now())) {
                      cookievalue = [list[0].value, list[1].value,
                        list[2].value];
                      cookiename = [
                        'csrftoken',
                        'sessionid',
                        'openedx-language-preference'
                      ];
                    }
                  },
                  );
                }

            ):

        Builder(builder: (BuildContext context )  {


          return

            InAppWebView(
              initialUrlRequest:
              URLRequest(url: Uri.parse(myurl)),


              onWebViewCreated: (controller) async {
                // list = await getcookie(title);
                // // setState(() {
                // //
                // //   expire=list[2].expires;
                // //
                // //
                // //   if (list[2].expires.isAfter(DateTime.now())) {
                // //     cookievalue = [list[0].value, list[1].value,
                // //       list[2].value];
                // //     cookiename = [
                // //       'csrftoken',
                // //       'sessionid',
                // //       'openedx-language-preference'
                // //     ];
                // //   }
                // // },
                // );


                  await cookieManager.setCookie(
                    url: Uri.parse(myurl),
                    name:cookiename[0],
                    value: cookievalue[0],
                    domain: domain,
                    expiresDate: list[0].expires.millisecondsSinceEpoch,
                    isHttpOnly: true,


                  );
                  await cookieManager.setCookie(
                    url: Uri.parse(myurl),
                    name:cookiename[1],
                    value: cookievalue[1],
                    domain: domain,
                    expiresDate: expire.millisecondsSinceEpoch,
                    isHttpOnly: true,


                  );
                  await cookieManager.setCookie(
                    url: Uri.parse(myurl),
                    name:cookiename[2],
                    value: cookievalue[2],
                    domain: domain,
                    expiresDate:expire.millisecondsSinceEpoch,
                    isHttpOnly: true,


                  );
                var cookies = await cookieManager.getCookies(url: Uri.parse('https://devlearner.elitelearning.vn/#/lesson/course-v1:Horusoftaceae+APPSTORE_01+2021_T1/block-v1:Horusoftaceae+APPSTORE_01+2021_T1+type@chapter+block@1bf38d4834c94a2581d2fc4f346cf4ec'));
                check=cookies[3].value;
              },

            );
        }


        ));


    // This trailing comma makes auto-formatting nicer for build methods.

  }


}
class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture)
      : assert(_webViewControllerFuture != null);

  final Future<InAppWebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<InAppWebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<InAppWebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final InAppWebViewController controller = snapshot.data!;
        return Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: !webViewReady
                  ? null
                  : () async {
                if (await controller.canGoBack()) {
                  await controller.goBack();
                } else {
                  // ignore: deprecated_member_use
                  Scaffold.of(context).showSnackBar(
                    const SnackBar(content: Text("No back history item")),
                  );
                  return;
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: !webViewReady
                  ? null
                  : () async {
                if (await controller.canGoForward()) {
                  await controller.goForward();
                } else {
                  // ignore: deprecated_member_use
                  Scaffold.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("No forward history item")),
                  );
                  return;
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.replay),
              onPressed: !webViewReady
                  ? null
                  : () {
                controller.reload();
              },
            ),
          ],
        );
      },
    );
  }
}







