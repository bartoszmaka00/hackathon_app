import 'package:flutter/material.dart';

class Privileges extends StatefulWidget {
  const Privileges({Key? key}) : super(key: key);

  @override
  State<Privileges> createState() => _PrivilegesState();
}

class _PrivilegesState extends State<Privileges> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Privileges view'),
    );
  }
}
