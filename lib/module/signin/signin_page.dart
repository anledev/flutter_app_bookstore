import 'package:flutter/material.dart';
import 'package:flutter_book_store_sample/base/base_widget.dart';
import 'package:flutter_book_store_sample/data/remote/user_service.dart';
import 'package:flutter_book_store_sample/data/repo/user_repo.dart';
import 'package:flutter_book_store_sample/event/singin_event.dart';
import 'package:flutter_book_store_sample/module/signin/signin_bloc.dart';
import 'package:flutter_book_store_sample/shared/app_color.dart';
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

class SignInFormWidget extends StatelessWidget {
  final TextEditingController _txtPhoneController = TextEditingController();
  final TextEditingController _txtPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Provider<SignInBloc>.value(
      value: SignInBloc(userRepo: Provider.of(context)),
      child: Consumer<SignInBloc>(
        builder: (context, bloc, child) => Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildPhoneField(),
              _buildPassField(),
              NormalButton(
                onPressed: () {
                  bloc.event.add(
                    SignInEvent(
                      phone: _txtPhoneController.text,
                      pass: _txtPassController.text,
                    ),
                  );
                },
              ),
              _buildFooter()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(top: 30),
        padding: EdgeInsets.all(10),
        child: Text(
          'Register Account',
          style: TextStyle(color: AppColor.blue, fontSize: 19),
        ),
      ),
    );
  }

  Widget _buildPhoneField() {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: _txtPhoneController,
        cursorColor: Colors.black,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          icon: Icon(Icons.phone, color: AppColor.blue),
          hintText: 'Phone',
          labelText: 'Phone',
          labelStyle: TextStyle(color: AppColor.blue),
        ),
      ),
    );
  }

  Widget _buildPassField() {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      child: TextFormField(
        controller: _txtPassController,
        obscureText: true,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          icon: Icon(Icons.lock, color: AppColor.blue),
          hintText: 'Password',
          labelText: 'Password',
          labelStyle: TextStyle(color: AppColor.blue),
        ),
      ),
    );
  }
}
