class Message {
  final String text;
  final String sender;

  Message({
    required this.text,
    required this.sender,
  });

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      text: map['text'],
      sender: map['sender'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'sender': sender,
    };
  }
}