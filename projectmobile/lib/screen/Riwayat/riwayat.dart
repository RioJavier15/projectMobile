import 'dart:convert';
import 'package:projectmobile/screen/Riwayat/components/DetailRiwayat.dart';
import 'package:projectmobile/theme/theme.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as htpp;

class Riwayat extends StatefulWidget {
  String kode_pelanggan;
  Riwayat(this.kode_pelanggan);

  @override
  State<Riwayat> createState() => _RiwayatState(kode_pelanggan);
}

class _RiwayatState extends State<Riwayat> {
  String kode_pelanggan;
  _RiwayatState(this.kode_pelanggan);
  late List blogdata;
  Future<String> getBlogData() async {
    var response = await htpp.post(
        Uri.http("192.168.43.61:8080", '/projectWeb/API/transaksi.php', {'q': '{http}'}),
        body: {
          "kode_pelanggan": kode_pelanggan,
        });
    setState(() {
      blogdata = json.decode(response.body);
    });
    return "Success!";
  }

  void initState() {
    getBlogData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(53),
          child: AppBar(
            centerTitle: true,
            title: Text('Riwayat Pembayaran', style: AppbarStyle),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
        body: FutureBuilder<String>(
            future: getBlogData(),
            builder: (context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: blogdata == null ? 0 : blogdata.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                              height: 80,
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                color: ButtonBackground,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                elevation: 10,
                                child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => DetailRiwayat(
                                                  blogdata[index]
                                                      ["nama_pelanggan"],
                                                  blogdata[index]
                                                      ["kode_transaksi"],
                                                  blogdata[index]["total"],
                                                  blogdata[index]
                                                      ["nama_produk"],
                                                  blogdata[index]
                                                      ["tanggal_transaksi"])));
                                    },
                                    child: ListTile(
                                      title: Padding(
                                          padding: EdgeInsets.only(bottom: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  blogdata[index]
                                                      ["nama_pelanggan"],
                                                  style: ButtonTextStyle),
                                              Text(
                                                  blogdata[index]
                                                      ["tanggal_transaksi"],
                                                  style: ButtonTextStyle),
                                            ],
                                          )),
                                      subtitle: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(blogdata[index]["nama_produk"],
                                              style: ButtonTextStyle),
                                        ],
                                      ),
                                    )),
                              )));
                    });
              } else {
                return Center(
                  child: Container(),
                );
              }
            }));
  }
}
