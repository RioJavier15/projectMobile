import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:projectmobile/theme/theme.dart';

class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, size.height);
    path.lineTo(size.width - 20, size.height);
    path.quadraticBezierTo(size.width - 10, size.height, size.width, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

Widget circularPercent(double percent) {
  return CircularPercentIndicator(
    radius: 20.0,
    lineWidth: 7.0,
    animation: true,
    percent: percent,
    circularStrokeCap: CircularStrokeCap.round,
    backgroundColor: grey2Color,
    progressColor: GreyColor,
  );
}
