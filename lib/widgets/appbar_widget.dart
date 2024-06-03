import 'package:assignment_zarity_health/utils/constants.dart';
import 'package:assignment_zarity_health/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class AppBarWidgets {
  static AppBar appBarWidget(String title) {
    return AppBar(
        title: TextWidget(
          text: title, 
          fontFamily: ConstantUtils.appFontFamily, 
          size: ConstantUtils.appFontSize,
        ),
        centerTitle: true,
      );
  }
}