

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_application/auth/auth_services.dart';
import 'package:flutter_chat_application/chat_services/chat_Service.dart';
import 'package:flutter_chat_application/components/chat_bubble.dart';
import 'package:flutter_chat_application/components/mytextfield.dart';

class ChatPage extends StatefulWidget {
  final String receiveremail;
  final String receiverID;
   ChatPage({super.key,required this.receiveremail,required this.receiverID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  //text Controller
  final TextEditingController _messageController = TextEditingController();

  //Chat and Auth Services
  final ChatService _chatService= ChatService();

  final AuthService _authService= AuthService();
  //for textfieldfocus
  FocusNode myfocusNode = FocusNode();
  @override
  void initState(){
    super.initState();
    //add listener
    myfocusNode.addListener(() {
      if(myfocusNode.hasFocus){
        //cause a delay so that the keyboard has time to show up
        Future.delayed(Duration(milliseconds: 500),() => scrollDown(),);
      }
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    myfocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }
  //Scroll controller
  final ScrollController _scrollController= ScrollController();
  void scrollDown(){
    _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }
  //send message
  void sendMessage() async{
    // if there is something in textfield
    if(_messageController.text.isNotEmpty){
      // send the message
      await _chatService.sendMessage(widget.receiverID, _messageController.text);

      //clear the text Controller
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiveremail),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          //all the messages
          Expanded(child: _buildMessageList()),
          //user input
          _buildUserInput(),
        ],
      ),
    );
  }

  //build the message list
  Widget _buildMessageList(){
    String senderID= _authService.getCurrentUser()!.uid;
    return StreamBuilder(stream: _chatService.getMessages(widget.receiverID, senderID),
        builder: (context, snapshot){
      //errors
          if(snapshot.hasError){
            return const Text('Error');
          }
          //loading
          if(snapshot.connectionState== ConnectionState.waiting){
            return const Text("Loading");
          }

          //return List view
          return ListView(
            controller: _scrollController,
            children: snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
          );


        });
  }

  Widget _buildMessageItem(DocumentSnapshot doc){
    Map<String, dynamic> data= doc.data() as Map<String, dynamic>;

    //is Current user
    bool isCurrentUser = data['senderID']== _authService.getCurrentUser()!.uid;
    // alignment
    var alignment= isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment: isCurrentUser? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            ChatBubble(isCurrentUser: isCurrentUser, message: data['message'])
          ],
        ));
  }

  //build message input
  Widget _buildUserInput(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Row(
        children: [
          //text Field
          Expanded(child: MyTextField(hinttext: 'Type a message', controller: _messageController,
              obscure: false,),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
              margin: EdgeInsets.only(right: 25),
              child: IconButton(onPressed: sendMessage, icon: Icon(Icons.arrow_upward,color: Colors.white,)))
        ],
      ),
    );
  }
}
