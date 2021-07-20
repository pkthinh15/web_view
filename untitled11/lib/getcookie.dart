import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'web_view.dart';
import 'main.dart';
String myurl='https://devcourses.elitelearning.vn/oauth2/login/';

getcookie(String title) async {
  var dio = Dio();
  var cookieJar=CookieJar();
  dio.interceptors.add(CookieManager(cookieJar));
  await dio.post(myurl,
    options: Options(
      headers:{
        'Authorization':'Bearer $title',
      },
    ),
  );

  // Printprin cookies
  var cookie= await cookieJar.loadForRequest(Uri.parse(myurl));

   // print (cookie);
  return cookie;
  // second request with the cookie
  // print(title);// print(cookie);
}