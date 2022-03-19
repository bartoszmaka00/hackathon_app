import 'package:flutter/material.dart';
import 'package:biker_mice_from_mars/shared/validators.dart';
import '../services/authorization.dart';
import '../shared/constans.dart';
import 'loading_screen.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String name = '';
  String passwordConfirmation = '';
  String lastName = '';
  String error = '';
  bool isVisibleError = false;
  bool isVisibleLoading = false;

  @override
  Widget build(BuildContext context) {
    return isVisibleLoading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: miceLightGreen,

            appBar: AppBar(
                toolbarHeight: 90,
              automaticallyImplyLeading: false,
              elevation: 1,
              backgroundColor: miceLightGreen,
              centerTitle: true,
                title: Image(
                  image: AssetImage('assets/logo.png'),
                  width: 110,
                  height: 110,)


            ),
            body: Form(
            key: _formKey,
            child: SafeArea(
              minimum: EdgeInsets.all(20),
              child: Container(
                margin: EdgeInsets.fromLTRB(10.0, 100.0, 10.0, 50.0),
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
                    Text('Registration',
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 30),
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
                        return emailValidator(value, 'Please enter your name');
                      },
                      decoration: InputDecoration(
                        hintText: 'Name',
                      ),
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      validator: (value) {
                        return emailValidator(
                            value, 'Please enter your last name');
                      },
                      decoration: InputDecoration(
                        hintText: 'Last name',
                      ),
                      onChanged: (value) {
                        setState(() {
                          lastName = value;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      validator: (value) {
                        return passwordValidator(value, 6);
                      },
                      obscureText: true,
                      decoration: InputDecoration(

                        hintText: 'Password',
                      ),
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      validator: (value) {
                        return passwordConfirmationValidator(value, password, 6);
                      },
                      obscureText: true,

                      decoration: InputDecoration(
                        hintText: 'Password confirmation',
                      ),
                      onChanged: (value) {
                        setState(() {
                          passwordConfirmation = value;
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
                          onPressed: () => _signUpButton(), child: Text('Sign up')),
                    ),
                    SizedBox(height: 10),

                    Visibility(
                      child: Text(
                        error,
                        style: TextStyle(color: Colors.red),
                      ),
                      visible: isVisibleError,
                    )
                  ],
                ),
              ),
            ),
          ));
  }

  void _signUpButton() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isVisibleError = false;
        isVisibleLoading = true;
      });
      final provider =
          Provider.of<AuthorizationProvider>(context, listen: false);
      await provider.registerUser(
          email, password, passwordConfirmation, name, lastName);
      if (provider.isAuthorized == Status.unauthorized) {
        setState(() {
          error = 'Couldn\'t sign up with those credentials';
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
