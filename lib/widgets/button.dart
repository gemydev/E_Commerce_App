import 'package:E_commerce/constants/gradient.dart';
import 'package:E_commerce/services/infoForResponsiveUi/device_info.dart';
import 'package:E_commerce/services/infoForResponsiveUi/info_widget.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String buttonName;
  final Function onTapFun;
  final double fontSize;
  final double height ;
  final double width ;


  CustomButton(
      {@required this.buttonName,
      @required this.onTapFun,
      this.fontSize,
      this.height,
      this.width});

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTapFun,
      child: Card(
        elevation: 10,
        child: InfoWidget(
          returnedWidget: (context , deviceInfo){
            bool portrait = deviceInfo.orientation == Orientation.portrait;
            return Container(
              width: widthFun(portrait, deviceInfo),
              height: heightFun(portrait, deviceInfo),
              decoration: BoxDecoration(
                  gradient: gradientFunButtons(),
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Text(
                  widget.buttonName,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: widget.fontSize),
                ),
              ),
            );
          },
        )
      ),
    );
  }

  double widthFun (bool portrait , DeviceInfo deviceInfo){
    if(widget.width == null){
      if(portrait){
        return deviceInfo.screenWidth*0.52;
      }else{
        return deviceInfo.screenWidth*0.5;
      }
    }else{
      return widget.width;
    }
  }

  double heightFun (bool portrait , DeviceInfo deviceInfo){
    if(widget.height == null){
      if(portrait){
        return deviceInfo.screenHeight*0.07;
      }else{
        return deviceInfo.screenHeight*0.12;
      }
    }else{
      return widget.height;
    }
  }
}
