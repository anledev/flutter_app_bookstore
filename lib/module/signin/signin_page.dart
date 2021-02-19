import 'package:flutter/material.dart';
import 'package:flutter_book_store_sample/base/base_event.dart';
import 'package:flutter_book_store_sample/base/base_widget.dart';
import 'package:flutter_book_store_sample/data/remote/user_service.dart';
import 'package:flutter_book_store_sample/data/repo/user_repo.dart';
import 'package:flutter_book_store_sample/event/signin_event.dart';
import 'package:flutter_book_store_sample/event/signin_fail_event.dart';
import 'package:flutter_book_store_sample/event/signin_sucess_event.dart';
import 'package:flutter_book_store_sample/module/signin/signin_bloc.dart';
import 'package:flutter_book_store_sample/shared/app_color.dart';
import 'package:flutter_book_store_sample/shared/widget/bloc_listener.dart';
import 'package:flutter_book_store_sample/shared/widget/loading_task.dart';
import 'package:flutter_book_store_sample/shared/widget/normal_button.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      title: "Sign In",
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
      child: SignInFormWidget(),
    );
    // return Container();
  }
}

class DemoDI {}

class SignInFormWidget extends StatefulWidget {
  @override
  _SignInFormWidgetState createState() => _SignInFormWidgetState();
}

class _SignInFormWidgetState extends State<SignInFormWidget> {
  final TextEditingController _txtPhoneController = TextEditingController();

  final TextEditingController _txtPassController = TextEditingController();

  handleEvent(BaseEvent event) {
    if (event is SignInSuccessEvent) {
      Navigator.pushReplacementNamed(context, '/home');
      return;
    }

    if (event is SignInFailEvent) {
      final snackBar = SnackBar(
        content: Text(event.errMessage),
        backgroundColor: Colors.red,
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    print('rebuild');
    return ChangeNotifierProvider(
      create: (_) => SignInBloc(userRepo: Provider.of(context)),
      child: Consumer<SignInBloc>(
        builder: (context, bloc, child) {
          return BlocListener<SignInBloc>(
            listener: handleEvent,
            child: LoadingTask(
              bloc: bloc,
              child: Container(
                padding: EdgeInsets.all(25),
                child: viewOriginTut(context, bloc),
              ),
            ),
          );
        }
      ),
    );
  }

  Widget viewOriginTut(BuildContext context, SignInBloc bloc) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildPhoneField(bloc),
        _buildPassField(bloc),
        _buildSignInButton(bloc),
        _buildFooter(context)
      ],
    );
  }

  Widget _buildSignInButton(SignInBloc bloc){
    return StreamProvider<bool>.value(
      initialData: false,
      value: bloc.btnStream,
      child: Consumer<bool>(
        builder: (context, enable, child) => NormalButton(
          title: 'Sign In',
          onPressed: enable ? () {
            bloc.event.add(
              SignInEvent(
                phone: _txtPhoneController.text,
                pass: _txtPassController.text,
              ),
            );
          } : null,
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(top: 30),
        padding: EdgeInsets.all(10),
        child: FlatButton(
          onPressed: (){
            Navigator.pushNamed(context, '/sign-up');
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0)),
          child: Text(
            'Register Account',
            style: TextStyle(color: AppColor.blue, fontSize: 19),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneField(SignInBloc bloc) {
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

  Widget _buildPassField(SignInBloc bloc) {
    return StreamProvider<String>.value(
      initialData: null,
      value: bloc.passStream,
      child: Consumer<String>(
        builder: (context, msg, child) =>  Container(
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
