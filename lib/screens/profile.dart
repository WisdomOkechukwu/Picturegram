// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'dart:io';

import 'package:demo/constant.dart';
import 'package:demo/models/Api_Response.dart';
import 'package:demo/models/User.dart';
import 'package:demo/screens/login.dart';
import 'package:demo/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  User? user;
  bool _loading = true;
  File? _imageFile;
  final _picker = ImagePicker();
  TextEditingController _nameControllertxt = TextEditingController();

  Future getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _getUser() async {
    ApiResponse response = await getUserDetail();
    if (response.error == null) {
      setState(() {
        user = response.data as User;
        _loading = false;
        _nameControllertxt.text = user!.name ?? '';
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Login()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text('${response.error}', style: TextStyle(fontFamily: 'Poppins')),
      ));
    }
  }

  //?Update Profile
  void _updateProfile() async {
    ApiResponse response =
        await updateUser(_nameControllertxt.text, getStringImage(_imageFile));
    setState(() {
      _loading = false;
    });

    if (response.error == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        '${response.data}',
        style: TextStyle(fontFamily: 'Poppins'),
      )));
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Login()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text('${response.error}', style: TextStyle(fontFamily: 'Poppins')),
      ));
    }
  }

  @override
  void initState() {
    _getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: EdgeInsets.only(top: 40, left: 40, right: 40),
            child: ListView(
              children: [
                Center(
                  child: GestureDetector(
                    child: Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        image: _imageFile == null
                            ? user!.image != null
                                ? DecorationImage(
                                    image: NetworkImage('${user!.image}'),
                                    fit: BoxFit.cover,
                                  )
                                : null
                            : DecorationImage(
                                image: FileImage(_imageFile ?? File('')),
                                fit: BoxFit.cover,
                              ),
                        color: Colors.amber,
                      ),
                    ),
                    onTap: () {
                      getImage();
                    },
                  ),
                ),
                SizedBox(height: 20),
                Form(
                  key: formkey,
                  child: TextFormField(
                      decoration: kInputDecoration('Name'),
                      controller: _nameControllertxt,
                      validator: (val) =>
                          val!.isEmpty ? 'Invalid Names' : null),
                ),
                SizedBox(height: 20),
                kTextButton("UPDATE", () {
                  if (formkey.currentState!.validate()) {
                    setState(() {
                      _loading = true;
                    });
                    _updateProfile();
                  }
                }),
              ],
            ),
          );
  }
}
