import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devtodo/modules/home/home_page.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';

class AuthController {
  UserModel? _user;

  UserModel get user => _user!;

  Future<void> setUser(BuildContext context, UserModel? user) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    if (user != null) {
      saveUser(user);
      _user = await user;
      //Navigator.pushReplacementNamed(context, "/home", arguments: user);
      await firestore.collection("users").doc(user.id).set({
        "name": user.name,
        "email": user.email,
        "photoUrl": user.photoURL,
        "id": user.id,
      });

      FirebaseFirestore.instance
          .collection('users')
          .doc(user.id)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          print('Document data: ${documentSnapshot.data()}');
        } else {
          print('Document does not exist on the database');
        }
      });

      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomePage(
                email: user.email,
                name: user.name,
                idUser: user.id,
                imgUrl: user.photoURL.toString(),
              )));
    } else {
      //Navigator.pushReplacementNamed(context, "/login");
    }
  }

  Future<void> saveUser(UserModel user) async {}

  Future<void> currentUser(BuildContext context) async {}
}
