// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:demo/constant.dart';
import 'package:demo/models/Api_Response.dart';
import 'package:demo/models/User.dart';
import 'package:demo/screens/home.dart';
import 'package:demo/screens/login.dart';
import 'package:demo/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool loading = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  void _registerUser() async {
    ApiResponse response = await register(
        nameController.text, emailController.text, passwordController.text);
    if (response.error == null) {
      _saveandRedirectHome(response.data as User);
    } else {
      setState(() {
        loading = !loading;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${response.error}',
              style: TextStyle(fontFamily: 'Poppins'))));
    }
  }

  void _saveandRedirectHome(User user) async {
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
        title: Text('Register', style: TextStyle(fontFamily: 'Poppins')),
        centerTitle: true,
      ),
      body: Form(
        key: formkey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
          children: [
            TextFormField(
              style: TextStyle(fontFamily: 'Poppins'),
              controller: nameController,
              validator: (val) => val!.isEmpty ? 'Invalid Name' : null,
              decoration: kInputDecoration('Name'),
            ),
            SizedBox(height: 20),
            TextFormField(
              style: TextStyle(fontFamily: 'Poppins'),
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (val) => val!.isEmpty ? 'Invalid Email Address' : null,
              decoration: kInputDecoration('Email'),
            ),
            SizedBox(height: 20),
            TextFormField(
              style: TextStyle(fontFamily: 'Poppins'),
              controller: passwordController,
              obscureText: true,
              validator: (val) =>
                  val!.length < 8 ? 'Required at least 8 Characters' : null,
              decoration: kInputDecoration('Password'),
            ),
            SizedBox(height: 20),
            TextFormField(
              style: TextStyle(fontFamily: 'Poppins'),
              controller: passwordConfirmController,
              obscureText: true,
              validator: (val) => val != passwordController.text
                  ? 'Confirm password does not match'
                  : null,
              decoration: kInputDecoration('Confirm Password'),
            ),
            SizedBox(height: 20),
            loading
                ? Center(child: CircularProgressIndicator())
                : kTextButton('Register', () {
                    if (formkey.currentState!.validate()) {
                      setState(() {
                        loading = !loading;
                        _registerUser();
                      });
                    }
                  }),
            SizedBox(height: 20),
            kLoginRegisterHint("Already Have an Account?", ' Login', () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Login()),
                  (route) => false);
            }),
          ],
        ),
      ),
    );
  }
}
