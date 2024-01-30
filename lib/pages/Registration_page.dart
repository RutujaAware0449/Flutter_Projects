import 'package:flutter/material.dart';
import 'package:flutter_chat_application/auth/auth_services.dart';
import 'package:flutter_chat_application/components/My_button.dart';
import 'package:flutter_chat_application/components/mytextfield.dart';

class Registration_Page extends StatelessWidget {

  final TextEditingController _emailController= TextEditingController();
  final TextEditingController _pwController= TextEditingController();
  final TextEditingController _confirmController= TextEditingController();
  final void Function()? onTap;
  Registration_Page({super.key,required this.onTap});

  //login for authentication
  void Register(BuildContext context){
    //get the auth services to register
    final _auth= AuthService();
    // _auth.signUpWithEmailAndPassword(_emailController.text, _pwController.text);

    //if password match then create a user
    if(_pwController.text==_confirmController.text){
      try{
        _auth.signUpWithEmailAndPassword(_emailController.text, _pwController.text);
      } catch(e){
        showDialog(context: context, builder: (context)=> AlertDialog(
          title: Text(e.toString()),
        ));
      }
    }

    //if the password does not match then show the error to the user
    else{
      showDialog(context: context, builder: (context)=> AlertDialog(
        title: Text('Enter Valid Details /n check password'),
      ));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(Icons.message_outlined,
              size: 50,
              color: Theme.of(context).colorScheme.primary,),
            SizedBox(height: 35,),
            //welcome back message
            Text("Let's create a new account ",
              style: TextStyle(color: Theme.of(context).colorScheme.primary,
                  fontSize: 18),),

            SizedBox(height: 40,),
            //email textfield
            MyTextField(hinttext: 'Email',obscure: false,controller: _emailController,),
            SizedBox(height: 15,),
            MyTextField(hinttext: 'Password', obscure: true,controller: _pwController,),
            SizedBox(height: 15,),
            MyTextField(hinttext: 'Confirm Password', obscure: true, controller: _confirmController),
            SizedBox(height: 15,),

            //login button
            MyButton(button_name: 'Register', onTap: ()=>Register(context)),
            SizedBox(height: 15,),
            //register  now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already a member?',style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 15,
                ),),
                GestureDetector(
                  onTap: onTap,
                  child: Text('Login Now',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 15,
                    ),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
