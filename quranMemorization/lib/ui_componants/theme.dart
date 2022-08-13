import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class Themes {
  static final  Color darkBlue=Color.fromARGB(255, 47,124,183);
  static final  Color softBlue= Color.fromARGB(255, 194, 227, 251);

      static final lightTheme=
  ThemeData.light().copyWith(
    dividerColor: Colors.grey.shade300,
    primaryColor: darkBlue,
    textTheme: TextTheme().copyWith(

    headline3: TextStyle(fontFamily: "tajawal",
      color:  darkBlue,
      fontSize: 15.sp,
    ),
    headline2: TextStyle(fontFamily: "tajawal",
      color:darkBlue,
      fontSize: 18.sp,fontWeight: FontWeight.bold
    ),
    headline4: TextStyle(fontFamily: "tajawal",
      color:  Colors.black,
      fontWeight: FontWeight.w500,
      fontSize: 15.sp,
    ),
    headline1: TextStyle(fontFamily: "tajawal",
      color:  darkBlue,fontWeight: FontWeight.bold,
      fontSize: 22.sp,
    ),
    headline5: TextStyle(fontFamily: "tajawal",
      color:  Colors.white,
      fontWeight: FontWeight.bold,

      fontSize: 15.sp,
    ),
  ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: darkBlue,),
    // scaffoldBackgroundColor: Color.fromARGB(255, 226, 157, 83)

  );



}