import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NumericDropDownButton extends StatelessWidget {
  final int value;
  final int range;
  final String hint;
  final double width,height;
  String? errorText;
  late final List<DropdownMenuItem<int>> _items;
  final Function onChanged;


  NumericDropDownButton(this.width,this.height,
      this.value, this.hint, this.errorText, this.onChanged,this.range){
    _items=List.generate(range, (index) => DropdownMenuItem(child: Text('${index+1}'),value: index+1,));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(width:width ,height: height,
          decoration: BoxDecoration(
              color: Colors.grey[100], borderRadius: BorderRadius.circular(30)),
          child: Padding(
            padding:
            const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 5),
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
              },underline: Container(),
              isExpanded: true,
              icon: Icon(Icons.keyboard_arrow_down),
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: EdgeInsets.only(left: 30, top: 0),
            child: Text(errorText!, style: TextStyle(fontSize: 12, color: Colors.red[800]),),
          )

      ],
    );
  }
}