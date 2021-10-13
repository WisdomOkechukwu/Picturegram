// ignore_for_file: file_names, prefer_const_constructors

import 'package:demo/constant.dart';
import 'package:demo/models/Api_Response.dart';
import 'package:demo/screens/home.dart';
import 'package:demo/screens/login.dart';
import 'package:demo/services/user_service.dart';
import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void _loadUserInfo() async {
    String token = await getToken();
    if (token == '') {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Login()),
        (route) => false,
      );
    } else {
      ApiResponse response = await getUserDetail();
      if (response.error == null) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Home()),
          (route) => false,
        );
      } else if (response.error == unauthorized) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Login()),
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${response.error}'),
        ));
      }
    }
  }

  @override
  void initState() {
    //todo: implement initstate
    _loadUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
