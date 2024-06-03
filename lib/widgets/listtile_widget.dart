import 'package:assignment_zarity_health/utils/constants.dart';
import 'package:assignment_zarity_health/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ListTileWidget {
  static Widget drawerListTile(IconData listIcon, String title, void Function()? onTap) {
    return ListTile(
      leading: Icon(listIcon),
      title: TextWidget(text: title, fontFamily: ConstantUtils.appFontFamily, size: ConstantUtils.appFontSize),
      onTap: onTap,
    );
  }
}