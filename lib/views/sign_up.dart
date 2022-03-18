import 'package:flutter/material.dart';
import 'package:biker_mice_from_mars/shared/validators.dart';
import '../services/authorization.dart';
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
            body: Form(
            key: _formKey,
            child: SafeArea(
              minimum: EdgeInsets.all(20),
              child: Column(
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
                    decoration: InputDecoration(
                      hintText: 'Password confirmation',
                    ),
                    onChanged: (value) {
                      setState(() {
                        passwordConfirmation = value;
                      });
                    },
                  ),
                  ElevatedButton(
                      onPressed: () => _signUpButton(), child: Text('Sign up')),
                  ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, '/sign_in'),
                      child: Text('Log in')),
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
