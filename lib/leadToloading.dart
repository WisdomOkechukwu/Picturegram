// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, file_names

import 'package:demo/screens/Loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

main() => runApp(LeadToLoading());

class LeadToLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Loading(),
    );
  }
}
