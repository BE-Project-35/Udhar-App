import 'package:flutter/material.dart';
import 'package:udhar_app/models/user.dart';
import 'package:udhar_app/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:udhar_app/widgets/requestform.dart';
import 'package:udhar_app/widgets/usertile.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  late Future<List<UdharUser>> userList;

  @override
  void initState() {
    super.initState();
    fetchUserlist();
  }

  void fetchUserlist() {
    Future<List<UdharUser>> ls = UserService().getUdharUsers();
    print(ls);
    setState(() {
      userList = ls;
    });
  }

  void openForm(String lenderID, String lenderName) {
    print("called");
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return RequestForm(lenderID: lenderID, lenderName: lenderName);
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   mainAxisSize: MainAxisSize.min,
        //   children: <Widget>[
        //     RequestForm(lenderID: lenderID, lenderName: lenderName),
        //   ],
        // ),
      },
    );
  }

  void requestUdhar() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
      body: FutureBuilder<List<UdharUser>>(
        future: userList,
        builder: (context, snapshot) {
          List<Widget> children = [];
          if (snapshot.hasData) {
            for (var element in snapshot.data!) {
              children.add(UserTile(
                  userid: element.uid,
                  username: element.email,
                  udharscore: element.udharScore,
                  url: element.imageURL,
                  openForm: openForm));
            }
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              ),
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              ),
            ];
          }

          return Center(
            child: Column(
              children: children,
            ),
          );
        },
      ),
    );
  }
}




// ListView.builder(
//         itemCount: userList.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(userList[index].email),
//             subtitle: Text(userList[index].udharScore.toString()),
//             // Customize the ListTile as needed
//           );
//         },
//       ),




