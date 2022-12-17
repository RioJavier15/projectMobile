import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectmobile/notifikasi/success.dart';
import 'package:projectmobile/theme/theme.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:projectmobile/bottomnav.dart';

class EditProfile extends StatefulWidget {
  final String uname;
  final String uname1;
  final String status;
  final String kecepatan;
  final String kode_pelanggan;
  final String email_pelanggan;
  final String nomer_hp;
  final String password;
  EditProfile({
    Key? key,
    required this.uname,
    required this.uname1,
    required this.status,
    required this.kecepatan,
    required this.kode_pelanggan,
    required this.email_pelanggan,
    required this.nomer_hp,
    required this.password,
  }) : super(key: key);

  @override
  State<EditProfile> createState() => _ProfileEdit();
}

class _ProfileEdit extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final nama = TextEditingController(text: widget.uname1);
    final email = TextEditingController(text: widget.email_pelanggan);
    final hp = TextEditingController(text: widget.nomer_hp);
    Future editprofil() async {
      var url = Uri.http(
          "192.168.1.132:8080", '/projectWeb/API/editprofil.php', {'q': '{http}'});
      var response = await http.post(url, body: {
        "email": email.text.toString(),
        "email_user": widget.email_pelanggan,
        "nama": nama.text.toString(),
        "hp": hp.text.toString(),
        "kode_pelanggan": widget.kode_pelanggan,
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNav(
              uname: widget.uname,
              uname1: nama.text.toString(),
              status: widget.status,
              kecepatan: widget.kecepatan,
              kode_pelanggan: widget.kode_pelanggan,
              email_pelanggan: email.text.toString(),
              nomer_hp: hp.text.toString(),
              password: widget.password,
            ),
          ),
        );
      }
    }
    return SafeArea(
        child: Scaffold(
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
                          padding: new EdgeInsets.only(top: 40.0),
                        ),
                        TextFormField(
                          controller: nama,
                          decoration: new InputDecoration(
                              labelText: "Nama Lengkap",
                              hintText: widget.uname1,
                              border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(15))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        new Padding(
                          padding: new EdgeInsets.only(top: 40.0),
                        ),
                        TextFormField(
                          controller: email,
                          decoration: new InputDecoration(
                              labelText: "Email",
                              hintText: widget.email_pelanggan,
                              border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(15))),
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
                          padding: new EdgeInsets.only(top: 40.0),
                        ),
                        TextFormField(
                          controller: hp,
                          keyboardType: TextInputType.number,
                          decoration: new InputDecoration(
                              labelText: "Nomer HP",
                              hintText: widget.nomer_hp,
                              border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(15))),
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
    ));
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
