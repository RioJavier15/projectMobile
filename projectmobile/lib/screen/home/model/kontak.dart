import 'package:flutter/material.dart';
import 'package:projectmobile/theme/theme.dart';

class ContactAdmin extends StatelessWidget {
  const ContactAdmin({
    Key? key,
    required this.image,
    required this.text,
    required this.title,
  }) : super(key: key);

  final String image;
  final String text;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          image,
          width: 281,
          height: 164,
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 25,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                backgroundColor: NavyColor,
                elevation: 8,
                shape: StadiumBorder()),
            child: Text(
              text,
              style: regulerText10.copyWith(color: TextButtonColor),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          title,
          style: boldText14.copyWith(color: blackColor),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
        ),
      ],
    );
  }
}
