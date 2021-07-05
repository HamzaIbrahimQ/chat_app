import 'package:flutter/material.dart';



class AuthForm extends StatefulWidget {

  AuthForm(this.submitFn, this.isLoading);

  final bool isLoading;
  final void Function(String email, String password, String userName, bool isLogin) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {

  final _formKey = GlobalKey<FormState>();

  var _isLogin = true;

  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';

  void _trySubmit() {
    final isvalid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isvalid) {
      _formKey.currentState.save();
      print('user data issssssssssssss:');
      print(_userEmail);
      print(_userName);
      print(_userPassword);
      widget.submitFn(_userEmail.trim(), _userPassword.trim(), _userName.trim(), _isLogin);
    }
    else {
      print('nooooooooooooooooooooooooooooot valiiiiiiidddddddd');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    key: ValueKey('email'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'email address',
                    ),
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'not valid email address';
                      }
                      else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      _userEmail = value;
                    },
                  ),
                  if(!_isLogin) TextFormField(
                    key: ValueKey('name'),
                    decoration: InputDecoration(
                      labelText: 'user name',
                    ),
                    validator: (value) {
                      if (value.isEmpty || value.length < 4) {
                        return 'too short!';
                      }
                      else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      _userName = value;
                    },
                  ),
                  TextFormField(
                    key: ValueKey('password'),
                    decoration: InputDecoration(
                      labelText: 'password',
                    ),
                    obscureText: true,
                    obscuringCharacter: '*',
                    validator: (value) {
                      if (value.isEmpty || value.length < 6) {
                        return 'too short!';
                      }
                      else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      _userPassword = value;
                    },
                  ),
                  SizedBox(height: 12,),
                  widget.isLoading ? CircularProgressIndicator() : ElevatedButton(
                    child: Text(_isLogin ? 'Login' : 'Signup'),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),),
                    ),
                    onPressed: _trySubmit,
                  ),
                  if(!widget.isLoading) TextButton(
                    child: Text(_isLogin ? 'Create new account' : 'Already have an account?'),
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
