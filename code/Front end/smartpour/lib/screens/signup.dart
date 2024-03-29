// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:smartpour/screens/devicepage.dart';
import 'package:smartpour/screens/user.dart';
import '../utilities/form_validators.dart';
import 'login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: use_key_in_widget_constructors
class SignupPage extends StatefulWidget {
  @override
  _SignupViewState createState() => _SignupViewState();
}


class _SignupViewState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  
  //String url = "http://10.0.2.2:8080/smartpour/user/adduser";

  // Future save() async {
  //   var res = await http.post(Uri.parse(url),
  //       headers: {'Content-Type': 'application/json'},
  //       body: json.encode({'useremail': user.email, 'password': user.password}));
  //       print(res.body);
      
  // }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final emailField = TextFormField(
        key: Key("Add Name"),
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          hintText: "Your Email",
          labelText: "Email",
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          hintStyle: TextStyle(
            color: Colors.white,
          ),
        ),
        validator: emailValidator);

    final passwordField = Column(
      children: <Widget>[
        TextFormField(
            key: Key("Addpassword"),
            obscureText: true,
            controller: _passwordController,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
            cursorColor: Colors.white,
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
              hintText: "password",
              labelText: "Password",
              labelStyle: TextStyle(
                color: Colors.white,
              ),
              hintStyle: TextStyle(
                color: Colors.white,
              ),
            ),
            validator: passwordValidator),
        Padding(
          padding: EdgeInsets.all(2.0),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );

    final fields = Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          emailField,
          passwordField,
        ],
      ),
    );
    return Scaffold(
        body: Form(
      key: _formKey,
      child: Stack(
        children: [
          SizedBox(
            height: size.height,
            width: size.height,
            child: Image.asset("images/bg_log_sign.jpeg", fit: BoxFit.cover),
          ),
          Container(
            padding: EdgeInsets.all(40),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor.withOpacity(0.4)
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 80),
                  child: Text(
                    "SIGN UP",
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 5),
                  child: Image.asset(
                    "images/logo_t.png",
                    width: size.width * 0.6,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  height: 250,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white.withOpacity(0.5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [fields],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 60,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () async {
                    

                      // var url =Uri.parse("http://10.0.2.2:8080/smartpour/user/getAllusers");
                      // var response =await http.get(url);
                      // print('Response status: ${response.statusCode}');
                      // print('Response body: ${response.body}');
                      // var data =jsonDecode(response.body);
                      

                    //postdata();
                    if (_formKey.currentState!.validate()) {

                      final response = await http.post(
                        Uri.parse(
                            'http://10.0.2.2:8080/smartpour/user/adduser'),
                            headers: {'Content-Type': 'application/json'},
                            body: jsonEncode(<String, String>{
                            "useremail": _emailController.text,
                            "password": _passwordController.text,
                        }),
                      );

                      User user = User(_emailController.text, _passwordController.text);
                      var res=jsonDecode(response.body) ;
                      if (res["success"]==true){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DevicePage()));

                      }else{
                        showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text("Alerts!"),
                              content: const Text("User has already signed up"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(14),
                                    child: const Text("okay"),
                                  ),
                                ),
                              ],
                            ),
                          );

                      }
                      //print(res["success"]);

                      
                    }
                    },

                    key: Key("signup"),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        primary: Color(0xffB98C53)),
                    child: Text(
                      "SIGN UP",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text(
                    "Already have an account ? Log In",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
