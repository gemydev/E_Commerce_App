
import 'package:E_commerce/constants/colors.dart';
import 'package:E_commerce/functions/navigation_funs.dart';
import 'package:E_commerce/services/infoForResponsiveUi/info_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

Widget dashedButton(context , destinationPage , title  ){
  return InfoWidget(
    returnedWidget: (context , deviceInfo){
      bool portrait = deviceInfo.orientation == Orientation.portrait;
      return DottedBorder(
        borderType: BorderType.RRect,
        dashPattern: [8, 4],
        strokeCap: StrokeCap.butt,
        color: GRADIENT_BEGIN,
        strokeWidth:2,
        child: GestureDetector(
          onTap: () {
            normalShift(context, destinationPage);
          },
          child: Container(
            height: portrait ? deviceInfo.screenHeight *0.065 : deviceInfo.screenHeight*0.1,
            width: portrait ?  deviceInfo.screenWidth*0.85 : deviceInfo.screenWidth*0.66,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.add,
                    color: GRADIENT_BEGIN,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.1,
                  ),
                  Text(
                    title,
                    style: TextStyle(fontSize: 20, color: GRADIENT_BEGIN),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}