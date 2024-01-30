import 'package:flutter/material.dart';
import 'package:flutter_chat_application/pages/Registration_page.dart';
import 'package:flutter_chat_application/pages/login_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  //initially we show the login page
  bool showLoginPage= true;

  //to registration we show registration page

  void togglePages()
  {
    setState(() {
      showLoginPage= !showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return LoginPage(onTap: togglePages,);
    }
    else
      {
        return Registration_Page(onTap: togglePages,);
      }
  }
}

