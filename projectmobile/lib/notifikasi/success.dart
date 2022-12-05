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
        child: Stack(
          children: [
            Container(
              height: 170,
              width: 280,
              child: Padding(
                padding: EdgeInsets.only(left: 30, right: 30, top: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 5,
                      width: 5,
                    ),
                    Icon(
                      Icons.task_alt,
                      color: blackColor,
                      size: 75,
                    ),
                    Container(
                        child: Text(
                      'Success',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: blackColor),
                    )),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
