import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:projectmobile/theme/theme.dart';

class CardInfoHome extends StatelessWidget {
  String namaProduk;
  String status;
  String kecepatan;
  CardInfoHome(this.namaProduk, this.status, this.kecepatan);

  @override
  Widget build(BuildContext context) {
    Widget circularPercent(double percent) {
      return CircularPercentIndicator(
        radius: 35.0,
        lineWidth: 7.0,
        animation: true,
        percent: percent,
        circularStrokeCap: CircularStrokeCap.round,
        backgroundColor: grey2Color,
        progressColor: GreyColor,
      );
    }

    Widget infoCardList_2() {
      return Row(
        children: [
          Expanded(
            flex: 1,
            child: circularPercent(0.9),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Tenggat Bayar',
                      style: mediumText13.copyWith(color: grey2Color),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/icons/icon-warning.png',
                              width: 13,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '3 hari lagi',
                              style: mediumText10.copyWith(
                                  color: grey2Color, letterSpacing: 0.2),
                            ),
                          ],
                        ),
                        Text(
                          'Sebelum tanggal 23 desember',
                          style: mediumText10.copyWith(
                              color: grey2Color, letterSpacing: 0.2),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      );
    }

    //kotak atas
    return Container(
      margin: const EdgeInsets.only(top: 18, left: 16, right: 16),
      decoration: BoxDecoration(
        color: Navy2Color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Navy2Color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 17), //apply padding to some sides only
                      child: Text(
                        status == "aktif"
                            ? "Paket " + namaProduk
                            : "belum berlangganan",
                        style: mediumText17.copyWith(color: grey2Color),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 17), //apply padding to some sides only
                      child: Text('Deskripsi :',
                          style: mediumText12.copyWith(color: grey2Color)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 17), //apply padding to some sides only
                      child: Text(
                        status == "aktif"
                            ? 'internet sangat kencang dengan kecepatan ' +
                                kecepatan +
                                " Mbps"
                            : "hubungi admin untuk melakukan aktivasi paket internet",
                        style: mediumText12.copyWith(color: grey2Color),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          margin:
                              EdgeInsets.only(right: 25, bottom: 15, top: 20),
                          padding: const EdgeInsets.symmetric(
                              vertical: 7, horizontal: 19),
                          decoration: BoxDecoration(
                            color: grey2Color,
                            borderRadius: BorderRadius.circular(16.5),
                          ),
                          child: Text(
                            status,
                            style: mediumText12.copyWith(color: blackColor),
                          ),
                        ),
                      ],
                    ),

                    Divider(
                      color: grey2Color,
                      thickness: 5,
                    ),

                    //kotak bawah
                    Padding(
                      padding: EdgeInsets.only(
                          left: 17, top: 15), //apply padding to some sides only
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: circularPercent(0.9),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Tenggat Bayar',
                                      style: mediumText13.copyWith(
                                          color: grey2Color),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              'assets/icons/icon-warning.png',
                                              width: 13,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '3 hari lagi',
                                              style: mediumText10.copyWith(
                                                  color: grey2Color,
                                                  letterSpacing: 0.2),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          'Sebelum tanggal 23 desember',
                                          style: mediumText10.copyWith(
                                              color: grey2Color,
                                              letterSpacing: 0.2),
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
