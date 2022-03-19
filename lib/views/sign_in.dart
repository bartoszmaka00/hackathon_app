import 'package:biker_mice_from_mars/services/authorization.dart';
import 'package:biker_mice_from_mars/shared/constans.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:biker_mice_from_mars/shared/validators.dart';
import 'loading_screen.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  bool isVisibleError = false;
  bool isVisibleLoading = false;

  @override
  Widget build(BuildContext context) {
    return isVisibleLoading
        ? Loading()
        : Scaffold(
            backgroundColor: miceLightGreen,
            body: Form(
            key: _formKey,
            child: SafeArea(
              minimum: EdgeInsets.all(25),
              child: Container(
                margin: EdgeInsets.fromLTRB(10.0, 200.0, 10.0, 200.0),
                padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20)
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      validator: (value) {
                        return emailValidator(value, 'Please enter your email');
                      },
                      decoration: InputDecoration(
                        hintText: 'Email',
                      ),
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      validator: (value) {
                        return passwordValidator(value, 6);
                      },
                      decoration: InputDecoration(
                        hintText: 'Password',
                      ),
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(
                                  color: miceLightGreen,
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                          onPressed: () => _signInButton(),
                          child: Text('Log In')),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(
                                  color: miceLightGreen,
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                          onPressed: () => Navigator.pushNamed(context, '/sign_up'),
                          child: Text('Sign up')),
                    ),
                    Visibility(
                      child: Text(
                        error,
                        style: TextStyle(color: Colors.red),
                      ),
                      visible: isVisibleError,
                    ),

                  ],
                ),
              ),
            ),
          ));
  }

  void _signInButton() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isVisibleError = false;
        isVisibleLoading = true;
      });
      final provider =
          Provider.of<AuthorizationProvider>(context, listen: false);
      await provider.loginUser(email, password);
      if (provider.isAuthorized == Status.unauthorized) {
        setState(() {
          error = 'Couldn\'t sign in with those credentials';
          isVisibleError = true;
          isVisibleLoading = false;
        });
      } else {
        setState(() {
          isVisibleError = false;
          isVisibleLoading = false;
        });
        Navigator.pushNamed(context, '/menu');
      }
    } else {
      setState(() {
        error = 'Invalid credentials';
        isVisibleError = true;
        isVisibleLoading = false;
      });
    }
  }
}
