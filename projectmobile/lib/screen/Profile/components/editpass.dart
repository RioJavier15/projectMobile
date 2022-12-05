import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectmobile/notifikasi/success.dart';
import 'package:projectmobile/theme/theme.dart';

class EditPassword extends StatefulWidget {
  const EditPassword({Key? key}) : super(key: key);

  @override
  State<EditPassword> createState() => _EditPassword();
}

class _EditPassword extends State<EditPassword> {
  final TextEditingController pass = TextEditingController();
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  buildTextField("Password", "**************", true),
                  buildTextField("Konfirmasi Password", "**************", true),
                  SizedBox(height: 20),
                  SizedBox(
                      height: 35,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return SuccesDialog();
                              });
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
    );
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
