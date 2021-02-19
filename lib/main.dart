import 'package:flutter/material.dart';
import 'module/signin/signin_page.dart';
import 'module/signup/signup_page.dart';
import 'package:flutter_book_store_sample/shared/app_color.dart';
import 'module/home/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book Store',
      theme: ThemeData(
        primarySwatch: AppColor.yellow,
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/' : (context) => SignInPage(),
        '/home': (context) => HomePage(),
        '/sign-in' : (context) => SignInPage(),
        '/sign-up' : (context) => SignUpPage(),
      },
    );
  }
}
