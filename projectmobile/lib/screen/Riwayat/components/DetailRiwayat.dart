import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectmobile/theme/theme.dart';

class DetailRiwayat extends StatelessWidget {
  const DetailRiwayat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ButtonBackground,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(53),
          child: AppBar(
            centerTitle: true,
            title: Text('Detail Riwayat',
                style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: TextButtonColor)),
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              iconSize: 24,
              color: TextButtonColor,
              splashRadius: 20,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        body: ListView(
          children: [
            Container(
              height: 320,
              margin: EdgeInsets.symmetric(vertical: 30, horizontal: 40),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0xFFF8F4F4),
                  boxShadow: [BoxShadow(blurRadius: 6, color: GreyColor)]),
              child: Padding(
                  padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                  child: Column(
                    children: [
                      Text(
                        'Fans TV',
                        style: AppbarStyle,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Perum Griya Mangli Indah Df 01, Kec. Kaliwates, Kab. Jember, Jawa Timur 68136',
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: blackColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(
                        color: blackColor,
                        thickness: 2,
                      ),
                      Divider(
                        color: blackColor,
                        thickness: 2,
                      ),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Row(
                        children: [
                          Text(
                            'Lusy D',
                            textAlign: TextAlign.left,
                            style: TextLoginRegister,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Paket',
                            style: struk,
                          ),
                          Text(
                            'Internet Lite',
                            style: struk,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Kode Transaksi',
                            style: struk,
                          ),
                          Text(
                            'TR000123456',
                            style: struk,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Harga',
                            style: struk,
                          ),
                          Text(
                            '200.000',
                            style: struk,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tanggal',
                            style: struk,
                          ),
                          Text(
                            '28-05-2022',
                            style: struk,
                          )
                        ],
                      ),
                      Divider(
                        color: blackColor,
                        thickness: 1.5,
                      ),
                      Divider(
                        color: blackColor,
                        thickness: 1.5,
                      ),
                    ],
                  )),
            )
          ],
        ));
  }
}
