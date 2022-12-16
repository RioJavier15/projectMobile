import 'package:projectmobile/theme/theme.dart';
import 'package:projectmobile/login/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login/login.dart';
import 'package:email_validator/email_validator.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);
  @override
  _FormRegisterState createState() => _FormRegisterState();
}

class _FormRegisterState extends State<Register> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerNama = TextEditingController();
  TextEditingController controllerPass = TextEditingController();
  TextEditingController controllerHp = TextEditingController();
  Future register() async {
    var url = Uri.http(
        "127.0.0.1:8080", '/projectWeb/API/register.php', {'q': '{http}'});
    var response = await http.post(url, body: {
      "email": controllerEmail.text.toString(),
      "password": controllerPass.text.toString(),
      "nama": controllerNama.text.toString(),
      "hp": controllerHp.text.toString(),
    });
    var data = json.decode(response.body);
    if (data == "Error") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email sudah ada')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registrasi berhasil')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    }
  }

  @override
  final _formKey = GlobalKey<FormState>();
  bool _visible = true;
  // get raisedButtonStyle => null;
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        // centerTitle: true,
        // title: new Text("Register",
        //     style: GoogleFonts.montserrat(
        //         color: Color.fromARGB(200, 0, 0, 0),
        //         fontWeight: FontWeight.w500,
        //         fontSize: 22)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: 24,
          splashRadius: 20,
          color: black2Color,
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          },
        ),
      ),
      body: new ListView(children: [
        new Container(
          // decoration: new BoxDecoration(
          //   gradient: new LinearGradient(
          //       begin: FractionalOffset.topCenter,
          //       end: FractionalOffset.bottomCenter,
          //       colors: [
          //         Color.fromARGB(176, 218, 159, 159),
          //         Color.fromARGB(134, 175, 120, 120),
          //         Color.fromARGB(179, 255, 235, 235)
          //       ]),
          // ),
          padding: new EdgeInsets.all(20.0),
          child: new Column(children: <Widget>[
            Text(
              'Register',
              style: GoogleFonts.montserrat(
                  color: black2Color,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            new Padding(
              padding: new EdgeInsets.only(top: 30.0),
            ),
            new Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  // Add TextFormFields and ElevatedButton here.
                  new TextFormField(
                    controller: controllerEmail,
                    decoration: new InputDecoration(
                        labelText: "E-mail",
                        hintText: "E-mail",
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
                    padding: new EdgeInsets.only(top: 20.0),
                  ),
                  new TextFormField(
                    controller: controllerNama,
                    decoration: new InputDecoration(
                        labelText: "Nama Lengkap",
                        hintText: "Nama Lengkap",
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
                    padding: new EdgeInsets.only(top: 20.0),
                  ),
                  new TextFormField(
                    controller: controllerPass,
                    obscureText: _visible,
                    decoration: new InputDecoration(
                        labelText: "Password",
                        hintText: "Password",
                        border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(15)),
                        suffixIcon: IconButton(
                          icon: Icon(_visible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _visible = !_visible;
                            });
                          },
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(top: 20.0),
                  ),
                  new TextFormField(
                    controller: controllerHp,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                        labelText: "Nomer telepon",
                        hintText: "Nomer telepon",
                        border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(15))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),

            // new Padding(
            //   padding: new EdgeInsets.only(top: 20.0),
            // ),
            // new TextField(
            //   controller: controllerAlamat,
            //   maxLines: 3,
            //   decoration: new InputDecoration(
            //       hintText: "Alamat",
            //       border: new OutlineInputBorder(
            //           borderRadius: new BorderRadius.circular(0))),
            // ),
            new Padding(
              padding: new EdgeInsets.only(top: 5.0),
            ),
            Container(
              margin: EdgeInsets.only(right: 10, left: 10),
              height: 40,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                style: raisedButtonStyle,
                child: Text("Sign up"),
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                    register();
                  }
                },
              ),
            ),
            // TextButton(
            //   style: TextButton.styleFrom(
            //     backgroundColor: Color.fromARGB(255, 199, 197, 197),
            //     primary: Color.fromARGB(255, 173, 113, 113), // foreground
            //   ),
            //   onPressed: () {},
            //   child: Text('Sign in'),
            // )
          ]),
        ),
      ]),
    );
  }

  // TextEditingController controllerAlamat = new TextEditingController();
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.white,
      primary: Color.fromARGB(255, 34, 40, 49),
      minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ));
}
