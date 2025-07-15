import 'dart:async';

import 'package:first_app/MyProjects/E_commerce/helpers/hive_helpr.dart';
import 'package:first_app/MyProjects/E_commerce/login/Loginscreen.dart';
import 'package:first_app/MyProjects/E_commerce/main/main_screen.dart';
import 'package:first_app/MyProjects/E_commerce/onboarding/Onboarding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Splach extends StatefulWidget {
  const Splach({super.key});

  @override
  State<Splach> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Splach> {
  Color _color = Colors.white;
  int imageNum = 1;
  //Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewScreen()));
  void _changeSplash() {
    if (imageNum == 1) {
      _color = Colors.white;
      imageNum = 2;
    } else {
      _color = const Color.fromARGB(255, 7, 10, 8);
      imageNum = 1;
    }
    setState(() {});
  }

  @override
  void initState() {
    const oneSec = Duration(seconds: 1);
    var time = Timer.periodic(oneSec, (Timer t) => _changeSplash());

    Future.delayed(const Duration(seconds: 6)).then(
      (val) {
        time.cancel();
        if (HiveHelper.checkOnboardingBox()) {
          if (HiveHelper.getToken()?.isEmpty ?? true) {
            Get.offAll(Loginscreen());
          } else {
            Get.offAll(MainScreen());
          }
        } else {
          Get.offAll(Onboarding());
        }
      },
    );

    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _color,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 350),
            child: Container(
                child: Image.asset("assets/images/Logo$imageNum.png")),
          ),
          const Spacer(),
          Container(child: Image.asset("assets/images/design.png")),
        ],
      ),
    );
  }
}
