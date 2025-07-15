import 'dart:async';

import 'package:first_app/MyProjects/NoteApp/Notescreen.dart';
import 'package:flutter/material.dart';

class noteSplash extends StatefulWidget {
  const noteSplash ({super.key});

  @override
  State<noteSplash> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<noteSplash> {
  Color _color = Colors.white;
  int imageNum = 1;
  //Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewScreen()));
  void _changenoteSplash() {
    if (imageNum == 1) {
      _color = Colors.black;
      imageNum = 2;
    } else {
      _color = Colors.white;
      imageNum = 1;
    }
    setState(() {});
  }

  @override
  void initState() {
    const oneSec = Duration(seconds: 1);
    var time = Timer.periodic(oneSec, (Timer t) => _changenoteSplash());

    Future.delayed(const Duration(seconds: 6)).then(
      (val) {
        time.cancel();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const Notescreen()));
      },
    );

    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _color,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top:200),
              child: Container(
                  child: Image.asset("assets/images/notesplash$imageNum.png")),
            ),
           
          ],
        ),
      ),
    );
  }
}
