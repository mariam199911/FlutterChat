// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class NewMessage extends StatefulWidget {
//   @override
//   _NewMessageState createState() => _NewMessageState();
// }

// class _NewMessageState extends State<NewMessage> {
//   var _message = '';
//   void sendMessage() {
//     FocusScope.of(context).unfocus();
//     Firestore.instance.collection('chat').add(
//       {
//         'text': _message,
//         'sendAt': Timestamp.now(),
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(top: 6),
//       margin: EdgeInsets.all(6),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//                 textCapitalization: TextCapitalization.sentences,
//                 autocorrect: true,
//                 enableSuggestions: true,
//                 decoration: InputDecoration(labelText: 'Send a message...'),
//                 onChanged: (value) {
//                   setState(() {
//                     _message = value;
//                   });
//                 }),
//           ),
//           IconButton(
//             color: Theme.of(context).primaryColor,
//             onPressed: _message.trim().isEmpty ? null : () {},
//             icon: Icon(Icons.send),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = new TextEditingController();
  var _enteredMessage = '';

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    //final user = FirebaseAuth.instance.currentUser;
    // final userData = await Firestore.instance
    //     .collection('users')
    //     .document(user.uid)
    //     .get();
    Firestore.instance.collection('chat').add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      // 'userId': user.uid,
      // 'username': userData.data()['username'],
      // 'userImage': userData.data()['image_url']
    });
    // _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              //controller: _controller,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: InputDecoration(labelText: 'Send a message...'),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(
              Icons.send,
            ),
            onPressed: _enteredMessage.trim().isEmpty ? null : () {},
          )
        ],
      ),
    );
  }
}