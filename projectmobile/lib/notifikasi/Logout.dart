import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectmobile/theme/theme.dart';
import '../login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Container(
          height: 120,
          width: 100,
          alignment: Alignment.center,
          child: Padding(
              padding: EdgeInsets.all(15),
              child: ListView(children: [
                Column(
                  children: [
                    Text('Apakah anda yakin ingin keluar akun?',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: blackColor)),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setBool('isLoggedIn', false);
                                await prefs.setString(
                                  'kode_pelanggan',
                                  "",
                                );
                                await prefs.setString(
                                  'nama_produk',
                                  "",
                                );
                                await prefs.setString(
                                  'nama_pelanggan',
                                  "",
                                );
                                await prefs.setString(
                                  'status',
                                  "",
                                );
                                await prefs.setString(
                                  'kecepatan',
                                  "",
                                );
                                await prefs.setString(
                                  'email_pelanggan',
                                  "",
                                );
                                await prefs.setString(
                                  'nomer_hp',
                                  "",
                                );
                                await prefs.setString(
                                  'password',
                                  "",
                                );
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()));
                              },
                              child: Text('Ya'),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: ButtonBackground,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  textStyle: ButtonTextStyle),
                            ),
                            Spacer(
                              flex: 5,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context, 'Cancel');
                              },
                              child: Text('Cancel'),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: ButtonBackground,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  textStyle: ButtonTextStyle),
                            )
                          ],
                        )),
                  ],
                )
              ])),
        ));
  }
}
