import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran_memorization/core/services/quran.dart';
import 'package:quran_memorization/model/surah_model.dart';

class QuraanDropDownButton extends StatelessWidget {
  final double width, height;
  final int value;
  final String hint;
  final Function onChanged;
  String? errorText;

  QuraanDropDownButton(
      this.width, this.height, this.value, this.hint, this.onChanged,
      {this.errorText});

  final List<DropdownMenuItem<int>> _items = List.generate(114, (index) {
    return DropdownMenuItem(
      child:
          Text(Quran.quran.map((e) => Surah.fromJson(e)).toList()[index].name),
      value: Quran.quran.map((e) => Surah.fromJson(e)).toList()[index].id,
    );
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(5),
          height: height,
          decoration: BoxDecoration(
              color: Colors.grey[100], borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: DropdownButton<int>(
              value: value,
              hint: Text(
                hint,
                style: TextStyle(fontSize: 20),
                overflow: TextOverflow.ellipsis,
              ),
              style: Theme.of(context).textTheme.headline4,
              items: _items,
              onChanged: (item) {
                onChanged(item);
              },
              underline: Container(),
              isExpanded: true,
              icon: Icon(Icons.keyboard_arrow_down),
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: EdgeInsets.only(left: 0, top: 0),
            child: Text(
              errorText!,
              style: TextStyle(fontSize: 12, color: Colors.red[800]),
            ),
          )
      ],
    );
  }
}
