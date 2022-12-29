import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectmobile/screen/home/model/clipper.dart';
import 'package:projectmobile/screen/home/model/contact.dart';
import 'package:projectmobile/screen/home/model/Kontak.dart';
import 'package:projectmobile/theme/theme.dart';
import 'package:projectmobile/env.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:projectmobile/formatstring.dart';
import 'package:projectmobile/notificationservice.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

void notif() async {
  final prefs = await SharedPreferences.getInstance();
  String status = (prefs.getString('status') ?? "");
  final date = DateTime.now();
  final tanggal = DateTime(date.year, date.month + 1, 1);
  final Duration durasi = tanggal.difference(date);
  DateTime hari = DateTime.now();
  // var status = "aktif";
  if (durasi.inDays == 7 && status == "aktif") {
    NotificationService().showNotification(
        1, "Masa aktif", "Masa aktif paket internet 7 hari lagi");
  } else if (durasi.inDays == 3 && status == "aktif") {
    NotificationService().showNotification(
        2, "Masa aktif", "Masa aktif paket internet 3 hari lagi");
  } else if (durasi.inDays == 1 && status == "aktif") {
    NotificationService().showNotification(
        3, "Masa aktif", "Masa aktif paket internet berakhir hari ini");
  } else if (status == "none") {
    NotificationService().showNotification(4, "Belum berlangganan",
        "Anda belum berlangganan paket intenet. Hubungi admin untuk berlangganan");
  } else if (status == "non aktif") {
    NotificationService().showNotification(4, "Paket Non Aktif",
        "Hubungi admin untuk mengaktifkan paket internet anda");
  }
}

class _HomeScreenState extends State<HomeScreen> {
  String nama = "";
  String namaProduk = "";
  String status = "";
  String kecepatan = "";
  Future getdatahome() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      namaProduk = (prefs.getString('nama_produk') ?? "");
      nama = (prefs.getString('nama_pelanggan') ?? "");
      status = (prefs.getString('status') ?? "");
      kecepatan = (prefs.getString('kecepatan') ?? "");
    });
  }

  late List produk;
  Future<String> getproduk() async {
    String url = "${Env.URL_PERFIX}/API/produk.php";
    var response = await http.post(Uri.parse(url));
    setState(() {
      produk = json.decode(response.body);
    });
    return "Success!";
  }

  void initState() {
    getdatahome();
    getproduk();
    tz.initializeTimeZones();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    notif();
    final date = DateTime.now();
    final tanggal = DateTime(date.year, date.month + 1, 1);
    final Duration durasi = tanggal.difference(date);
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            Padding(
                padding: EdgeInsets.only(left: 24, top: 24, bottom: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Hi, Welcome',
                          style: GoogleFonts.nunito(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: blackColor,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          nama.toTitleCase(),
                          style: GoogleFonts.nunito(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: blackColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
            //kotak tengah
            Container(
              height: 230,
              child: ListView(
                  padding: EdgeInsets.only(left: 24, right: 24),
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 8),
                      height: 230,
                      width: 220,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Navy2Color,
                          boxShadow: [
                            BoxShadow(
                                color: Color(0x10000000),
                                blurRadius: 10,
                                spreadRadius: 4,
                                offset: Offset(0.0, 8.0))
                          ]),
                      child: Padding(
                        padding: EdgeInsets.only(top: 15, bottom: 5),
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
                              child: Text(
                                'Deskripsi: ',
                                style: mediumText12.copyWith(color: grey2Color),
                              ),
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
                                  margin: EdgeInsets.only(
                                      right: 25, bottom: 15, top: 20),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 7, horizontal: 19),
                                  decoration: BoxDecoration(
                                    color: grey2Color,
                                    borderRadius: BorderRadius.circular(16.5),
                                  ),
                                  child: Text(
                                    status,
                                    style: mediumText12.copyWith(
                                        color: blackColor),
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              color: grey2Color,
                              thickness: 4,
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 17,
                                    top: 15), //apply padding to some sides only
                                child: Row(
                                  children: [
                                    circularPercent(0.9),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Tenggat Bayar',
                                              style: mediumText13.copyWith(
                                                  color: grey2Color),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(children: [
                                                    Image.asset(
                                                      'assets/icons/icon-warning.png',
                                                      width: 13,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      status == "aktif"
                                                          ? "${durasi.inDays}" +
                                                              ' hari lagi'
                                                          : "-",
                                                      style:
                                                          mediumText10.copyWith(
                                                              color: grey2Color,
                                                              letterSpacing:
                                                                  0.2),
                                                    ),
                                                  ]),
                                                  Text(
                                                    status == "aktif"
                                                        ? 'Sebelum tanggal ' +
                                                            "${tanggal.day} - " +
                                                            "${tanggal.month} - " +
                                                            "${tanggal.year}"
                                                        : "",
                                                    style:
                                                        mediumText10.copyWith(
                                                            color: grey2Color,
                                                            letterSpacing: 0.2),
                                                  )
                                                ])
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ))
                          ],
                        ),
                      ),
                    )
                  ]),
            ),
            //bagian bawah 1
            Padding(
              padding:
                  EdgeInsets.only(left: 24, top: 32, bottom: 16, right: 24),
              child: Row(
                children: [
                  Text(
                    'Rekomendasi Untukmu',
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: blackColor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 131,
              child: FutureBuilder(
                future: getproduk(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      padding: EdgeInsets.only(left: 16, right: 8),
                      scrollDirection: Axis.horizontal,
                      itemCount: produk == null ? 0 : produk.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.only(right: 8),
                          height: 131,
                          width: 284,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(14)),
                            color: grey2Color,
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0x04000000),
                                  blurRadius: 1,
                                  spreadRadius: 10,
                                  offset: Offset(0.0, 1.0))
                            ],
                          ),
                          child: Stack(
                            children: [
                              ClipPath(
                                clipper: BackgroundClipper(),
                                child: Container(
                                  padding: EdgeInsets.only(left: 11, top: 2),
                                  height: 18,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    color: NavyColor,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(14),
                                    ),
                                  ),
                                  child: Text('Buy it again',
                                      style: mediumText9.copyWith(
                                        color: primaryColor,
                                        letterSpacing: 0.2,
                                      )),
                                ),
                              ),
                              Positioned(
                                  top: 27,
                                  left: 18,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          produk[index]["nama_produk"],
                                          style: mediumText12.copyWith(
                                            color: NavyColor,
                                            letterSpacing: 0.3,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          produk[index]["kecepatan"] + " Mbps",
                                          style: mediumText15.copyWith(
                                            color: NavyColor,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          produk[index]["harga_produk"],
                                          style: boldText14.copyWith(
                                            color: NavyColor,
                                          ),
                                        )
                                      ]))
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return Container(
                      color: primaryColor,
                    );
                  }
                },
              ),
            ),
            // kotak bawah2
            Padding(
              padding:
                  EdgeInsets.only(left: 24, top: 32, bottom: 16, right: 24),
              child: Text(
                'Contact Person',
                style: GoogleFonts.nunito(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: blackColor,
                ),
              ),
            ),
            Container(
              height: 250,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 16, right: 10),
                children: [
                  Row(
                    children: [
                      ContactPerson(
                          image: "assets/images/admin.png",
                          text: "Hubungi",
                          title: "Admin Fans TV"),
                      SizedBox(
                        width: 16,
                      ),
                      ContactAdmin(
                          image: "assets/images/teknisi.png",
                          text: "Hubungi",
                          title: "Teknisi Fans TV"),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
