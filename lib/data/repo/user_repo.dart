import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_book_store_sample/data/remote/user_service.dart';
import 'package:flutter_book_store_sample/data/spref/spref.dart';
import 'package:flutter_book_store_sample/shared/constant.dart';
import 'package:flutter_book_store_sample/shared/models/user_data.dart';

class UserRepo {
  UserService _userService;

  UserRepo({@required UserService userService}) : _userService = userService;

  Future<UserData> signIn(String phone, String pass) async {
    var c = Completer<UserData>();
    try {
      var response = await _userService.signIn(phone, pass);
      print("Response: $response");
      var userData = UserData.fromJson(response.data['data']);
      if (userData != null) {
        SPref.instance.set(SPrefCache.KEY_TOKEN, userData.token);
        c.complete(userData);
      }
    } on DioError catch (e) {
      c.completeError("SignIn Failed");
    } catch (e) {
      print("Error catch");
      c.completeError(e);
    }
    return c.future;
  }
}
