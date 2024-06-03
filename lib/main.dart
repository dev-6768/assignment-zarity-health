import 'package:assignment_zarity_health/firebase_options.dart';
import 'package:assignment_zarity_health/pages/add_blog_page.dart';
import 'package:assignment_zarity_health/pages/splash_screen.dart';
import 'package:assignment_zarity_health/utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) => 
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ConstantUtils.appTitleString,
      debugShowCheckedModeBanner: false,
      theme: ThemeUtils.primaryTheme,
      themeMode: _themeMode,
      darkTheme: ThemeData.dark(),
      routes: {
        "/addblog":(context) => const AddBlogScreen(),
      },
      home: SplashScreen.returnPrimarySplashScreen(context),
    );
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }
}