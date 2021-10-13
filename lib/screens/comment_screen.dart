// ignore_for_file: prefer_const_constructors

import 'package:demo/constant.dart';
import 'package:demo/models/Api_Response.dart';
import 'package:demo/models/Comment.dart';
import 'package:demo/screens/login.dart';
import 'package:demo/services/comment_service.dart';
import 'package:demo/services/user_service.dart';
import 'package:flutter/material.dart';

class CommentScreen extends StatefulWidget {
  final int? postId;

  CommentScreen({
    this.postId,
  });
  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  List<dynamic> _commentsList = [];
  bool _loading = true;
  int userId = 0;
  int _editCommentID = 0;
  TextEditingController _commentControllertxt = TextEditingController();

  Future<void> _getComments() async {
    userId = await getUserId();
    ApiResponse response = await getComments(widget.postId ?? 0);

    if (response.error == null) {
      setState(() {
        _commentsList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
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

  //? create Comment
  void _createComment() async {
    ApiResponse response =
        await createcomment(widget.postId ?? 0, _commentControllertxt.text);

    if (response.error == null) {
      _commentControllertxt.clear();
      _getComments();
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Login()),
                (route) => false)
          });
    } else {
      setState(() {
        _loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text('${response.error}', style: TextStyle(fontFamily: 'Poppins')),
      ));
    }
  }

  //? Delete Comment
  void _deleteComment(int commentId) async {
    ApiResponse response = await deleteComment(commentId);

    if (response.error == null) {
      _getComments();
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

  //?Edit Comment
  void _editComment() async {
    ApiResponse response =
        await editComment(_editCommentID, _commentControllertxt.text);
    if (response.error == null) {
      _editCommentID = 0;
      _commentControllertxt.clear();
      _getComments();
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
    _getComments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Comments',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _getComments,
                    child: ListView.builder(
                        itemCount: _commentsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          Comment comment = _commentsList[index];
                          return Container(
                            padding: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: Colors.black26, width: 0.5),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            image: comment.user!.image != null
                                                ? DecorationImage(
                                                    image: NetworkImage(
                                                        '${comment.user!.image}'),
                                                    fit: BoxFit.cover,
                                                  )
                                                : null,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Colors.blueGrey,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          '${comment.user!.name}',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    comment.user!.id == userId
                                        ? PopupMenuButton(
                                            child: Padding(
                                                padding:
                                                    EdgeInsets.only(right: 10),
                                                child: Icon(
                                                  Icons.more_vert,
                                                  color: Colors.black,
                                                )),
                                            //
                                            itemBuilder: (context) => [
                                              PopupMenuItem(
                                                child: Text(
                                                  'Edit',
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins'),
                                                ),
                                                value: 'edit',
                                              ),
                                              PopupMenuItem(
                                                child: Text(
                                                  'Delete',
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins'),
                                                ),
                                                value: 'delete',
                                              )
                                            ],
                                            onSelected: (val) {
                                              if (val == 'edit') {
                                                setState(() {
                                                  _editCommentID =
                                                      comment.id ?? 0;
                                                  _commentControllertxt.text =
                                                      comment.comment ?? '';
                                                });
                                              } else {
                                                _deleteComment(comment.id ?? 0);
                                              }
                                            },
                                          )
                                        : SizedBox(),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Text('${comment.comment}',
                                    style: TextStyle(fontFamily: 'Poppins')),
                              ],
                            ),
                          );
                        }),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.black26,
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: kInputDecoration('Comment'),
                          controller: _commentControllertxt,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          if (_commentControllertxt.text.isNotEmpty) {
                            setState(() {
                              _loading = true;
                            });
                            if (_editCommentID > 0) {
                              _editComment();
                            } else {
                              _createComment();
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
