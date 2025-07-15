import 'package:first_app/List.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'moudels/chat.dart';

class WhatAppScreen extends StatelessWidget {
  const WhatAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<chat> chatlist = [];
    chatlist = jsonmap.map((e) => chat.fromJson(e)).toList();
    return Scaffold(
      appBar: _myAppbar(),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              //call this fun to play archivedrow //teeeeest
              _buildCustomChats(
                text: "LockedChats",
                icon: CupertinoIcons.lock_fill,
              ),
              _buildCustomChats(
                text: "Archived",
                icon: CupertinoIcons.archivebox_fill,
                count: 3,
              ),
              Expanded(
                  child: ListView.separated(
                //shrinkWrap: true,

                separatorBuilder: (context, index) => const Divider(),
                itemCount: chatlist.length,
                itemBuilder: (context, index) =>
                    _buildChatItem(chatlist[index]),
              )),
            ],
          )),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Calls',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chats',
          ),
        ],
      ),
    );
  }

//listview component method
  Widget _buildChatItem(chat mychatmodel) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: Colors.green,
          radius: 20,
          backgroundImage: NetworkImage(mychatmodel.image!),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                mychatmodel.name!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              /*Text(
                mychatmodel.message!,
                style: TextStyle(color: Colors.blueGrey),
              ),*/
              _messageType(mychatmodel.messageType!,
                  text: "Heloo ${mychatmodel.name!}"),
            ],
          ),
        ),
        const Spacer(),
        Text(
          mychatmodel.createdAt!,
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

//AppBarStyleMethod
  AppBar _myAppbar() {
    return AppBar(
      backgroundColor: const Color(0xFF00c298),
      title: const Text(
        "WhatsApp",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: const [
        Icon(
          Icons.camera_alt,
          color: Colors.white,
        ),
        SizedBox(width: 20),
        Icon(
          Icons.search,
          color: Colors.white,
        ),
        SizedBox(width: 20),
        Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
      ],
    );
  }

  Widget _buildCustomChats({
    required IconData icon,
    required String text,
    int? count,
  }) {
    return Padding(
        padding: const EdgeInsetsDirectional.only(bottom: 20.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: const Color(0xFF00c298),
            ),
            const SizedBox(
              width: 15,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(text,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ))),
            const Spacer(),
            if (count != null) Text(count.toString())
          ],
        ));
  }

  Widget _messageType(
    MessageType messageType, {
    String? text,
  }) {
    if (messageType == MessageType.VIDEO) {
      return const Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(
            CupertinoIcons.videocam_fill,
            size: 20,
            color: Colors.grey,
          ),
          SizedBox(
            width: 4,
          ),
          Text(
            "Video",
            style: TextStyle(
              color: Colors.grey,
            ),
          )
        ],
      );
    } else if (messageType == MessageType.GIF) {
      return const Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(
            Icons.gif,
            size: 20,
            color: Colors.grey,
          ),
          SizedBox(
            width: 4,
          ),
          Text(
            "GIF",
            style: TextStyle(
              color: Colors.grey,
            ),
          )
        ],
      );
    } else {
      return Text(text ?? "");
    }
  }
}
