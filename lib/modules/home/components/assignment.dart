import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devtodo/modules/home/home_page.dart';
import 'package:devtodo/modules/splash/splash_page.dart';
import 'package:devtodo/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Assignment extends StatefulWidget {
  final String idUser;
  final String title;
  final String idTask;
  final String email;
  final bool complete;
  final String name;
  final String imgUrl;
  const Assignment(
      {super.key,
      required this.idUser,
      required this.title,
      required this.idTask,
      required this.email,
      required this.name,
      required this.imgUrl,
      required this.complete});

  @override
  State<Assignment> createState() => _AssignmentState();
}

class _AssignmentState extends State<Assignment> {
  bool isChecked = false;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController _task = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      isChecked = widget.complete;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar();
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - appBar.preferredSize.height) -
        MediaQuery.of(context).padding.top;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              checkColor: Colors.white,
              value: isChecked,
              activeColor: AppColors.laranja,
              onChanged: (bool? value) async {
                setState(() {
                  isChecked = value!;
                });
                await firestore
                    .collection("users/${widget.idUser}/tasks")
                    .doc(widget.idTask)
                    .set({
                  "title": widget.title,
                  "complete": isChecked,
                  "id": widget.idTask
                });
              },
            ),
            Text(
              widget.title,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
        Row(
          children: [
            GestureDetector(
              child: Icon(
                Icons.delete,
                size: 26,
                color: Colors.red,
              ),
              onTap: () async {
                await showDialog(
                    context: context,
                    builder: (BuildContext conttext) {
                      return Dialog(
                        child: Container(
                          height: screenHeight * .16,
                          width: size.width * .2,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 15),
                                child: Text(
                                  "Excluir Tarefa?",
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.only(
                                              left: 30, right: 30),
                                          backgroundColor: AppColors.laranja),
                                      onPressed: () async {
                                        await firestore
                                            .collection(
                                                "users/${widget.idUser}/tasks")
                                            .doc(widget.idTask)
                                            .delete()
                                            .then(
                                              (doc) =>
                                                  print("Document deleted"),
                                              onError: (e) => print(
                                                  "Error updating document $e"),
                                            );
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SplashPage()));
                                      },
                                      child: Text(
                                        "SIM",
                                        style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      )),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.only(
                                              left: 30, right: 30),
                                          backgroundColor: AppColors.laranja),
                                      onPressed: () async {
                                        Navigator.pop(context);
                                      },
                                      child: Text("NÃO",
                                          style: GoogleFonts.inter(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500)))
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
            ),
          ],
        ),
      ],
    );
  }
}
