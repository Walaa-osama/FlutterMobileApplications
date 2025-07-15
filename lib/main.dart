import 'package:device_preview/device_preview.dart';
import 'package:first_app/MyProjects/BMI/BmiScreen.dart';
import 'package:first_app/MyProjects/BMI/cubit/bmi_cubit.dart';
import 'package:first_app/MyProjects/E_commerce/helpers/dio_helpers.dart';
import 'package:first_app/MyProjects/E_commerce/helpers/hive_helpr.dart';
import 'package:first_app/MyProjects/E_commerce/login/cubit/login_cubit.dart';
import 'package:first_app/MyProjects/E_commerce/splash/Splach.dart';

import 'package:first_app/MyProjects/NoteApp/hive_helpers.dart';
import 'package:first_app/MyProjects/NoteApp/note_splash/noteSplash.dart';
import 'package:first_app/MyProjects/whatsApp/WhatAppScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  //await Hive.openBox(HiveHelpers.notesBox);
  await Hive.openBox(HiveHelper.onboardingBox);
  await Hive.openBox(HiveHelper.token);

  DioHelpers.init();

  runApp(DevicePreview(builder: (context) => const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider(create: (context) => BmiCubit()),
        BlocProvider(create: (context) => LoginCubit()),
      ],
      // to use get should use GetMaterialApp instead of MaterialApp
      child: GetMaterialApp(
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        // theme: ThemeData.dark(),
        home: const Splach(),
      ),
    );
  }
}
