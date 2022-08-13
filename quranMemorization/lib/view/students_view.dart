import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran_memorization/ui_componants/confirm_button.dart';
import 'package:quran_memorization/ui_componants/custom_data_column.dart';
import 'package:quran_memorization/ui_componants/device_info_widget.dart';
import 'package:quran_memorization/ui_componants/to_section_widget.dart';
import 'package:get/get.dart';

import '../core/controller/students_controller.dart';
import '../ui_componants/theme.dart';
import 'home_view.dart';

class StudentView extends StatelessWidget {
  final StudentsController _studentController = Get.find<StudentsController>();

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
            backgroundColor: Themes.darkBlue,
            child: Icon(Icons.add),
            onPressed: () => Get.defaultDialog(
                title: "طالب جديد",
                titleStyle: Theme.of(context).textTheme.headline2,
                contentPadding: EdgeInsets.all(20),
                content: SingleChildScrollView(
                  child: Form(
                    key: _studentController.formKey,
                    child: SizedBox(
                      height: maxHeight * 0.35,
                      width: maxWidth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              onChanged: (value) {
                                _studentController.name = value;
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
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  )),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              style: Theme.of(context).textTheme.headline4,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                _studentController.age = int.parse(value);
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
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  )),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              style: Theme.of(context).textTheme.headline4,
                              onChanged: (value) {
                                _studentController.phone = value;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'يجب ادخال رقم الهاتف';
                                } else if (value.length != 11) {
                                  return "رقم الهاتف غير صحيح";
                                }
                              },
                              decoration: InputDecoration(
                                  hintText: "رقم هاتف ولي الامر",
                                  label: Text(
                                    'رقم الهاتف',
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  )),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: ConfirmButton(
                                "اضافة",
                                _studentController.addNewStudent,
                                Themes.softBlue,
                                maxWidth * 0.3,
                                maxHeight * 0.03),
                          )
                        ],
                      ),
                    ),
                  ),
                ))),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: GetBuilder<StudentsController>(
              builder: (controller) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                      dividerThickness: 1,
                      dataRowHeight: maxHeight * 0.04,
                      headingRowHeight: maxHeight * 0.04,
                      columnSpacing: maxWidth * 0.042,
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => Themes.darkBlue),

                      columns: [
                        CustomDataColumn('الاسم', context),
                        CustomDataColumn('الهاتف', context),
                        CustomDataColumn('التقييم', context),
                        CustomDataColumn('ارشيف', context),

                      ],
                      rows: List<DataRow>.generate(
                          _studentController.students.length,
                          (index) => DataRow(
                                  color: MaterialStateProperty.resolveWith<Color>(
                                      (states) {
                                    return index % 2 == 0
                                        ? Colors.grey.shade50
                                        : Colors.grey.shade300;
                                  }),
                                  cells: [
                                    DataCell(Text(
                                      _studentController.students[index].name,style: Theme.of(context).textTheme.headline4,
                                    )),
                                    DataCell(Text(
                                      _studentController.students[index].parentPhoneNumber,style: Theme.of(context).textTheme.headline4,
                                    )),
                                    DataCell(Text(
                                      _studentController.students[index].evaluation,style: Theme.of(context).textTheme.headline4,
                                    )),
                                    DataCell(
IconButton(onPressed: (){},icon: Icon(Icons.archive,color:Colors.lightGreen,),)                                ),
                                  ]))),
                );
              }
            ),
          ),
        ),
      );
    });
  }
}
