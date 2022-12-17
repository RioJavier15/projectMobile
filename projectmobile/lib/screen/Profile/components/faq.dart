import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectmobile/theme/theme.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:projectmobile/env.dart';

class Faq extends StatefulWidget {
  const Faq({Key? key}) : super(key: key);

  @override
  State<Faq> createState() => _FaqState();
}

class _FaqState extends State<Faq> {
  late List Informasi;
  Future<String> getInformasi() async {
    var response = await http.post(
        Uri.http("${Env.URL_PERFIX}", '/projectWeb/API/faq.php', {'q': '{http}'}));
    setState(() {
      Informasi = json.decode(response.body);
    });
    return "Success!";
  }

  void initState() {
    getInformasi();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
                child: FutureBuilder(
                    future: getInformasi(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return ListView.separated(
                          itemCount: Informasi == null ? 0 : Informasi.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ExpansionTile(
                              title: Text(
                                Informasi[index]["pertanyaan"],
                                style: GoogleFonts.montserrat(
                                    color: blackColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                              children: <Widget>[
                                ListTile(
                                  title: Text(
                                    Informasi[index]["jawaban"],
                                    style: GoogleFonts.montserrat(
                                        color: blackColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )
                              ],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(),
                        );
                      } else {
                        return Center(
                          child: Container(),
                        );
                      }
                    }))));
  }
}
