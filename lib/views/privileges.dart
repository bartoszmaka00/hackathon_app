import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:biker_mice_from_mars/services/privileges_provider.dart';
import 'package:biker_mice_from_mars/services/authorization.dart';
import 'package:biker_mice_from_mars/models/privilege.dart';

import '../models/user_privilege.dart';
import 'loading_screen.dart';
import 'package:biker_mice_from_mars/shared/constans.dart';
import 'package:biker_mice_from_mars/services/user_privileges_provider.dart';

class Privileges extends StatefulWidget {
  const Privileges({Key? key}) : super(key: key);

  @override
  State<Privileges> createState() => _PrivilegesState();
}

class _PrivilegesState extends State<Privileges> {
  bool isVisibleLoading = false;
  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<Null> _load() async {
    setState(() {
      isVisibleLoading = true;
    });
    await Provider.of<PrivilegesProvider>(context, listen: false).getPrivileges(
        Provider.of<AuthorizationProvider>(context, listen: false)
            .user
            .bearerToken);
    await Provider.of<UserPrivilegesProvider>(context, listen: false)
        .getUserPrivileges(
            Provider.of<AuthorizationProvider>(context, listen: false)
                .user
                .bearerToken);
    setState(() {
      isVisibleLoading = false;
    });
  }

  Widget build(BuildContext context) {
    var privilegesProvider =
        Provider.of<PrivilegesProvider>(context, listen: false);
    var userPrivilegesProvider =
        Provider.of<UserPrivilegesProvider>(context, listen: false);
    List<Privilege> privilegeList = privilegesProvider.privileges;
    List<UserPrivilege> userPrivilegeList =
        userPrivilegesProvider.userPrivileges;
    return isVisibleLoading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: miceDarkGreen,
              centerTitle: true,
              title: Text('Privileges'),
            ),
            backgroundColor: miceLightGreen,
            body: SafeArea(
              minimum: EdgeInsets.all(25),
              child: Container(
                width: 400,
                padding: EdgeInsets.all(10),
                child: ListView(
                  padding: EdgeInsets.all(10),
                  children: [
                    for (Privilege privilege in privilegeList)
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              print(userPrivilegeList);
                            },
                            splashColor: Colors.blue,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: miceDarkGreen,
                                ),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: ListTile(
                                focusColor: miceLightGreen,
                                leading: Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                                title: Text('${privilege.title}'),
                                subtitle: Text('Price: ${privilege.price}'),
                              ),
                            ),
                          ),
                        ],
                      )
                  ],
                ),
              ),
            ),
          );
  }
}
