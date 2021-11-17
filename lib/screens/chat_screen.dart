import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('chats/LB10tNUGg1EQXCvC0rOd/messages').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final documents = snapshot.data!.docs;
            return ListView.builder(
              itemCount:documents.length,
              itemBuilder:(cxt,index)=> Container(
                padding: const EdgeInsets.all(8),
                child: Text(documents[index]['text']),

              ) ,
            );
          }
        ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
           FirebaseFirestore.instance.collection('chats/LB10tNUGg1EQXCvC0rOd/messages').add({
             'text':'text added by pressing + button!'
           });
        },
      ),
    );
  }
}