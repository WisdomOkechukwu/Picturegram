// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:demo/constant.dart';
import 'package:demo/models/Api_Response.dart';
import 'package:demo/models/User.dart';
import 'package:demo/screens/home.dart';
import 'package:demo/screens/register.dart';
import 'package:demo/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtpassword = TextEditingController();
  bool loading = false;

  void _loginUser() async {
    ApiResponse response = await login(txtEmail.text, txtpassword.text);
    if (response.error == null) {
      _saveAndRedirectToHome(response.data as User);
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text('${response.error}', style: TextStyle(fontFamily: 'Poppins')),
      ));
    }
  }

  void _saveAndRedirectToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => Home()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: formkey,
        child: ListView(
          padding: EdgeInsets.all(32),
          children: [
            TextFormField(
              style: TextStyle(fontFamily: 'Poppins'),
              keyboardType: TextInputType.emailAddress,
              controller: txtEmail,
              validator: (val) => val!.isEmpty ? 'Invalid Email Address' : null,
              decoration: kInputDecoration('Email'),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              style: TextStyle(fontFamily: 'Poppins'),
              controller: txtpassword,
              obscureText: true,
              validator: (val) =>
                  val!.length < 8 ? 'Required at least 8 characters' : null,
              decoration: kInputDecoration('Password'),
            ),
            SizedBox(height: 20),
            loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : kTextButton('Login', () {
                    if (formkey.currentState!.validate()) {
                      setState(() {
                        loading = true;
                        _loginUser();
                      });
                    }
                  }),
            SizedBox(height: 20),
            kLoginRegisterHint("Don't have an account? ", "Register", () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Register()),
                  (route) => false);
            }),
          ],
        ),
      ),
    );
  }
}
