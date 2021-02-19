import 'package:flutter_book_store_sample/base/base_event.dart';
import 'package:flutter_book_store_sample/shared/models/user_data.dart';

class SignInSuccessEvent extends BaseEvent {
  final UserData userData;
  SignInSuccessEvent(this.userData);
}
