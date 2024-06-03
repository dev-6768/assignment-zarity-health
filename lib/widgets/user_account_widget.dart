import 'package:assignment_zarity_health/utils/constants.dart';
import 'package:flutter/material.dart';

class UserAccountWidgets {
  static Widget primaryUserAccountWidget(String name, String email, String accountString, Brightness brightness ) {
    Color backgroundColor = Colors.green;
    if(brightness == Brightness.dark) {
      backgroundColor = ThemeUtils.darkThemeColor;
    }
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      child: UserAccountsDrawerHeader(
        decoration: BoxDecoration(color: backgroundColor),
          accountName: Text(
            name,
            style: const TextStyle(fontSize: 18),
          ),
          accountEmail: Text(email),
          currentAccountPictureSize: const Size.square(50),
          currentAccountPicture: Column(      
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: const Color.fromARGB(255, 33, 132, 3),
                child: Text(
                  accountString,
                  style: const TextStyle(fontSize: 25.0, color: Colors.white),
                ), //Text
              ),
              const SizedBox(height: 10),
            ]
          ) //circleAvatar
        ),
    );
  }

  static Widget primaryUserDrawerWidget(Brightness brightness, BuildContext context) {
    Color backgroundColor = ThemeUtils.appThemeColor;
    if(brightness == Brightness.dark) {
      backgroundColor = ThemeUtils.darkThemeColor;
    }
    return DrawerHeader(
      decoration: BoxDecoration(
        color: backgroundColor,
      ) ,//BoxDecoration
      child: UserAccountWidgets.primaryUserAccountWidget(
        "Sanidhya Mishra", 
        "sanidhyamishra1511@gmail.com", 
        "S",
        Theme.of(context).brightness,
      ),
    );
  }
}