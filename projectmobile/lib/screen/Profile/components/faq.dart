import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectmobile/theme/theme.dart';

class Faq extends StatefulWidget {
  const Faq({Key? key}) : super(key: key);

  @override
  State<Faq> createState() => _FaqState();
}

class _FaqState extends State<Faq> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(53),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Informasi Dan Bantuan',
              style: AppbarStyle,
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              iconSize: 24,
              color: blackColor,
              splashRadius: 20,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 5, top: 20),
          child: ListView.separated(
            itemCount: faq.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildExpandableTile(faq[index]);
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          ),
        ));
  }

  final List faq = [
    {
      "Answer": "",
      "Question": "Bagaimana cara melakukan transaksi berlanganan ?"
    },
    {"Answer": "", "Question": "Apa saja produk Fans tv"}
  ];
}

Widget _buildExpandableTile(item) {
  return ExpansionTile(
    title: Text(
      item['Question'],
      style: GoogleFonts.montserrat(
          color: blackColor, fontSize: 15, fontWeight: FontWeight.w500),
    ),
    children: <Widget>[
      ListTile(
        title: Text(
          item['Answer'],
          style: GoogleFonts.montserrat(
              color: blackColor, fontSize: 15, fontWeight: FontWeight.w600),
        ),
      )
    ],
  );
}
