import 'package:assignment_zarity_health/generics/list_item_class.dart';
import 'package:assignment_zarity_health/utils/constants.dart';
import 'package:assignment_zarity_health/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class AlertDialogWidget {
  static Widget primaryAlertDialog(BuildContext context, int index) {
    return AlertDialog(
      title: TextWidget(text: "Success!!", fontFamily: ConstantUtils.appFontFamily, size: 25),
      content: TextWidget(text: "Blog Saved Successfully!!", fontFamily: ConstantUtils.appFontFamily, size: 15),
      actions: [
        SharePallete.returnBlogSharePallete(context, index),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Dismiss the dialog
          },
          child: const Text('OK'),
        ),
      ],
    );
  }

  static showAlertDialog(Widget alertDialog, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }
}