import 'package:chat_demo/model/message.dart';
import 'package:chat_demo/screens/chat_screen/mesage_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _textController = TextEditingController();
  final String _sender = 'John'; // Set your sender name here



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('messages').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                List<MessageBubble> messageBubbles = [];
                for (var document in snapshot.data!.docs) {
                 // Message message = Message.fromMap(document);
                  messageBubbles.add(MessageBubble(message: Message(text: 'Hello asdd a sadada asdasda  asdd asd sdad', sender: _sender)));
                }
               // messageBubbles.add(MessageBubble(message: Message(text: 'Hello', sender: '01')));
                return ListView(
                  reverse: true,
                  physics: const BouncingScrollPhysics(),
                  children: messageBubbles,
                );
              },
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.greenAccent,
              border: Border(
                top: BorderSide(
                  color:Colors.cyan,
                  width: 2.0,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message',
                      border: InputBorder.none,
                      filled: false,
                      contentPadding: EdgeInsets.all(16.0),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  void _sendMessage() async {
    String text = _textController.text.trim();
    if (text.isNotEmpty) {
      Message message = Message(text: text, sender: _sender);
      await _firestore.collection('messages').add(message.toMap());
      _textController.clear();
    }
  }
}




