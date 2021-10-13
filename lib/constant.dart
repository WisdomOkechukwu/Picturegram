// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

const baseURl = 'https://flutterapix.herokuapp.com/api';
// const baseURl = 'http://192.168.87.111:8000/api';
const loginURL = baseURl + '/login';
const registerURL = baseURl + '/register';
const logoutURL = baseURl + '/logout';
const userURL = baseURl + '/user';
const postsURL = baseURl + '/posts';
const commentsURL = baseURl + '/comments';

const serverError = 'Server error';
const unauthorized = 'unauthorized';
const somethingWentWrong = 'Something went wrong try again!';

InputDecoration kInputDecoration(String label) {
  return InputDecoration(
    floatingLabelStyle: TextStyle(fontFamily: "Poppins"),
    labelStyle: TextStyle(fontFamily: "Poppins"),
    labelText: label,
    contentPadding: EdgeInsets.all(10),
    border: OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: Colors.black),
    ),
  );
}

TextButton kTextButton(String label, Function onPressed) {
  return TextButton(
    child: Text(
      label,
      style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
    ),
    style: ButtonStyle(
        backgroundColor:
            MaterialStateColor.resolveWith((states) => Colors.blue),
        padding: MaterialStateProperty.resolveWith(
            (states) => EdgeInsets.symmetric(vertical: 10))),
    onPressed: () => onPressed(),
  );
}

Row kLoginRegisterHint(String text, String label, Function ontap) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(text, style: TextStyle(fontFamily: 'Poppins')),
      GestureDetector(
        child: Text(
          label,
          style: TextStyle(fontFamily: "Poppins", color: Colors.blue),
        ),
        onTap: () => ontap(),
      ),
    ],
  );
}

Expanded kLikeandComment(
    int value, IconData icon, Color color, Function onTap) {
  return Expanded(
    child: Material(
      child: InkWell(
        onTap: () => onTap(),
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 16,
                  color: color,
                ),
                SizedBox(width: 4),
                Text('$value', style: TextStyle(fontFamily: 'Poppins')),
              ],
            )),
      ),
    ),
  );
}
