import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_book_store_sample/base/base_bloc.dart';
import 'package:flutter_book_store_sample/base/base_event.dart';
import 'package:flutter_book_store_sample/data/repo/user_repo.dart';
import 'package:flutter_book_store_sample/event/signup_event.dart';
import 'package:flutter_book_store_sample/event/singin_event.dart';
import 'package:flutter_book_store_sample/shared/validation.dart';
import 'package:rxdart/rxdart.dart';

class SignUpBloc extends BaseBloc {
  final _displayNameSubject = BehaviorSubject<String>();
  final _phoneSubject = BehaviorSubject<String>();
  final _passSubject = BehaviorSubject<String>();
  final _btnSubject = BehaviorSubject<bool>();

  UserRepo _userRepo;

  SignUpBloc({@required UserRepo userRepo}) {
    _userRepo = userRepo;
    validateForm();
  }

  var displayNameValidation =
  StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (Validation.isDisplayNameValid(name)) {
      sink.add(null);
      return;
    }
    sink.add('Display name too short');
  });

  var phoneValidation =
      StreamTransformer<String, String>.fromHandlers(handleData: (phone, sink) {
    if (Validation.isPhoneValid(phone)) {
      sink.add(null);
      return;
    }
    sink.add('Phone Invalid');
  });

  var passValidation =
  StreamTransformer<String, String>.fromHandlers(handleData: (pass, sink) {
    if (Validation.isPassValid(pass)) {
      sink.add(null);
      return;
    }
    sink.add('Password too short');
  });

  Stream<String> get displayNameStream => _displayNameSubject.stream.transform(displayNameValidation);

  Sink<String> get displayNameSink => _displayNameSubject.sink;

  Stream<String> get phoneStream => _phoneSubject.stream.transform(phoneValidation);

  Sink<String> get phoneSink => _phoneSubject.sink;

  Stream<String> get passStream => _passSubject.stream.transform(passValidation);

  Sink<String> get passSink => _passSubject.sink;

  Stream<bool> get btnStream => _btnSubject.stream;

  Sink<bool> get btnSink => _btnSubject.sink;

  validateForm() {
    Observable.combineLatest3(_displayNameSubject, _phoneSubject, _passSubject, (displayName, phone, pass) {
      return Validation.isDisplayNameValid(displayName) && Validation.isPhoneValid(phone) && Validation.isPassValid(pass);
    }).listen((enable) {
      btnSink.add(enable);
    });
  }

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

  handleSignUp(event) {
    SignUpEvent e = event as SignUpEvent;
    _userRepo.signUp(e.displayName, e.phone, e.pass).then(
          (userData) {
        print(userData);
      },
      onError: (e) {
        print(e);
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _displayNameSubject.close();
    _phoneSubject.close();
    _passSubject.close();
    _btnSubject.close();
  }
}
