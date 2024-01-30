import 'package:flutter/material.dart';
import 'package:flutter_chat_application/auth/auth_services.dart';
import 'package:flutter_chat_application/chat_services/chat_Service.dart';
import 'package:flutter_chat_application/components/My_Drawer.dart';

import '../components/UserTile.dart';
import 'chat_page.dart';

class HomePage extends StatelessWidget {
  //When we come to the home page we have to display all the users and their details

  //we use the chat and auth services

  final ChatService _chatService= ChatService();
  final AuthService _authService= AuthService();
   HomePage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      drawer: MyDrawer(),
      body: _buildUserList(),
    );
  }

  //build the list of users except for the current logged in user
  Widget _buildUserList(){
    return StreamBuilder(
        stream: _chatService.getUsersStream(),
        builder: (context, snapshot){
          //error
          if(snapshot.hasError){
            return const Text('Error!!',style: TextStyle(color: Colors.red),);
          }
          //loading
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Text('Loading...');
          }

          //return list view
          return ListView(
            children: snapshot.data!.map<Widget>((userData)=> _buildUserListItem(userData,context)).toList(),
          );
        });
  }

  //build individual list tile for  user
Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context){
    //display all users except current user
   if (userData['email']!= _authService.getCurrentUser()!.email) {
     return UserTile(
       text: userData['email'],
       onTap: (){
         Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(
           receiveremail: userData['email'],
           receiverID: userData['uid'],
         ),));
       },
     );
   }else{
     return Container();
   }
}
}
