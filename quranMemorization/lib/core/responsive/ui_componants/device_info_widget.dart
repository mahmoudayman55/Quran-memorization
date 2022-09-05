
import 'package:flutter/cupertino.dart';

import '../../../model/device_info_model.dart';
import '../../enums/device_type.dart';
import '../../functions/get_device_type.dart';

class InfoWidget extends StatelessWidget {
  final Widget Function(BuildContext context, DeviceInfo deviceInfo) builder;

   InfoWidget({ required this.builder}) ;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        var mediaQueryData = MediaQuery.of(context);
        var deviceInfo = DeviceInfo(
          orientation: mediaQueryData.orientation,
          screenWidth: mediaQueryData.size.width,
          screenHeight: mediaQueryData.size.height,
          height: constrains.maxHeight,
          width: constrains.maxWidth,
          deviceType: getDeviceType(mediaQueryData,constrains.maxWidth),

        );
        print("from device info builder\nwidth=${deviceInfo.width} \n device type is${deviceInfo.deviceType}");
        return builder(context, deviceInfo);
      },
    );
  }
}