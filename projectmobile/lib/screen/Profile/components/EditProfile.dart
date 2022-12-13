import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectmobile/notifikasi/success.dart';
import 'package:projectmobile/theme/theme.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _ProfileEdit();
}

class _ProfileEdit extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
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
                  buildTextField("Email", "Example@gmail.com"),
                  buildTextField("Nama Pengguna", "Lusy D"),
                  buildTextField("No. Handphone", "082123457865"),
                  const SizedBox(height: 20),
                  SizedBox(
                      height: 35,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                Future.delayed(Duration(seconds: 2), () {
                                  Navigator.of(context).pop(true);
                                });
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
