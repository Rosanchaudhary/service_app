class Message {
  String id;
  String message;
  String date;
  String sender;
  String sendBy;
  String chatType;
  String image;

  Message({
   required this.chatType,
   required this.date,
   required this.id,
   required this.image,
   required this.message,
   required this.sendBy,
   required this.sender,
  });
}
