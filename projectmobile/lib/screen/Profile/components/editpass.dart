import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectmobile/notifikasi/success.dart';
import 'package:projectmobile/theme/theme.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:projectmobile/bottomnav.dart';
import 'package:projectmobile/env.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditPassword extends StatefulWidget {
  const EditPassword({Key? key}) : super(key: key);

  @override
  State<EditPassword> createState() => _EditPassword();
}

class _EditPassword extends State<EditPassword> {
  String kode_pelanggan = "";
  Future getdatapw() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      kode_pelanggan = (prefs.getString('kode_pelanggan') ?? "");
    });
  }

  @override
  void initState() {
    super.initState();
    getdatapw();
  }

  final TextEditingController pass = TextEditingController();
  final TextEditingController pass1 = TextEditingController();
  bool showPassword = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Future editpass() async {
      String url = "${Env.URL_PERFIX}/API/editpw.php";
      var response = await http.post(Uri.parse(url), body: {
        "password": pass.text.toString(),
        "kode": kode_pelanggan,
      });
      var data = json.decode(response.body);
      if (data == "Success") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Edit password berhasil')),
        );
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(
          'password',
          pass.text.toString(),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNav(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Edit gagal')),
        );
      }
    }

    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(53),
          child: AppBar(
            centerTitle: true,
            title: Text('Edit Password', style: AppbarStyle),
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              iconSize: 24,
              splashRadius: 20,
              color: blackColor,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )),
      body: ListView(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              padding: EdgeInsets.only(top: 20, left: 24),
              child: Text(
                  'Masukkan password baru dan konfirmasi kembali memasukkan pasword baru. ',
                  style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(0, 0, 0, 0.6)))),
          Container(
              padding: EdgeInsets.only(top: 20, left: 24, right: 30),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(children: <Widget>[
                      new Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      TextFormField(
                        maxLength: 15,
                        showCursor: true,
                        cursorColor: blackColor,
                        controller: pass,
                        decoration: new InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 3),
                            labelText: "Password",
                            labelStyle: TextFieldStyle,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: "*************",
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
                        maxLength: 15,
                        showCursor: true,
                        cursorColor: blackColor,
                        controller: pass1,
                        decoration: new InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 3),
                            labelText: "Konfirmasi Password",
                            labelStyle: TextFieldStyle,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: "*************",
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
                    ]),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                      height: 35,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (pass.text.toString() == pass1.text.toString()) {
                              editpass();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Pasword tidak sama')),
                              );
                            }
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
              ))
        ])
      ]),
    ));
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        showCursor: true,
        cursorColor: blackColor,
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.symmetric(vertical: 3),
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
