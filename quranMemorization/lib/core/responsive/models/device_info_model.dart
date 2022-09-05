import 'package:flutter/cupertino.dart';

import '../../enums/device_type.dart';

class DeviceInfo {
  final Orientation orientation;
  final DeviceType deviceType;
  final double screenWidth;
  final double screenHeight;
  final double height;
  final double width;

  DeviceInfo(
      {
   required  this.orientation,
   required  this.deviceType,
   required  this.screenWidth,
   required  this.screenHeight,
   required  this.height,
   required  this.width
      });
}