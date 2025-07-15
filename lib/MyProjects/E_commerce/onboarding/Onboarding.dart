import 'package:first_app/Const.dart';
import 'package:first_app/MyProjects/E_commerce/helpers/hive_helpr.dart';
import 'package:first_app/MyProjects/E_commerce/login/Loginscreen.dart';
import 'package:first_app/MyProjects/E_commerce/onboarding/model/onboardingmodel.dart';

import 'package:flutter/material.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});
  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int index = 0;
  void _onTap() {
    if (index < onBoardingList.length - 1) {
      index++;
      setState(() {});
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const Loginscreen()));
    }
  }

  @override
  void initState() {
    HiveHelper.isFirstTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 215, 238, 212),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Center(
                child: Expanded(
                    child: Container(
                        child: Image.asset(
                            imagePath + onBoardingList[index].image!)))),
            Expanded(
              child: Container(
                child: Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Image.asset("assets/images/Rectangle.png"),
                    ),
                    Center(
                        child: Text(
                      onBoardingList[index].title!,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    )),

                    // Positioned FloatingActionButton
                    Positioned(
                      bottom: 10.0, // Adjust as needed
                      right: 140.0, // Adjust as needed

                      child: FloatingActionButton(
                        backgroundColor:
                            const Color.fromARGB(255, 110, 165, 103),
                        onPressed: () => _onTap(),
                        mini: false,
                        shape: const CircleBorder(),
                        child: const Icon(Icons.forward),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
