import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectmobile/theme/theme.dart';

class SuccesDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Container(
            height: 140,
            width: 40,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: ListView(children: [
                Column(
                  children: [
                    Icon(
                      Icons.task_alt,
                      color: green,
                      size: 50,
                    ),
                    Text(
                      'Success',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: blackColor),
                    ),
                    Text(
                      'Data berhasil diubah',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: blackColor),
                    ),
                  ],
                ),
              ]),
            )));
  }
}
