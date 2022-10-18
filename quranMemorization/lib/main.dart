import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quran_memorization/core/controller/session_controller.dart';
import 'package:quran_memorization/core/controller/students_controller.dart';
import 'package:quran_memorization/core/services/hive_boxes.dart';
import 'package:quran_memorization/model/assignment_model.dart';
import 'package:quran_memorization/model/session_model.dart';
import 'package:quran_memorization/model/student_model.dart';
import 'package:quran_memorization/model/surah_model.dart';
import 'package:quran_memorization/ui_componants/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:quran_memorization/view/home_view.dart';
import 'package:quran_memorization/view/new_session_view.dart';
import 'package:quran_memorization/view/onboarding/onboarding_view.dart';
import 'package:quran_memorization/view/sessions_view.dart';
import 'package:quran_memorization/view/students_view.dart';
import 'package:quran_memorization/view/test_componant.dart';
import 'package:device_preview/device_preview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(StudentAdapter());
  Hive.registerAdapter(AssignmentAdapter());
  Hive.registerAdapter(SessionAdapter());
  Hive.registerAdapter(SurahAdapter());

  await Hive.openBox<Student>('students');
  await Hive.openBox<bool>("onboarding");
  await Hive.openBox<Session>('sessions');
  await Hive.openBox<Assignment>('assignments');
  Boxes.assignmentsBox().values.forEach((element) {
    log(element.toVerse.toString());
  });
  // log(Boxes.onBoardingBox().values.first.toString());
  //runApp(DevicePreview(builder: (context) => MyApp()), );

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (context, _) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        //    builder: DevicePreview.appBuilder,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ar', 'EN'),
        ],
        locale: const Locale('ar', 'EN'),
        theme: Themes.lightTheme,
        home: Boxes.onBoardingBox().containsKey(1)
            ? HomeView()
            : OnBoardingView(),
        getPages: [
          GetPage(
            page: () => HomeView(),
            name: '/home',
          ),
          GetPage(
              page: () => StudentView(),
              name: '/students',
              binding: BindingsBuilder(() {
                Get.put(StudentsController());
                Get.lazyPut(() => SessionController());
              })),
          GetPage(
              page: () => SessionsView(),
              name: '/sessions',
              binding: BindingsBuilder(() {
                Get.put((SessionController()));
                Get.lazyPut(() => StudentsController());
              })),
          GetPage(
              page: () => NewSessionView(),
              name: '/new_session',
              binding: BindingsBuilder(() {
                Get.put((SessionController()));
                Get.lazyPut(() => StudentsController());
              })),
        ],
      );
    });
  }
}
