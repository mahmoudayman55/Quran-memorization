import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quran_memorization/core/controller/session_controller.dart';
import 'package:quran_memorization/core/controller/students_controller.dart';
import 'package:quran_memorization/core/services/constants.dart';
import 'package:quran_memorization/core/services/hive_boxes.dart';
import 'package:quran_memorization/core/services/quran.dart';
import 'package:quran_memorization/model/assignment_model.dart';
import 'package:quran_memorization/model/session_model.dart';
import 'package:quran_memorization/model/student_model.dart';
import 'package:quran_memorization/model/surah_model.dart';
import 'package:quran_memorization/ui_componants/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:quran_memorization/view/home_view.dart';
import 'package:quran_memorization/view/new_session_view.dart';
import 'package:quran_memorization/view/sessions_view.dart';
import 'package:quran_memorization/view/students_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(StudentAdapter());
  await Hive.openBox<Student>('students');

  Hive.registerAdapter(SessionAdapter());
  Hive.registerAdapter(AssignmentAdapter());
  Hive.registerAdapter(SurahAdapter());
  await Hive.openBox<Session>('sessions');

  var box = Boxes.studentsBox();
  List<Student> students = box.values.toList();
  students.forEach((element) {
    log("${element.id}");
  });
  //for testing
  var seBox = Boxes.sessionsBox();
  log(seBox.isOpen.toString());

 /* seBox.put(
      1,
      Session(15369,5)
        ..lastNewAssignment =
        [
          Assignment(
              Surah(Quran.quran[1]['id'],Quran.quran[1]['name'], Quran.quran[1]['total_verses']),
              1,
              Quran.quran[1]['total_verses']),



          Assignment(
              Surah(Quran.quran[15]['id'],Quran.quran[15]['name'], Quran.quran[15]['total_verses']),
              15,
              Quran.quran[15]['total_verses']),




          Assignment(
              Surah(Quran.quran[16]['id'],Quran.quran[16]['name'], Quran.quran[16]['total_verses']),
              16,
              Quran.quran[16]['total_verses'])
        ]
        ..lastRevisionAssignment =   [
          Assignment(
              Surah(Quran.quran[1]['id'],Quran.quran[1]['name'], Quran.quran[1]['total_verses']),
              1,
              Quran.quran[1]['total_verses']),



          Assignment(
              Surah(Quran.quran[15]['id'],Quran.quran[15]['name'], Quran.quran[15]['total_verses']),
              15,
              Quran.quran[15]['total_verses']),




          Assignment(
              Surah(Quran.quran[16]['id'],Quran.quran[16]['name'], Quran.quran[16]['total_verses']),
              16,
              Quran.quran[16]['total_verses'])
        ]
        ..todayNewAssignment =   [
          Assignment(
              Surah(Quran.quran[1]['id'],Quran.quran[1]['name'], Quran.quran[1]['total_verses']),
              1,
              Quran.quran[1]['total_verses']),



          Assignment(
              Surah(Quran.quran[15]['id'],Quran.quran[15]['name'], Quran.quran[15]['total_verses']),
              15,
              Quran.quran[15]['total_verses']),




          Assignment(
              Surah(Quran.quran[16]['id'],Quran.quran[16]['name'], Quran.quran[16]['total_verses']),
              16,
              Quran.quran[16]['total_verses'])
        ]
        ..todayRevisionAssignment =   [
          Assignment(
              Surah(Quran.quran[1]['id'],Quran.quran[1]['name'], Quran.quran[1]['total_verses']),
              1,
              Quran.quran[1]['total_verses']),



          Assignment(
              Surah(Quran.quran[15]['id'],Quran.quran[15]['name'], Quran.quran[15]['total_verses']),
              15,
              Quran.quran[15]['total_verses']),




          Assignment(
              Surah(Quran.quran[16]['id'],Quran.quran[16]['name'], Quran.quran[16]['total_verses']),
              16,
              Quran.quran[16]['total_verses'])
        ]);
*/
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (context, _) {
      return GetMaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('ar', 'EN'),
        ],
        locale: Locale('ar', 'EN'),
        theme: Themes.lightTheme,
        home: HomeView(),
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
              })),   GetPage(
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
