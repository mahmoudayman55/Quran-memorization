import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


SnackbarController customSnackBar(String title,String message,bool successful){
  return Get.snackbar(title, message,dismissDirection: DismissDirection.down,colorText: successful?Colors.lightGreen:Colors.red,snackPosition: SnackPosition.BOTTOM);
}