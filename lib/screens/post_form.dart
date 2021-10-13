// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'dart:io';

import 'package:demo/constant.dart';
import 'package:demo/models/Api_Response.dart';
import 'package:demo/models/post.dart';
import 'package:demo/screens/login.dart';
import 'package:demo/services/post_services.dart';
import 'package:demo/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PostForm extends StatefulWidget {
  final Post? post;
  final String? title;

  PostForm({
    this.post,
    this.title,
  });
  @override
  _PostFormState createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _bodyControllerTxt = TextEditingController();
  bool _loading = false;
  File? _imagFile;
  final _picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagFile = File(pickedFile.path);
      });
    }
  }

  void _createPost() async {
    String? image = _imagFile == null ? null : getStringImage(_imagFile);
    ApiResponse response = await createPost(_bodyControllerTxt.text, image);

    if (response.error == null) {
      Navigator.of(context).pop();
    } else if (response.data == unauthorized) {
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

      setState(() {
        _loading = !_loading;
      });
    }
  }

  void _editPost(int postId) async {
    ApiResponse response = await editPost(postId, _bodyControllerTxt.text);
    if (response.error == null) {
      Navigator.of(context).pop();
    } else if (response.data == unauthorized) {
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

      setState(() {
        _loading = !_loading;
      });
    }
  }

  @override
  void initState() {
    if (widget.post != null) {
      _bodyControllerTxt.text = widget.post!.body ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '${widget.title}',
          style: TextStyle(fontFamily: "Poppins"),
        ),
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                widget.post != null
                    ? SizedBox()
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        decoration: BoxDecoration(
                          image: _imagFile == null
                              ? null
                              : DecorationImage(
                                  image: FileImage(_imagFile ?? File('')),
                                  fit: BoxFit.cover),
                        ),
                        child: Center(
                          child: IconButton(
                            icon: Icon(
                              Icons.image,
                              size: 50,
                              color: Colors.black38,
                            ),
                            onPressed: () {
                              getImage();
                            },
                          ),
                        ),
                      ),
                Form(
                  key: _formkey,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: TextFormField(
                      style: TextStyle(fontFamily: 'Poppins'),
                      controller: _bodyControllerTxt,
                      keyboardType: TextInputType.multiline,
                      maxLines: 9,
                      validator: (val) =>
                          val!.isEmpty ? "Post body is reqiured" : null,
                      decoration: InputDecoration(
                        hintText: 'Post Body',
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.blue)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: kTextButton("Post", () {
                    if (_formkey.currentState!.validate()) {
                      setState(() {
                        _loading = !_loading;
                      });
                      if (widget.post == null) {
                        _createPost();
                      } else {
                        _editPost(widget.post!.id ?? 0);
                      }
                    }
                  }),
                )
              ],
            ),
    );
  }
}
