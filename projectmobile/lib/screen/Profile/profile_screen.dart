import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectmobile/notifikasi/Logout.dart';
import 'package:projectmobile/screen/Profile/components/EditProfile.dart';
import 'package:projectmobile/screen/Profile/components/editpass.dart';
import 'package:projectmobile/screen/Profile/components/faq.dart';
import 'package:projectmobile/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreen createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  String uname1 = "";
  Future getnama() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      uname1 = (prefs.getString('nama_pelanggan') ?? "");
    });
  }

  @override
  void initState() {
    super.initState();
    getnama();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(53),
                child: AppBar(
                  centerTitle: true,
                  title: Text('Pengaturan Akun', style: AppbarStyle),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                )),
            body: ListView(children: [
              Column(
                children: [
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 5),
                      child: Column(
                        children: [
                          CircleAvatar(
                            child: Text(
                              uname1[0],
                              style: GoogleFonts.montserrat(
                                  fontSize: 30, fontWeight: FontWeight.w600),
                            ),
                            radius: 40,
                            backgroundColor: ButtonBackground,
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 24)),
                          Text(
                            uname1,
                            style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: blackColor),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      )),
                  const Padding(padding: EdgeInsets.all(5)),
                  ProfileMenu(
                    text: 'Edit Profile',
                    icon: Icons.person,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditProfile()),
                      );
                    },
                  ),
                  ProfileMenu(
                    text: 'Ganti Password',
                    icon: Icons.key_outlined,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditPassword()),
                      );
                    },
                  ),
                  ProfileMenu(
                    text: 'Informasi dan Bantuan',
                    icon: Icons.info_outline,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Faq()),
                      );
                    },
                  ),
                  ProfileMenu(
                    text: 'Logout',
                    icon: Icons.exit_to_app,
                    press: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return LogoutDialog();
                          });
                    },
                  )
                ],
              )
            ])));
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu(
      {Key? key, required this.text, required this.icon, this.press})
      : super(key: key);
  final String text;
  final IconData icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 27, vertical: 7),
      child: TextButton(
        style: TextButton.styleFrom(
            foregroundColor: TextButtonColor,
            padding: EdgeInsets.all(15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: TextButtonColor),
        onPressed: press,
        child: Row(
          children: [
            Icon(
              icon,
              color: blackColor,
            ),
            SizedBox(width: 20),
            Expanded(child: Text(text, style: TextProfileStyle)),
            Icon(
              Icons.arrow_forward_ios,
              color: blackColor,
            ),
          ],
        ),
      ),
    );
  }
}
