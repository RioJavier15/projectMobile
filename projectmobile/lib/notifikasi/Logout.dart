import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectmobile/theme/theme.dart';

class LogoutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Stack(
          children: [
            Container(
              height: 188,
              width: 328,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                      width: 27,
                    ),
                    Text(
                      'Apakah anda yakin ingin keluar akun?',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: blackColor),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.only(left: 30, right: 30)),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('Ya'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: ButtonBackground,
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              textStyle: ButtonTextStyle),
                        ),
                        SizedBox(
                          height: 10,
                          width: 30,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context, 'Cancel');
                          },
                          child: Text('Cancel'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: ButtonBackground,
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              textStyle: ButtonTextStyle),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
