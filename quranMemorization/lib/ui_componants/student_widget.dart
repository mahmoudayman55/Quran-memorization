import 'dart:developer' as dev;
import 'dart:io';
import 'dart:math';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran_memorization/core/controller/session_controller.dart';
import 'package:quran_memorization/core/controller/students_controller.dart';
import 'package:quran_memorization/core/enums/device_type.dart';
import 'package:quran_memorization/core/services/quran.dart';
import 'package:quran_memorization/model/assignment_model.dart';
import 'package:quran_memorization/model/student_model.dart';
import 'package:quran_memorization/model/surah_model.dart';
import 'package:quran_memorization/ui_componants/assignment_table_widget.dart';
import 'package:quran_memorization/ui_componants/confirm_button.dart';
import 'package:quran_memorization/ui_componants/quran_drop_down_button.dart';
import 'package:quran_memorization/ui_componants/rate_drop_down_button.dart';
import 'package:quran_memorization/ui_componants/theme.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/services/constants.dart';
import '../model/session_model.dart';
import 'custom_data_column.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentWidget extends StatelessWidget {
  double maxWidth, maxHeight;
  bool isMob;
  Student student;

  Function()? newSession = () => null;
  StudentsController _studentsController = Get.find<StudentsController>();
  TextEditingController nameController = TextEditingController(),
      ageController = TextEditingController(),
      phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  StudentWidget(
      this.maxWidth, this.maxHeight, this.isMob, this.student, this.newSession);

  @override
  Widget build(BuildContext context) {
    final studentSessions = student.sessions();

    return SizedBox(
      width: maxWidth * (isMob ? 0.46 : 0.3),
      height: maxHeight * 0.09,
      child: Card(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  student.name,
                  style: Theme.of(context).textTheme.headline1,
                ),
                if (newSession == null)
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            nameController.text = student.name;
                            ageController.text = student.age.toString();
                            phoneController.text = student.parentPhoneNumber;

                            
                            Get.bottomSheet(Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                  child: Form(
                                    key: formKey,
                                    child: SizedBox(
                                      height: maxHeight * 0.35,
                                      width: maxWidth,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                              flex: 1,
                                              child: Text(
                                                'تعديل البيانات',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1,
                                              )),
                                          Expanded(
                                            flex: 2,
                                            child: TextFormField(
                                         controller: nameController,
                                              validator: (value) {
                                                List<Student> allStudents =
                                                    _studentsController
                                                        .students;
                                                if (value!.isEmpty) {
                                                  return "يجب ادخال اسم الطالب";
                                                } else if (allStudents
                                                        .firstWhereOrNull(
                                                            (element) =>
                                                                element.name ==
                                                                value) !=
                                                    null) {
                                                  return "يوجد طالب يحمل نفس الاسم";
                                                }
                                              },
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4,
                                              decoration: InputDecoration(
                                                  hintText: "اسم الطالب",
                                                  label: Text(
                                                    'اسم الطلب',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline3,
                                                  )),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: TextFormField(
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4,
                                              keyboardType:
                                                  TextInputType.number,
                                            controller: ageController,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "يجب ادخال عمر الطالب";
                                                }
                                              },
                                              decoration: InputDecoration(
                                                  hintText: "العمر",
                                                  label: Text(
                                                    'العمر',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline3,
                                                  )),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: TextFormField(
                                              keyboardType: TextInputType.phone,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4,
                                           
                                           controller: phoneController,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'يجب ادخال رقم الهاتف';
                                                } else if (value.length != 11) {
                                                  return "رقم الهاتف غير صحيح";
                                                }
                                              },
                                              decoration: InputDecoration(
                                                  hintText:
                                                      "رقم هاتف ولي الامر",
                                                  label: Text(
                                                    'رقم الهاتف',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline3,
                                                  )),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: ConfirmButton("حفظ", () {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                    dev.log("name is ${nameController.text}");
                                                student.name = nameController.text;
                                                student.age = int.parse(ageController.text.toString());
                                                student.parentPhoneNumber =
                                                    phoneController.text;
                                                dev.log("valid");
                                                _studentsController
                                                    .updateStudent(student);
                                              }
                                            }, Themes.darkBlue, maxWidth,
                                                maxHeight * 0.03),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ));
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.lightGreen,
                            size: maxWidth * (isMob ? 0.05 : 0.03),
                          )),
                      IconButton(
                          onPressed: () => Get.defaultDialog(
                              content: Text(
                                "سيتم حذف جميع حصص الطالب في حالة حذفه",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(color: Colors.red),
                              ),
                              title: "سيتم حذف الطالب ${student.name}",
                              confirm: ConfirmButton("تأكيد", () {
                                _studentsController.removeStudent(student.id);
                                Get.back();
                              }, Colors.red, maxWidth * 0.3, maxHeight * 0.03),
                              cancel: ConfirmButton(
                                  "تراجع",
                                  () => Get.back(),
                                  Colors.blue,
                                  maxWidth * 0.3,
                                  maxHeight * 0.03),
                              titleStyle:
                                  Theme.of(context).textTheme.headline1),
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: maxWidth * (isMob ? 0.05 : 0.03),
                          )),
                    ],
                  ),
              ],
            ),
          ),
          Expanded(
            flex: isMob ? 6 : 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InfoCard(maxHeight, maxWidth, "الحضور",
                          "${studentSessions.length} حصة", Colors.cyan, isMob),
                      InfoCard(maxHeight, maxWidth, "العمر", "${student.age}",
                          Colors.indigo, isMob),
                      InfoCard(
                          maxHeight,
                          maxWidth,
                          "التقييم العام",
                          "${student.evaluation}",
                          Color.fromARGB(255, 233, 105, 30),
                          isMob),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          "التقدم آخر 7 حصص",
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.headline1!.copyWith(
                                    color: Colors.amber,
                                  ),
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: SfCartesianChart(
                          primaryXAxis: NumericAxis(
                              minimum: 1,
                              maximum: 7,
                              interval: 1,
                              edgeLabelPlacement: EdgeLabelPlacement.none),
                          primaryYAxis: NumericAxis(
                              maximum: 10,
                              interval: 1,
                              minimum: 1,
                              edgeLabelPlacement: EdgeLabelPlacement.none),
                          series: <ChartSeries>[
                            LineSeries(
                                markerSettings:
                                    const MarkerSettings(isVisible: true),
                                color: Colors.lightGreen,
                                dataSource: studentSessions.length < 7
                                    ? studentSessions
                                    : studentSessions
                                        .sublist(studentSessions.length - 7),
                                xValueMapper: (session, _) => studentSessions
                                            .length <
                                        7
                                    ? studentSessions.indexOf(session) + 1
                                    : studentSessions
                                            .sublist(studentSessions.length - 7)
                                            .indexOf(session) +
                                        1,
                                yValueMapper: (session, _) =>
                                    (session as Session).rate)
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          newSession == null
              ? Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ConfirmButton(
                          "اتصال",
                          () async {
                            final Uri launchUri = Uri(
                              scheme: 'tel',
                              path: student.parentPhoneNumber.toString(),
                            );
                            await launchUrl(launchUri);
                            dev.log("tele");
                          },
                          Colors.lightGreen,
                          maxWidth,
                          25,
                          rad: 0,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: ConfirmButton(
                          "الحصص",
                          () {
                            var _sessionsController =
                                Get.find<SessionController>();
                            _sessionsController.sessions = student.sessions();
                            _sessionsController.searchController.text =
                                student.name;
                            Get.toNamed("/sessions");
                          },
                          Colors.indigo,
                          maxWidth,
                          25,
                          rad: 0,
                        ),
                      ),
                    ],
                  ),
                )
              : Expanded(
                  flex: 1,
                  child: ConfirmButton(
                    "حصة جديدة",
                    newSession!,
                    Colors.purple,
                    maxWidth,
                    25,
                    rad: 0,
                  ),
                ),
        ],
      )),
    );
  }
}

class InfoCard extends StatelessWidget {
  double maxHeight, maxWidth;
  String title, value;
  bool isMob;
  Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: maxHeight * 0.06,
      width: maxWidth * (isMob ? 0.20 : 0.10),
      child: Container(
        decoration: BoxDecoration(
            color: color.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10)),
        alignment: Alignment.center,
        child: Text(
          "${title}\n${value}",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline2!.copyWith(color: color),
        ),
      ),
    );
  }

  InfoCard(this.maxHeight, this.maxWidth, this.title, this.value, this.color,
      this.isMob);
}
