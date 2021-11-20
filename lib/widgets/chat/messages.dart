import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (cxt, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final documents = snapshot.data!.docs;
        final user = FirebaseAuth.instance.currentUser!;
        if (user != null) {
          return ListView.builder(
            reverse: true,
            itemCount: documents.length,
            itemBuilder: (cxt, index) => MessageBubble(documents[index]['text'],
                documents[index]['userId'] == user.uid,key: ValueKey(documents[index].id),),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
