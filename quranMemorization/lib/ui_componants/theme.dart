import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class Themes {
  static final lightTheme=
  ThemeData.light().copyWith(textTheme: TextTheme().copyWith(
    headline3: TextStyle(fontFamily: "tajawal",
      color:  Color.fromARGB(255, 47,124,183),
      fontSize: 15.sp,
    ),
    headline2: TextStyle(fontFamily: "tajawal",
      color:  Color.fromARGB(255, 47,124,183),
      fontSize: 18.sp,fontWeight: FontWeight.bold
    ),
    headline4: TextStyle(fontFamily: "tajawal",
      color:  Colors.black,
      fontSize: 12.sp,
    ),
  ),
    scaffoldBackgroundColor: Color.fromARGB(255, 47,124,183)

  );



}