import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devtodo/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class Assignment extends StatefulWidget {
  final String idUser;
  final String title;
  const Assignment({super.key, required this.idUser, required this.title});

  @override
  State<Assignment> createState() => _AssignmentState();
}

class _AssignmentState extends State<Assignment> {
  bool isChecked = false;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

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
                onTap: () async {
                  QuerySnapshot query = await firestore
                      .collection("users/${widget.idUser}/")
                      .get();
                  print(query);
                },
                child: Icon(
                  Icons.delete,
                  size: 26,
                )),
          ],
        ),
      ],
    );
  }
}
