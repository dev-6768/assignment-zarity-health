import 'package:assignment_zarity_health/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConstantUtils {
  static const appTitleString = "Zarity Health";
  static final appFontFamily = GoogleFonts.lato().fontFamily!;
  static const appFontSize = 15.0;
  static const noImage = "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/2048px-No_image_available.svg.png";
  static const linearGradientTheme = [
    Colors.white,
    Color.fromRGBO(253, 247, 247, 1),
    Color.fromRGBO(250, 242, 242, 1),
    Color.fromRGBO(246, 231, 231, 1),
    Color.fromRGBO(245, 221, 221, 1),
  ];  

  static const baseUrl = "https://dev-6768.github.io/";
  static const blogsUrl = '${baseUrl}blogs/';
  static const whatsappUrl = "https://wa.me/?text=";


}

class IconsUtils {
  static const logoutIcon = Icons.logout;
  static const editIcon = Icons.edit;
  static const profileIcon = Icons.person;
  static const darkModeIcon = Icons.sunny;
  static const errorIcon = Icon(Icons.error);
}

class ThemeUtils {
  static const appThemeColor = Colors.green;
  static const foregroundThemeColor = Colors.white;
  static const darkThemeColor = Color.fromARGB(255, 36, 35, 35);
  static ThemeData primaryTheme = ThemeData
    (
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white //here you can give the text color
      ),
      
    );
}

class ConstantRoutes {
  static const addBlogRoute = "/addblog";
}

class SnackBarUtils {
  static dynamic returnSnackBar(BuildContext context, String text) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: TextWidget(text: text, fontFamily: ConstantUtils.appFontFamily, size: ConstantUtils.appFontSize)),
    );
  }
}