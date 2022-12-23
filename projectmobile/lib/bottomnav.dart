import 'package:projectmobile/screen/Profile/profile_screen.dart';
import 'package:projectmobile/screen/Riwayat/riwayat.dart';
import 'package:projectmobile/screen/home/home.dart';
import 'package:projectmobile/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);
  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  String uname = "";
  String uname1 = "";
  String status = "";
  String kecepatan = "";
  String kode_pelanggan = "";
  String email_pelanggan = "";
  String nomer_hp = "";
  String password = "";

  int _selectedIndex = 0;

  Future getkode() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      kode_pelanggan = (prefs.getString('kode_pelanggan') ?? "");
      uname = (prefs.getString('nama_produk') ?? "");
      uname1 = (prefs.getString('nama_pelanggan') ?? "");
      status = (prefs.getString('status') ?? "");
      kecepatan = (prefs.getString('kecepatan') ?? "");
      email_pelanggan = (prefs.getString('email_pelanggan') ?? "");
      nomer_hp = (prefs.getString('nomer_hp') ?? "");
      password = (prefs.getString('password') ?? "");
    });
  }

  @override
  void initState() {
    super.initState();
    getkode();
  }

  @override
  Widget build(BuildContext context) {
    final _screen = [
      const HomeScreen(),
      const Riwayat(),
      const ProfileScreen(),
    ];
    Widget customWidget() {
      return BottomNavigationBar(
        elevation: 1,
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: NavTextStyle,
        unselectedLabelStyle: NavTextStyle,
        selectedItemColor: blackColor,
        items: [
          BottomNavigationBarItem(
              icon: Container(
                  margin: EdgeInsets.symmetric(vertical: 2),
                  child: Icon(Icons.home,
                      size: 28,
                      color: _selectedIndex == 0 ? blackColor : grey2Color)),
              label: 'Beranda',
              tooltip: ''),
          BottomNavigationBarItem(
              icon: Container(
                  margin: EdgeInsets.symmetric(vertical: 2),
                  child: Icon(Icons.receipt,
                      size: 25,
                      color: _selectedIndex == 1 ? blackColor : grey2Color)),
              label: 'Riwayat',
              tooltip: ''),
          BottomNavigationBarItem(
              icon: Container(
                  margin: EdgeInsets.symmetric(vertical: 2),
                  child: Icon(Icons.person,
                      size: 28,
                      color: _selectedIndex == 2 ? blackColor : grey2Color)),
              label: 'Akun Saya',
              tooltip: ''),
        ],
      );
    }

    return Scaffold(
      bottomNavigationBar: customWidget(),
      body: Stack(
        children: _screen
            .asMap()
            .map((i, screen) => MapEntry(
                i,
                Offstage(
                  offstage: _selectedIndex != i,
                  child: screen,
                )))
            .values
            .toList(),
      ),
    );
  }
}
