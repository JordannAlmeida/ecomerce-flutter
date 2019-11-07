import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {

  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser firebaseUser;

  Map<String, dynamic> userData = Map();

  bool isLoading = false;

  void singUp ({@required Map<String, dynamic> userData, @required String pass, @required VoidCallback onSucces, @required VoidCallback onFail}) {
      isLoading = true;
      notifyListeners();

      _auth.createUserWithEmailAndPassword(email: userData["email"], password: pass)
      .then((user) async {
        firebaseUser = user;

        await _saveUserData(userData);

        onSucces();
        isLoading = false;
        notifyListeners();
      }).catchError((onError) {
        onFail();
        isLoading = false;
        notifyListeners();
      });
  }

  void singIn() {

  }

  void recoverPass() {

  }

  bool isLoggedin () {

  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await Firestore.instance.collection("users").document(firebaseUser.uid).setData(userData);
  }
}