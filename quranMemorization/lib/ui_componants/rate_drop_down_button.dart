import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RateDropDownButton extends StatelessWidget {
  final int value;
  final String hint;
  final String errorText;
  final List<DropdownMenuItem<int>> items=List.generate(10, (index) => DropdownMenuItem(child: Text('$index'),value: index,));
  final Function onChanged;


  RateDropDownButton(
      this.value, this.hint, this.errorText, this.onChanged);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              color: Colors.grey[100], borderRadius: BorderRadius.circular(30)),
          child: Padding(
            padding:
            const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 5),
            child: DropdownButton<int>(
              value: value,
              hint: Text(
                hint,
                style: TextStyle(fontSize: 20),
                overflow: TextOverflow.ellipsis,
              ),
              style: Theme.of(context).textTheme.headline4,
              items: items,
              onChanged: (item) {
                onChanged(item);
              },
              isExpanded: true,
              underline: Container(),
              icon: Icon(Icons.keyboard_arrow_down),
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: EdgeInsets.only(left: 30, top: 10),
            child: Text(errorText, style: TextStyle(fontSize: 12, color: Colors.red[800]),),
          )

      ],
    );
  }
}