import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran_memorization/ui_componants/device_info_widget.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, deviceInfo) {
      return Scaffold(body: Center(),);
    });
  }

}