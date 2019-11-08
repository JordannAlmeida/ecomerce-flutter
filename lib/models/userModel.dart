import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {

  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser firebaseUser;

  Map<String, dynamic> userData = Map();

  bool isLoading = false;

  @override
  void addListener(VoidCallback listener){
    super.addListener(listener);

    _collectUserData();
  }

  void singUp ({@required Map<String, dynamic> userData, @required String pass, @required VoidCallback onSuccess, @required VoidCallback onFail}) {
      isLoading = true;
      notifyListeners();

      _auth.createUserWithEmailAndPassword(email: userData["email"], password: pass)
      .then((user) async {
        firebaseUser = user;
        this.userData = userData;
        await _saveUserData(userData);
        isLoading = false;
        notifyListeners();
        onSuccess();
      }).catchError((onError) {
        onFail();
        isLoading = false;
        notifyListeners();
      });
  }

  void singIn({@required String email, @required String pass, @required VoidCallback onSuccess, VoidCallback onFail}) {
    isLoading = true;
    notifyListeners();

    _auth.signInWithEmailAndPassword(email: email, password: pass).then((user) async {
      firebaseUser = user;
      isLoading = false;
      await _collectUserData();
      notifyListeners();
      onSuccess();
    }).catchError((error) {
      isLoading = false;
      notifyListeners();
      onFail();
    });
  }

  void recoverPass(String email) {
    _auth.sendPasswordResetEmail(email: email);
  }

  bool isLoggedin () {
    return firebaseUser != null;
  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await Firestore.instance.collection("users").document(firebaseUser.uid).setData(userData);
  }

  void singOut() async{
    await _auth.signOut();
    
    userData = Map();
    firebaseUser = null;

    notifyListeners();
  }

  Future<Null> _collectUserData() async{
    if(firebaseUser == null) {
      firebaseUser = await _auth.currentUser();
    }
    if(firebaseUser != null) {
      if(userData["name"] == null) {
        DocumentSnapshot docUser = await Firestore.instance.collection("users").document(firebaseUser.uid).get();
        userData = docUser.data;
      }
      notifyListeners();
    }
  }

  
}