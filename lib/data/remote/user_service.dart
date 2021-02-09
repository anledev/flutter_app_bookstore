import 'package:dio/dio.dart';
import 'package:flutter_book_store_sample/network/book_client.dart';

class UserService {
  Future<Response> signIn(String phone, String pass) {
    return BookClient.instance.dio.post(
      'user/sign-in',
      data: {
        'phone': phone,
        'password': pass,
      },
    );
  }
}
