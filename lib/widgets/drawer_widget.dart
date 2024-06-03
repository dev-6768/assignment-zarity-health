import 'package:assignment_zarity_health/main.dart';
import 'package:assignment_zarity_health/utils/constants.dart';
import 'package:assignment_zarity_health/widgets/listtile_widget.dart';
import 'package:assignment_zarity_health/widgets/user_account_widget.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  final Brightness brightness;
  const DrawerWidget({super.key, required this.brightness});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  late String darkModeStatus;
  Color backgroundColor = Colors.green;

  @override
  void initState() {
    super.initState();
    if(widget.brightness == Brightness.dark) {
      darkModeStatus = "Disable dark mode";
    }

    else {
      darkModeStatus = "Enable dark mode";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            UserAccountWidgets.primaryUserDrawerWidget(Theme.of(context).brightness, context),
             //DrawerHeader
            ListTileWidget.drawerListTile(
              IconsUtils.darkModeIcon,
              darkModeStatus,
              () { 
                if(darkModeStatus == "Enable dark mode") {
                  changeDarkStatus("Disable dark mode");
                  MyApp.of(context).changeTheme(ThemeMode.dark);
                }

                else {
                  changeDarkStatus("Enable dark mode");
                  MyApp.of(context).changeTheme(ThemeMode.light);
                }
                
              }
            ),
          ],
        ),
      );
  }

  void changeDarkStatus(String darkStatus) {
    setState(() {
      darkModeStatus = darkStatus;
      if(Theme.of(context).brightness == Brightness.dark) {
        backgroundColor = Colors.green;
      }

      else {
        backgroundColor = ThemeUtils.darkThemeColor;
      }
    });
  }
}

