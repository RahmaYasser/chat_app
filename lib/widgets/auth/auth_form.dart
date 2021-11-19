import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AuthForm extends StatefulWidget {
  //const AuthForm({Key? key}) : super(key: key);
  AuthForm(this.submitFn,this.isLoading);
  final void Function(String email,String username,String password,bool isLogin) submitFn;
  bool isLoading;
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  var _isLogin = true;
  var _username = '';
  var _password = '';
  var _email = '';

  final _formKey = GlobalKey<FormState>();

  void _trySubmit() {
    var formKeyCurrentState = _formKey.currentState;
    final isValid;
    formKeyCurrentState!=null? isValid = formKeyCurrentState.validate():isValid=false;
    FocusScope.of(context).unfocus();
    if (isValid) {
      if (formKeyCurrentState!=null) formKeyCurrentState.save();
      widget.submitFn(_email,_username,_password,_isLogin);
      print(_email);
      print(_username);
      print(_password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    key: const ValueKey('email'),
                    onSaved: (value) {
                      if(value!=null) _email=value;
                    },
                    validator: (value) {
                      var isEmpty;
                      var notContainsAt;
                      if(value != null){
                        print(isEmpty);
                        isEmpty = value.isEmpty;
                         notContainsAt = !value.contains('@');
                      } else{
                        print("validator not working");
                      }
                      if (isEmpty || notContainsAt) {
                        return 'Please enter valid email';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration:
                        const InputDecoration(labelText: 'Email address'),
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: const ValueKey('username'),
                      onSaved: (value) {
                        if (value!=null){
                          _username = value;
                        }
                      },
                      validator: (value) {
                        var isEmpty;
                        var lessThanFour;
                        if(value != null){
                          isEmpty = value.isEmpty;
                          print(isEmpty);
                          lessThanFour = value.length<4?lessThanFour = true:lessThanFour=false;
                        }
                        if (isEmpty || lessThanFour) {
                          return 'Username should be more 4 or more characters';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(labelText: 'Username'),
                    ),
                  TextFormField(
                    key: const ValueKey('password'),
                    validator: (value) {
                      var isEmpty;
                      var lessThanEight;
                      if(value != null){
                        isEmpty = value.isEmpty;
                        print(isEmpty);
                        lessThanEight = value.length<8?lessThanEight = true:lessThanEight=false;
                      }
                      if (isEmpty || lessThanEight) {
                        return 'Password should be at least 8 characters';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    onSaved: (value) {
                      if(value!=null) _password = value;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ElevatedButton(
                      child: Text(_isLogin ? 'Login' : 'Signup'),
                      onPressed: _trySubmit),
                  TextButton(
                    child: Text(_isLogin
                        ? 'Create new account'
                        : 'already have account'),
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
