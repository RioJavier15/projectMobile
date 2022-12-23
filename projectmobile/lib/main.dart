import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projectmobile/login/login.dart';
import 'package:projectmobile/bottomnav.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:projectmobile/notificationservice.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

  void notif() async {
    final prefs = await SharedPreferences.getInstance();
    String status = (prefs.getString('status') ?? "");
    final date = DateTime.now();
    final tanggal = DateTime(date.year, date.month + 1, 1);
    final Duration durasi = tanggal.difference(date);
    DateTime hari = DateTime.now();
    // var status = "aktif";
    if (durasi.inDays == 7 && status == "aktif") {
      NotificationService().showNotification(
          1, "Masa aktif", "Masa aktif paket internet 7 hari lagi");
    } else if (durasi.inDays == 3 && status == "aktif") {
      NotificationService().showNotification(
          2, "Masa aktif", "Masa aktif paket internet 3 hari lagi");
    } else if (durasi.inDays == 1 && status == "aktif") {
      NotificationService().showNotification(
          3, "Masa aktif", "Masa aktif paket internet berakhir hari ini");
    } else if (status == "none") {
      NotificationService().showNotification(4, "Belum berlangganan",
          "Anda belum berlangganan paket intenet. Hubungi admin untuk berlangganan");
    } else if (status == "non aktif") {
      NotificationService().showNotification(4, "Paket Non Aktif",
          "Hubungi admin untuk mengaktifkan paket internet anda");
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    notif();
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
