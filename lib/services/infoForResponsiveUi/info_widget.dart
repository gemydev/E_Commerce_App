import 'package:E_commerce/services/infoForResponsiveUi/device_info.dart';
import 'package:E_commerce/services/infoForResponsiveUi/get_device_type.dart';
import 'package:flutter/material.dart';


class InfoWidget extends StatelessWidget {
  final Widget Function(BuildContext context, DeviceInfo deviceInfo)
      returnedWidget;
  InfoWidget({this.returnedWidget});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var mediaQueryData = MediaQuery.of(context);
        var deviceInfo = DeviceInfo(
          orientation: mediaQueryData.orientation,
          deviceType: getDeviceType(mediaQueryData),
          screenWidth: mediaQueryData.size.width,
          screenHeight: mediaQueryData.size.height,
          localHeight: constraints.maxHeight,
          localWidth: constraints.maxWidth,
        );
        return returnedWidget(context, deviceInfo);
      },
    );
  }
}
