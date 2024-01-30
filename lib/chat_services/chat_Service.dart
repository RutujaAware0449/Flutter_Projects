import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_application/models/message.dart';
class ChatService{
  //first create the instance of firestore package
  //means import the firestore package
  final FirebaseFirestore _firestore= FirebaseFirestore.instance;
  // final FirebaseFirestore _firestore= FirebaseFirestore.instance;
  final FirebaseAuth _auth= FirebaseAuth.instance;


  //get user stream
  Stream<List<Map<String,dynamic>>> getUsersStream(){
    return _firestore.collection('Users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc){
        //go through each individual user
        final user= doc.data();
        //return user
        return user;
      }).toList();
    });
  }
  //send message
  Future<void> sendMessage(String receiver, message) async{
    //get the current user info
   final String currentUserID= _auth.currentUser!.uid;
   final String? currentUserEmails= _auth.currentUser!.email;
   final Timestamp timestamp= Timestamp.now();


    //create a new message
    Message newMessage = Message(
        senderID: currentUserID,
        SenderEmail: currentUserEmails!,
        receiverID: receiver,
        timestamp: timestamp,
        message: message
    );

    //construct chat room ID for two users(sorted to ensure uniqueness)
    List<String> ids =[currentUserID,receiver];
    ids.sort();  //sort the ids
    String chatRoomID = ids.join('_');

    //add new message to the database

    await _firestore.collection("chat_rooms").doc(chatRoomID).collection('messages').add(newMessage.toMap());
  }
  //get message
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(String userID, otherUserID){
    //construct the chatroom ID for te two users
    List<String> ids= [userID, otherUserID];
    ids.sort();
    String chatRoomID= ids.join('_');

    return _firestore.collection("chat_rooms").doc(chatRoomID).collection("messages").orderBy("timestamp", descending: false).snapshots();
  }
}