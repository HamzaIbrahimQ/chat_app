import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:max_chat_app/widgets/chat/messages.dart';
import 'package:max_chat_app/widgets/chat/new_message.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_analytics/firebase_analytics.dart';



class ChatScreen extends StatefulWidget {


  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  @override
  void initState() {
    super.initState();
    final fbm = FirebaseMessaging.instance;
    fbm.requestPermission();
    FirebaseMessaging.onMessage.listen((msg) {
      print('msssssssgggggggggggggggggggggg:' + msg.sentTime.toString());
      return;
    },);
    FirebaseMessaging.onMessageOpenedApp.listen((msg) {
      print('msssssssgggggggggggggggggggggg:' + msg.sentTime.toString());
      return;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        actions: [
          DropdownButton(
            underline: Container(),
            icon: Icon(Icons.more_vert, color: Theme.of(context).primaryIconTheme.color,),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 8,),
                      Text('Logout'),
                    ],
                  ),
                ),
                value: 'logout',
              ),
            ],
            onChanged: (item) {
              if (item == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
