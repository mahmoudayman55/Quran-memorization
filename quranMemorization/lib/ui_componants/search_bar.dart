import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SearchBar extends StatelessWidget {
  double? height, width, secondColorRadius, mainRadius;
  Color color;
  Function(String keyWord) onTapSearch;
  String _keyWord = "";
  TextEditingController searchController;
  SearchBar(this.height, this.width, this.secondColorRadius, this.mainRadius,
      this.onTapSearch, this.color, this.searchController,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          width: width,
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                  height: height,
                  width: width! * 0.15,
                  child: Icon(
                    Icons.search,
                    color: Colors.black54,
                    size: ScreenUtil().setWidth(18),
                  )),
              SizedBox(
                width: width! * 0.8,
                child: TextFormField(
                  controller: searchController,
                  onChanged: (value) => onTapSearch(value),
                  style: Theme.of(context).textTheme.headline2,
                  decoration: InputDecoration.collapsed(
                      hintText: "بحث...",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(color: Colors.grey)),
                ),
              ),
            ],
          ),
          height: height,
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(mainRadius!)),
        ),
      ],
    );
  }
}
