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
  int points = 0;
  List<int> boughtPrivilegesIds = [];
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
      points = Provider.of<AuthorizationProvider>(context, listen: false)
          .user
          .points;
      isVisibleLoading = false;
    });
  }

  Widget build(BuildContext context) {
    var privilegesProvider =
        Provider.of<PrivilegesProvider>(context, listen: false);
    var userPrivilegesProvider =
        Provider.of<UserPrivilegesProvider>(context, listen: false);
    var authorizationProvider =
        Provider.of<AuthorizationProvider>(context, listen: false);
    boughtPrivilegesIds = areAlreadyBought(
        userPrivilegesProvider.userPrivileges, privilegesProvider.privileges);

    List<Privilege> privilegeList = privilegesProvider.privileges;
    List<UserPrivilege> userPrivilegeList =
        userPrivilegesProvider.userPrivileges;
    int points = authorizationProvider.user.points;
    return isVisibleLoading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: miceDarkGreen,
              centerTitle: true,
              title: Text('You have $points points left'),
            ),
            backgroundColor: miceLightGreen,
            body: SafeArea(
              minimum: EdgeInsets.all(25),
              child: Container(
                width: 400,
                padding: EdgeInsets.all(10),
                child: ListView.builder(
                  itemCount: privilegeList.length,
                  padding: EdgeInsets.all(10),
                  itemBuilder: (BuildContext context, int index) => Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          bool wasPurchaseSuccessful =
                              await userPrivilegesProvider.purchasePrivilege(
                                  authorizationProvider.user.bearerToken,
                                  privilegeList.elementAt(index).id,
                                  privilegeList.elementAt(index).duration);
                          if (wasPurchaseSuccessful) {
                            userPrivilegeList =
                                await userPrivilegesProvider.getUserPrivileges(
                                    authorizationProvider.user.bearerToken);
                            authorizationProvider.updateOnlyPoints(
                                points - privilegeList.elementAt(index).price);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: miceDarkGreen,
                              content: Text('Purchase successful'),
                            ));
                            setState(() {
                              points = authorizationProvider.getUpdatedPoints();
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: miceDarkGreen,
                              content: Text('Purchase unsuccessful'),
                            ));
                          }
                        },
                        splashColor: Colors.blue,
                        child: Card(
                          color:
                              points >= privilegeList.elementAt(index).price ||
                                      boughtPrivilegesIds.contains(
                                          privilegeList.elementAt(index).id)
                                  ? Colors.white
                                  : Colors.grey[300],
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: miceDarkGreen,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                            focusColor: miceLightGreen,
                            leading: boughtPrivilegesIds
                                    .contains(privilegeList.elementAt(index).id)
                                ? Icon(Icons.add_task, color: miceDarkGreen)
                                : (points >=
                                        privilegeList.elementAt(index).price
                                    ? Icon(Icons.add, color: Colors.black)
                                    : Icon(Icons.block_rounded,
                                        color: Colors.black)),
                            // leading: points >=
                            //         privilegeList.elementAt(index).price
                            //     ? (boughtPrivilegesIds.contains(
                            //             privilegeList.elementAt(index).id)
                            //         ? Icon(Icons.add_task, color: miceDarkGreen)
                            //         : Icon(
                            //             Icons.add,
                            //             color: Colors.black,
                            //           ))
                            //     : Icon(
                            //         Icons.block_rounded,
                            //         color: Colors.black,
                            //       ),
                            title: Text(privilegeList.elementAt(index).title),
                            subtitle:
                                Text('${privilegeList.elementAt(index).price}'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}

List<int> areAlreadyBought(
    List<UserPrivilege> userPrivileges, List<Privilege> privileges) {
  List<int> returnList = [];
  List<int> ids = [];
  for (Privilege privilege in privileges) {
    ids.add(privilege.id);
  }
  for (UserPrivilege userPrivilege in userPrivileges) {
    if (ids.contains(userPrivilege.id)) {
      returnList.add(userPrivilege.id);
    }
  }
  return returnList;
}
