import 'package:flutter/material.dart';
import 'package:flutter_book_store_sample/base/base_event.dart';
import 'package:flutter_book_store_sample/base/base_widget.dart';
import 'package:flutter_book_store_sample/data/remote/user_service.dart';
import 'package:flutter_book_store_sample/data/repo/user_repo.dart';
import 'package:flutter_book_store_sample/event/signup_event.dart';
import 'package:flutter_book_store_sample/event/signup_fail_event.dart';
import 'package:flutter_book_store_sample/event/signup_sucess_event.dart';
import 'package:flutter_book_store_sample/module/home/home_page.dart';
import 'package:flutter_book_store_sample/module/signup/signup_bloc.dart';
import 'package:flutter_book_store_sample/shared/app_color.dart';
import 'package:flutter_book_store_sample/shared/widget/bloc_listener.dart';
import 'package:flutter_book_store_sample/shared/widget/loading_task.dart';
import 'package:flutter_book_store_sample/shared/widget/normal_button.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      title: "Sign Up",
      di: [
        Provider.value(
          value: UserService(),
        ),
        ProxyProvider<UserService, UserRepo>(
          update: (context, userService, previous) =>
              UserRepo(userService: userService),
        ),
      ],
      bloc: [],
      child: SignUpFormWidget(),
    );
    // return Container();
  }
}

class SignUpFormWidget extends StatefulWidget {
  @override
  _SignUpFormWidgetState createState() => _SignUpFormWidgetState();
}

class _SignUpFormWidgetState extends State<SignUpFormWidget> {
  final TextEditingController _txtDisplayNameController =
      TextEditingController();

  final TextEditingController _txtPhoneController = TextEditingController();

  final TextEditingController _txtPassController = TextEditingController();

  handleEvent(BaseEvent event) {
    if (event is SignUpSuccessEvent) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => HomePage()),
        ModalRoute.withName('/home'),
      );
      return;
    }

    if (event is SignUpFailEvent) {
      final snackBar = SnackBar(
        content: Text(event.errMessage),
        backgroundColor: Colors.red,
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => SignUpBloc(userRepo: Provider.of(context)),
        child: Consumer<SignUpBloc>(builder: (ctx, bloc, child) {
          return BlocListener<SignUpBloc>(
            listener: handleEvent,
            child: LoadingTask(
              bloc: bloc,
              child: Container(
                padding: EdgeInsets.all(25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDisplayNameField(bloc),
                    _buildPhoneField(bloc),
                    _buildPassField(bloc),
                    _buildSignUpButton(bloc),
                  ],
                ),
              ),
            ),
          );
        }));
  }

  Widget _buildSignUpButton(SignUpBloc bloc) {
    return StreamProvider<bool>.value(
      initialData: false,
      value: bloc.btnStream,
      child: Consumer<bool>(
        builder: (context, enable, child) => NormalButton(
          title: 'Sign Up',
          onPressed: enable
              ? () {
                  bloc.event.add(
                    SignUpEvent(
                      displayName: _txtDisplayNameController.text,
                      phone: _txtPhoneController.text,
                      pass: _txtPassController.text,
                    ),
                  );
                }
              : null,
        ),
      ),
    );
  }

  Widget _buildDisplayNameField(SignUpBloc bloc) {
    return StreamProvider<String>.value(
      initialData: null,
      value: bloc.displayNameStream,
      child: Consumer<String>(
        builder: (context, msg, child) => Container(
          margin: EdgeInsets.only(bottom: 15),
          child: TextField(
            textInputAction: TextInputAction.next,
            onChanged: (text) {
              bloc.displayNameSink.add(text);
            },
            controller: _txtDisplayNameController,
            cursorColor: Colors.black,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              icon: Icon(Icons.person, color: AppColor.blue),
              hintText: 'Display Name',
              labelText: 'Display Name',
              errorText: msg,
              labelStyle: TextStyle(color: AppColor.blue),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneField(SignUpBloc bloc) {
    return StreamProvider<String>.value(
      initialData: null,
      value: bloc.phoneStream,
      child: Consumer<String>(
        builder: (context, msg, child) => Container(
          margin: EdgeInsets.only(bottom: 15),
          child: TextField(
            textInputAction: TextInputAction.next,
            onChanged: (text) {
              bloc.phoneSink.add(text);
            },
            controller: _txtPhoneController,
            cursorColor: Colors.black,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              icon: Icon(Icons.phone, color: AppColor.blue),
              hintText: 'Phone',
              labelText: 'Phone',
              errorText: msg,
              labelStyle: TextStyle(color: AppColor.blue),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPassField(SignUpBloc bloc) {
    return StreamProvider<String>.value(
      initialData: null,
      value: bloc.passStream,
      child: Consumer<String>(
        builder: (context, msg, child) => Container(
          margin: EdgeInsets.only(bottom: 25),
          child: TextField(
            textInputAction: TextInputAction.done,
            onChanged: (text) {
              bloc.passSink.add(text);
            },
            controller: _txtPassController,
            obscureText: true,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              icon: Icon(Icons.lock, color: AppColor.blue),
              hintText: 'Password',
              labelText: 'Password',
              errorText: msg,
              labelStyle: TextStyle(color: AppColor.blue),
            ),
          ),
        ),
      ),
    );
  }
}
