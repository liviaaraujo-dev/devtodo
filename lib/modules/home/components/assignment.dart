import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devtodo/modules/home/home_page.dart';
import 'package:devtodo/modules/splash/splash_page.dart';
import 'package:devtodo/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class Assignment extends StatefulWidget {
  final String idUser;
  final String title;
  final String idTask;
  final VoidCallback initA;
  final String email;
  final String name;
  final String imgUrl;
  final VoidCallback limparLista;
  const Assignment(
      {super.key,
      required this.idUser,
      required this.title,
      required this.idTask,
      required this.initA,
      required this.limparLista,
      required this.email,
      required this.name,
      required this.imgUrl});

  @override
  State<Assignment> createState() => _AssignmentState();
}

class _AssignmentState extends State<Assignment> {
  bool isChecked = false;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController _task = new TextEditingController();
  bool deletar = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              checkColor: Colors.white,
              value: isChecked,
              activeColor: AppColors.laranja,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value!;
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
              Icons.create_rounded,
              color: Colors.black,
              size: 26,
            )),
            SizedBox(
              width: 15,
            ),
            GestureDetector(
              child: Icon(
                Icons.delete,
                size: 26,
              ),
              onTap: () async {
                await showDialog(
                    context: context,
                    builder: (BuildContext conttext) {
                      return Dialog(
                        child: Container(
                          //height: screenHeight * .3,
                          child: Column(
                            children: [
                              Text(
                                "Excluir Tarefa?",
                                style: Theme.of(context).textTheme.headline3,
                              ),
                              TextField(
                                controller: _task,
                              ),
                              Row(
                                children: [
                                  ElevatedButton(
                                      onPressed: () async {
                                        setState(() {
                                          deletar = true;
                                        });
                                      },
                                      child: Text("Sim")),
                                  ElevatedButton(
                                      onPressed: () async {},
                                      child: Text("Não"))
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    });

                if (deletar) {
                  await firestore
                      .collection("users/${widget.idUser}/tasks")
                      .doc(widget.idTask)
                      .delete()
                      .then(
                        (doc) => print("Document deleted"),
                        onError: (e) => print("Error updating document $e"),
                      );
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => SplashPage()));
                  // widget.limparLista();
                  // widget.initA();
                  // setState(() {});
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
