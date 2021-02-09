import 'package:flutter/cupertino.dart';
import 'package:flutter_book_store_sample/base/base_bloc.dart';
import 'package:flutter_book_store_sample/base/base_event.dart';
import 'package:flutter_book_store_sample/data/repo/user_repo.dart';
import 'package:flutter_book_store_sample/event/signup_event.dart';
import 'package:flutter_book_store_sample/event/singin_event.dart';

class SignInBloc extends BaseBloc {
  UserRepo _userRepo;

  SignInBloc({@required UserRepo userRepo}) : _userRepo = userRepo;

  @override
  void dispatchEvent(BaseEvent event) {
    switch (event.runtimeType) {
      case SignInEvent:
        handleSignIn(event);
        break;
      case SignUpEvent:
        handleSignUp(event);
        break;
    }
  }

  handleSignIn(event) {
    SignInEvent e = event as SignInEvent;
    _userRepo.signIn(e.phone, e.pass).then(
      (userData) {
        print(userData);
      },
      onError: (e) {
        print(e);
      },
    );
  }

  handleSignUp(event) {}

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
