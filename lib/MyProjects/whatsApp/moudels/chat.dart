class chat {
  String? name;
  String? message;
  String? image;
  String? createdAt;
  MessageType? messageType;

  chat.fromJson(Map json) {
    name = json["name"];
    message = json["message"];
    image = json["image"];
    createdAt = json["createdAt"];

    switch (json["message_type"]) {
      case "video":
        messageType = MessageType.VIDEO;

      case "GIF":
        messageType = MessageType.GIF;

      default:
        messageType = MessageType.MESSAGE;
    }
  }
}

// act as fixed data type
enum MessageType {
  VIDEO,
  GIF,
  MESSAGE,
}
