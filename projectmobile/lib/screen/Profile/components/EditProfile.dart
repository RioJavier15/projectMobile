import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectmobile/notifikasi/success.dart';
import 'package:projectmobile/theme/theme.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:projectmobile/bottomnav.dart';
import 'package:projectmobile/env.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:projectmobile/formatstring.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _ProfileEdit();
}

class _ProfileEdit extends State<EditProfile> {
  String uname1 = "";
  String email_pelanggan = "";
  String nomer_hp = "";
  String kode_pelanggan = "";
  Future getdataprofil() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      kode_pelanggan = (prefs.getString('kode_pelanggan') ?? "");
      uname1 = (prefs.getString('nama_pelanggan') ?? "");
      email_pelanggan = (prefs.getString('email_pelanggan') ?? "");
      nomer_hp = (prefs.getString('nomer_hp') ?? "");
    });
  }

  @override
  void initState() {
    super.initState();
    getdataprofil();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final nama = TextEditingController(text: uname1.toTitleCase());
    final email = TextEditingController(text: email_pelanggan);
    final hp = TextEditingController(text: nomer_hp);
    Future editprofil() async {
      String url = "${Env.URL_PERFIX}/API/editprofil.php";
      var response = await http.post(Uri.parse(url), body: {
        "email": email.text.toString(),
        "email_user": email_pelanggan,
        "nama": nama.text.toString(),
        "hp": hp.text.toString(),
        "kode_pelanggan": kode_pelanggan,
      });
      var data = json.decode(response.body);
      if (data == "Error") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email sudah ada')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Edit berhasil')),
        );

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(
          'email_pelanggan',
          email.text.toString(),
        );
        await prefs.setString(
          'nama_pelanggan',
          nama.text.toString(),
        );
        await prefs.setString(
          'nomer_hp',
          hp.text.toString(),
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNav(),
          ),
        );
      }
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(53),
        child: AppBar(
          centerTitle: true,
          title: Text('Edit Profile', style: AppbarStyle),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            iconSize: 24,
            color: blackColor,
            splashRadius: 20,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: ListView(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 10, left: 24, right: 30),
              child: Column(
                children: [
                  Form(
                      key: _formKey,
                      child: Column(children: <Widget>[
                        new Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                        TextFormField(
                          maxLength: 25,
                          showCursor: true,
                          cursorColor: blackColor,
                          controller: nama,
                          decoration: new InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 3),
                              labelText: "Nama Lengkap",
                              labelStyle: TextFieldStyle,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintText: uname1,
                              hintStyle: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  color: grey2Color,
                                  fontWeight: FontWeight.w600),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: blackColor))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        new Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                        TextFormField(
                          maxLength: 30,
                          showCursor: true,
                          cursorColor: blackColor,
                          controller: email,
                          decoration: new InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 3),
                              labelText: "Email",
                              labelStyle: TextFieldStyle,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintText: email_pelanggan,
                              hintStyle: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  color: grey2Color,
                                  fontWeight: FontWeight.w600),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: blackColor))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            } else if (!EmailValidator.validate(value, true)) {
                              return "Invalid Email Address";
                            }
                            return null;
                          },
                        ),
                        new Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                        TextFormField(
                          maxLength: 13,
                          showCursor: true,
                          cursorColor: blackColor,
                          controller: hp,
                          keyboardType: TextInputType.number,
                          decoration: new InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 3),
                              labelText: "Nomer HP",
                              labelStyle: TextFieldStyle,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintText: nomer_hp,
                              hintStyle: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  color: grey2Color,
                                  fontWeight: FontWeight.w600),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: blackColor))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ])),
                  const SizedBox(height: 20),
                  SizedBox(
                      height: 35,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                            editprofil();
                          }
                        },
                        child: Center(
                          child: Text(
                            'Simpan',
                            style: ButtonTextStyle,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ButtonBackground,
                          elevation: 8,
                        ),
                      ))
                ],
              ),
            ),
          ],
        )
      ]),
    );
  }

  Widget buildTextField(String labelText, String placeholder) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        showCursor: true,
        cursorColor: blackColor,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 3),
            labelText: labelText,
            labelStyle: TextFieldStyle,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: GoogleFonts.montserrat(
                fontSize: 16, color: grey2Color, fontWeight: FontWeight.w600),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: blackColor))),
      ),
    );
  }
}
