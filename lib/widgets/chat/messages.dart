import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
          stream: Firestore.instance
              .collection('chat')
              .orderBy(
                'sendAt',
                descending: true,
              )
              .snapshots(),
          builder: (ctx, chatSnapshot) {
            if (chatSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final chatDocs = chatSnapshot.data.documents;
            return ListView.builder(
              padding: EdgeInsets.zero,

              reverse: true,
              itemCount: chatDocs.length,
              itemBuilder: (ctx, index) => MessageBubble(
                chatDocs[index]['text'],
                chatDocs[index]['userId'] == snapshot.data.uid,
                key: ValueKey(chatDocs[index].documentID),
                //style: TextStyle(color: Theme.of(context).primaryColor)
              ),

              //   MessageBubble(
              //    chatDocs[index].data()['text'],
              // //   chatDocs[index].data()['username'],
              // //   chatDocs[index].data()['userImage'],
              //    chatDocs[index].data()['userId'] == user.uid,
              // //   key: ValueKey(chatDocs[index].id),
              //  ),
            );
          },
        );
      },
    );
  }
}
