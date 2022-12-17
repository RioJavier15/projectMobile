import 'package:projectmobile/screen/Profile/profile_screen.dart';
import 'package:projectmobile/screen/Riwayat/riwayat.dart';
import 'package:projectmobile/screen/home/home.dart';
import 'package:projectmobile/theme/theme.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  final String uname;
  final String uname1;
  final String status;
  final String kecepatan;
  final String kode_pelanggan;
  final String email_pelanggan;
  final String nomer_hp;
  final String password;
  BottomNav({
    Key? key,
    required this.uname,
    required this.uname1,
    required this.status,
    required this.kecepatan,
    required this.kode_pelanggan,
    required this.email_pelanggan,
    required this.nomer_hp,
    required this.password,
  }) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState(uname, uname1, status,
      kecepatan, kode_pelanggan, email_pelanggan, nomer_hp, password);
}

class _BottomNavState extends State<BottomNav> {
  String uname;
  String uname1;
  String status;
  String kecepatan;
  String kode_pelanggan;
  String email_pelanggan;
  String nomer_hp;
  String password;
  _BottomNavState(this.uname, this.uname1, this.status, this.kecepatan,
      this.kode_pelanggan, this.email_pelanggan, this.nomer_hp, this.password);
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final _screen = [
      HomePage(uname1, uname, status, kecepatan),
      Riwayat(kode_pelanggan),
      ProfileScreen(uname, uname1, status, kecepatan,
          kode_pelanggan, email_pelanggan, nomer_hp, password),
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
