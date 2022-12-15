import 'package:projectmobile/bottomnav.dart';
import 'package:projectmobile/theme/theme.dart';
import 'package:projectmobile/register.dart';
// import 'package:fanstv/splashscreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'body.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projectmobile/screen/home/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _visible = false;

  //Textediting Controller for Username and Password Input
  final userController = TextEditingController();
  final pwdController = TextEditingController();

  Future userLogin() async {
    //Login API URL
    //use your local IP address instead of localhost or use Web API
    String url = "http://127.0.0.1/projectWeb/API/login.php";

    // Showing LinearProgressIndicator.
    setState(() {
      _visible = true;
    });

    // Getting username and password from Controller
    var data = {
      'email': userController.text,
      'password': pwdController.text,
    };

    //Starting Web API Call.
    var response = await http.post(Uri.parse(url), body: json.encode(data));
    if (response.statusCode == 200) {
      //Server response into variable
      print(response.body);
      var msg = jsonDecode(response.body);

      //Check Login Status
      if (msg['loginStatus'] == true) {
        setState(() {
          //hide progress indicator
          _visible = false;
        });

        // Navigate to Home Screen
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BottomNav(
                      uname: msg['userInfo']['nama_produk'],
                      status: msg['userInfo']['status'],
                      kecepatan: msg['userInfo']['kecepatan'],
                      uname1: msg['userInfo']['nama_pelanggan'],
                      kode_pelanggan: msg['userInfo']['kode_pelanggan'],
                    )));
      } else {
        setState(() {
          //hide progress indicator
          _visible = false;

          //Show Error Message Dialog
          showMessage(msg["message"]);
        });
      }
    } else {
      setState(() {
        //hide progress indicator
        _visible = false;

        //Show Error Message Dialog
        showMessage("Error during connecting to Server.");
      });
    }
  }

  Future<void> showMessage(String _msg) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(_msg),
          actions: <Widget>[
            TextButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  final _formKey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView(children: [
        new Container(
          margin: const EdgeInsets.only(top: 90, left: 10, right: 10),
          // decoration: new BoxDecoration(
          //     // gradient: new LinearGradient(
          //     //     begin: FractionalOffset.topCenter,
          //     //     end: FractionalOffset.bottomCenter,
          //     //     colors: [
          //     //       // Color.fromARGB(176, 218, 159, 159),
          //     //       // Color.fromARGB(134, 175, 120, 120),
          //     //       Color.fromARGB(255, 255, 255, 255)
          //     //     ]),
          //     ),
          padding: new EdgeInsets.all(10.0),
          child: new Column(children: <Widget>[
            Text(
              'Login',
              style: GoogleFonts.montserrat(
                  color: Color.fromARGB(200, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                  fontSize: 27),
            ),
            new Padding(
              padding: new EdgeInsets.only(top: 40.0),
            ),
            new TextField(
              controller: userController,
              decoration: new InputDecoration(
                  labelText: "Email",
                  hintText: "E-mail",
                  border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(15))),
            ),
            new Padding(
              padding: new EdgeInsets.only(top: 20.0),
            ),
            new TextField(
              controller: pwdController,
              obscureText: _visible,
              decoration: new InputDecoration(
                  labelText: "Password",
                  hintText: "Password",
                  border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(15)),
                  suffixIcon: IconButton(
                    icon: Icon(
                        _visible ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _visible = !_visible;
                      });
                    },
                  )),
            ),
            new Padding(
              padding: new EdgeInsets.only(top: 20.0),
            ),
            // new Container(
            //   margin: EdgeInsets.only(left: 20),
            //   child: InkWell(
            //     onTap: () {},
            //     child: Text(
            //       "Forgot Password?",
            //       style: TextStyle(
            //           color: cyanblue.withOpacity(0.7),
            //           fontWeight: FontWeight.w500),
            //     ),
            //   ),
            // ),
          ]),
        ),
        new Padding(
          padding: new EdgeInsets.only(top: 5.0),
        ),
        // new Container(
        //   margin: EdgeInsets.only(left: 20),
        //   child: InkWell(
        //     onTap: () {},
        //     child: Text(
        //       "Forgot Password?",
        //       style: TextStyle(
        //           color: cyanblue.withOpacity(0.7),
        //           fontWeight: FontWeight.w500),
        //     ),
        //   ),
        // ),
        // InkWell(onTap: () {
        //   print("Sign up click");
        // }
        // TextButton(
        //   style: TextButton.styleFrom(
        //     backgroundColor: Color.fromARGB(255, 40, 56, 90),
        //     primary: Color.fromARGB(255, 255, 255, 255), // foreground
        //   ),
        //   onPressed: () {},
        //   child: Text('Sign in'),
        // )

        Container(
          margin: EdgeInsets.only(right: 10, left: 10),
          height: 40,
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: ElevatedButton(
            style: raisedButtonStyle,
            child: Text("Sign in"),
            onPressed: () {
              userLogin();

              // Text('Sign in');
            },
          ),
        ),
        new Padding(
          padding: new EdgeInsets.only(top: 5.0),
        ),
        Container(
          margin: const EdgeInsets.only(left: 90, right: 20),
          // margin: EdgeInsets.only(
          //     left: MediaQuery.of(context).size.width * 0.150,
          //     top: MediaQuery.of(context).size.height * 0.08),
          child: Text.rich(
            TextSpan(
                text: " Don't have an account? ",
                style: TextStyle(
                    color: Navy2Color.withOpacity(0.8),
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
                children: [
                  TextSpan(
                      text: "Register",
                      style: TextStyle(
                          color: NavyColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Register()));
                          print("klik register");
                        }),
                ]),
          ),
        ),
      ]),
    );
  }

  TextEditingController controllerEmail = new TextEditingController();
  TextEditingController controllerPass = new TextEditingController();
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.white,
      primary: Color.fromARGB(255, 34, 40, 49),
      minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ));
}
