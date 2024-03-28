import 'package:flutter/material.dart';
import 'package:udhar_app/models/user.dart';
import 'package:udhar_app/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  void requestUdhar() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('udhar please'),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<UdharUser>>(
        future: userList,
        builder: (context, snapshot) {
          List<Widget> children = [];
          if (snapshot.hasData) {
            for (var element in snapshot.data!) {
              Widget listElement = ListTile(
                title: Text(element.email),
                subtitle: Text(element.udharScore.toString()),
                onTap: () => showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: 600,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Text('Modal BottomSheet'),
                            ElevatedButton(
                              child: const Text('Close BottomSheet'),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
              children.add(listElement);
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
              // mainAxisAlignment: MainAxisAlignment.center,
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