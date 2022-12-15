import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectmobile/theme/theme.dart';
import '../login/login.dart';

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
                              onPressed: () {
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
