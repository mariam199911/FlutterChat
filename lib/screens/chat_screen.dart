import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/chat/messages.dart';
import '../widgets/chat/new_message.dart';

class chatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('flutterChat'),
        actions: [
          DropdownButton(
            underline: Container(),
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.exit_to_app,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(width: 8),
                      Text('Logout'),
                    ],
                  ),
                ),
                value: 'logout',
              ),
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
      ),
      body: Container(
          child: Column(
        children: [
          Expanded(child: Messages()),
          NewMessage(),
        ],
      )),

      //  StreamBuilder(
      //   stream: Firestore.instance
      //       .collection('chats/z4H21oj01hxnvjMYn6S5/messages')
      //       .snapshots(),
      //   builder: (ctx, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //     final documents = snapshot.data.documents;
      //     return Container(
      //       child: ListView.builder(
      //         itemCount: documents.length,
      //         itemBuilder: (ctx, index) => Container(
      //           padding: EdgeInsets.all(8),
      //           child: Text(documents[index]['text']),
      //         ),
      //       ),
      //     );
      //   },
      // ),

      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //     Firestore.instance
      //         .collection('chats/z4H21oj01hxnvjMYn6S5/messages')
      //         .add({
      //       'text': 'new one',
      //     });
      //   },
      // ),
    );
  }
}
