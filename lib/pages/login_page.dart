import 'package:flutter/material.dart';
import 'package:flutter_chat_application/auth/auth_services.dart';
import 'package:flutter_chat_application/components/My_button.dart';
import 'package:flutter_chat_application/components/mytextfield.dart';

class LoginPage extends StatelessWidget {

  final TextEditingController _emailController= TextEditingController();
  final TextEditingController _pwController= TextEditingController();
  final void Function()? onTap;
   LoginPage({super.key,required this.onTap});

   //login for authentication
  void login(BuildContext context) async{
  //get the auth  services
    final authService= AuthService();

    //try login
    try{
      await authService.signInWithEmailAndPassword(_emailController.text, _pwController.text);
    }
    //catch any error then show a dialog box
    catch(e){
      showDialog(context: context, builder: (context)=> AlertDialog(
        title: Text(e.toString()),
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
            Text('Welcome Back, You have been missed!',
            style: TextStyle(color: Theme.of(context).colorScheme.primary,
            fontSize: 18),),

            SizedBox(height: 40,),
            //email textfield
            MyTextField(hinttext: 'Email',obscure: false,controller: _emailController,),
            SizedBox(height: 15,),
            MyTextField(hinttext: 'Password', obscure: true,controller: _pwController,),

            SizedBox(height: 15,),

            //login button
            MyButton(button_name: 'Log In', onTap: ()=> login(context),),
            SizedBox(height: 15,),
            //register  now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Not a member?',style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 15,
                ),),
                GestureDetector(
                  onTap: onTap,
                  child: Text('Register Now',
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
