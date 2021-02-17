import 'package:flutter/cupertino.dart';
import 'package:flutter_book_store_sample/base/base_event.dart';

class SignUpEvent extends BaseEvent {
  String displayName;
  String phone;
  String pass;

  SignUpEvent({@required this.displayName, @required this.phone, @required this.pass});
}
