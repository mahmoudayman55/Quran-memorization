import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quran_memorization/model/session_model.dart';
import 'package:quran_memorization/model/student_model.dart';
import 'package:quran_memorization/theme.dart';
import 'package:quran_memorization/view/home_view.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(StudentAdapter());
  Hive.registerAdapter(SessionAdapter());
  await Hive.openBox<Student>('students');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      builder: (context,_) {
        return GetMaterialApp(
          theme: Themes.lightTheme,
          home: HomeView(),initialBinding: BindingsBuilder(() {
        //  Get.lazyPut(()=> HomeController());


        }) ,

        );
      }
    );
  }
}


