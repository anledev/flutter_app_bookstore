import 'package:flutter/material.dart';
import 'package:flutter_book_store_sample/module/signin/signin_page.dart';
import 'package:flutter_book_store_sample/shared/app_color.dart';

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
      home: SignInPage(),
    );
  }
}
