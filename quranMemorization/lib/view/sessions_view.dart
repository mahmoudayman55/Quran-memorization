import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_memorization/core/controller/session_controller.dart';
import 'package:quran_memorization/core/controller/students_controller.dart';
import 'package:quran_memorization/core/enums/device_type.dart';
import 'package:quran_memorization/model/student_model.dart';
import 'package:quran_memorization/ui_componants/confirm_button.dart';
import 'package:quran_memorization/ui_componants/session_widget.dart';
import 'package:quran_memorization/ui_componants/device_info_widget.dart';
import 'package:quran_memorization/ui_componants/search_bar.dart';
import 'package:get/get.dart';

class SessionsView extends StatelessWidget {
  final SessionController _sessionController = Get.find<SessionController>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitUp,
    ]);
    return InfoWidget(builder: (context, deviceInfo) {
      double maxWidth = deviceInfo.width;
      double maxHeight = deviceInfo.height;
      bool isMob = deviceInfo.deviceType == DeviceType.mobile;
      return Scaffold(
        appBar: AppBar(
          title: SearchBar(
              maxHeight * 0.06,
              maxWidth * 0.9,
              15,
              15,
              _sessionController.searchSessions,
              Colors.lightGreen,
              _sessionController.searchController),
          centerTitle: true,
          leadingWidth: 0,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GetBuilder<SessionController>(builder: (controller) {
                return Expanded(
                    flex: 15,
                    child: _sessionController.sessions.isEmpty
                        ? Center(
                            child: Text(
                              "لا يوجد حصص",
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          )
                        : ListView.separated(
                            padding: EdgeInsets.only(
                                top: maxHeight * 0.07,
                                bottom: maxHeight * 0.02),
                            itemBuilder: (context, index) => SessionWidget(
                                maxHeight,
                                maxWidth,
                                _sessionController.sessions[index]),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: maxHeight * 0.03,
                                ),
                            itemCount: _sessionController.sessions.length));
              }),
              Expanded(
                  flex: 1,
                  child: ConfirmButton(
                      'حصة جديدة',
                      () => _sessionController.startSession(
                          context, maxWidth, maxHeight, isMob),
                      Colors.lightGreen,
                      maxWidth,
                      maxHeight * 0.02))
            ],
          ),
        ),
      );
    });
  }
}
