import 'package:flutter_book_store_sample/base/base_event.dart';

class SignUpFailEvent extends BaseEvent {
  final String errMessage;
  SignUpFailEvent(this.errMessage);
}
