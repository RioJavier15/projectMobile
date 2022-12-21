import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projectmobile/login/login.dart';
import 'package:projectmobile/bottomnav.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project Mobile',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
                //<-- SEE HERE
                // Status bar color
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.dark),
          )),
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? BottomNav() : const LoginScreen(),
    );
  }
}
