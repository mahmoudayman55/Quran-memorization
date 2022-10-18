import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran_memorization/core/controller/students_controller.dart';
import 'package:quran_memorization/ui_componants/theme.dart';
import 'package:get/get.dart';

class CustomDataColumn extends DataColumn {
  late String title;
  late BuildContext context;

  CustomDataColumn(this.title, this.context)
      : super(
            label: Text(
          title,
          style: Theme.of(context).textTheme.headline5!.copyWith(
                color: Colors.lightGreen,
              ),
        ));
}
