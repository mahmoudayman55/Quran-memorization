import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran_memorization/ui_componants/confirm_button.dart';
import 'package:quran_memorization/ui_componants/device_info_widget.dart';
import 'package:quran_memorization/ui_componants/to_section_widget.dart';
import 'package:get/get.dart';

import '../core/controller/students_controller.dart';
import 'home_view.dart';

class StudentView extends StatelessWidget {
  var studentController = Get.find<StudentsController>();

  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, deviceInfo) {
      double maxWidth = deviceInfo.width;
      double maxHeight = deviceInfo.height;
      double screenWidth = deviceInfo.screenWidth;
      double screenHeight = deviceInfo.screenHeight;

      return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
            onPressed: () => Get.defaultDialog(
                title: "طالب جديد",
                titleStyle: Theme.of(context).textTheme.headline2,
                contentPadding: EdgeInsets.all(20),
                content: SingleChildScrollView(
                  child: Form(
                    key: studentController.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(flex: 1,
                          child: TextFormField(
                            onChanged: (value) {
                              studentController.name = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "يجب ادخال اسم الطالب";
                              }
                            },
                            style: Theme.of(context).textTheme.headline4,
                            decoration: InputDecoration(

                                hintText: "اسم الطالب",
                                label: Text(
                                  'اسم الطلب',
                                  style: Theme.of(context).textTheme.headline3,
                                )),
                          ),
                        ),
                        Expanded(flex: 1,
                          child: TextFormField(
                            style: Theme.of(context).textTheme.headline4,

                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              studentController.age =int.parse(value);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "يجب ادخال عمر الطالب";
                              }
                            },
                            decoration: InputDecoration(
                                hintText: "العمر",
                                label: Text(
                                  'العمر',
                                  style: Theme.of(context).textTheme.headline3,
                                )),
                          ),
                        ),
                        Expanded(flex: 1,
                          child: TextFormField(                          keyboardType: TextInputType.phone,
                            style: Theme.of(context).textTheme.headline4,

                            onChanged: (value) {
                              studentController
                                .phone= value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'يجب ادخال رقم الهاتف';
                              } else if (value.length != 11) {
                                return "رقم الهاتف غير صحيح";
                              }
                            },
                            decoration: InputDecoration(
                                hintText: "رقم الهاتف",
                                label: Text(
                                  'رقم الهاتف',
                                  style: Theme.of(context).textTheme.headline3,
                                )),
                          ),
                        ),
                        Expanded(flex: 1,
                          child: ConfirmButton(
                              "اضافة",
                               studentController.addNewStudent,
                              Color.fromARGB(255, 194, 227, 251),
                              maxWidth * 0.3,
                              maxHeight * 0.05),
                        )
                      ],
                    ),
                  ),
                ))),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [],
            ),
          ),
        ),
      );
    });
  }
}
