import 'package:flutter/material.dart';





class MessageBubble extends StatelessWidget {

  MessageBubble(this.message, this.userName, this.imageUrl, this.isMe, {this.key});

  final String message;
  final bool isMe;
  final String userName;
  final String imageUrl;
  final Key key;


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
                borderRadius: BorderRadius.circular(12),
              ),
              width: 140,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Column(
                crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                  ),
                  SizedBox(height: 2,),
                  Text(
                    message,
                    style: TextStyle(color: isMe ? Colors.black : Theme.of(context).accentTextTheme.headline1.color),
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: -10,
          left: isMe ? null : 130,
          right: isMe ? 130 : null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
        ),
      ],
      clipBehavior: Clip.none,
    );
  }
}


