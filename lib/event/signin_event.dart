import 'package:flutter/widgets.dart';
import 'package:flutter_book_store_sample/base/base_event.dart';

class SignInEvent extends BaseEvent {
  String phone;
  String pass;

  SignInEvent({@required this.phone, @required this.pass});
}
