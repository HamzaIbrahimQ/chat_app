import 'package:flutter/material.dart';
import 'package:max_chat_app/widgets/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';



class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(String email, String password, String userName, File image, bool isLogin) async {

    UserCredential userCredential;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      }
      else {
        userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      }
      final ref = FirebaseStorage.instance
          .ref()
          .child('userImages')
          .child(userCredential.user.email + '.jpg');
      await ref.putFile(image).whenComplete(() => null);
      final url = await ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('users').doc(userCredential.user.uid).set({
        'userName' : userName,
        'email' : email,
        'imageUrl': url,
      });
    }


    on FirebaseAuthException catch (e) {
      var message = 'An error occured, please check your input';
      if (e.message != null) {
        message = e.message.toString();
      }
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message.toString()), backgroundColor: Theme.of(context).errorColor,));
      setState(() {
        _isLoading = false;
      });
    }
    catch (e) {
      print('errrrroooorrrrrrrrr' + e.toString());
      setState(() {
        _isLoading = false;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm, _isLoading),
    );
  }
}
