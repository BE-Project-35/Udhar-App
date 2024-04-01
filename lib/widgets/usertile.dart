// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserTile extends StatelessWidget {
  String username;
  int udharscore;
  String url;
  String userid;
  final Function(String, String) openForm;

  UserTile({
    super.key,
    required this.username,
    required this.udharscore,
    required this.url,
    required this.openForm,
    required this.userid,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: BoxDecoration(
              border:
                  Border(right: BorderSide(width: 1.0, color: Colors.white24)),
            ),
            // child: Icon(Icons.autorenew, color: Colors.white),
            child: ClipOval(
              child: Image.network(
                url,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return CircularProgressIndicator(); // Placeholder while loading
                },
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error); // Placeholder for error
                },
              ),
            ),
          ),
          title: Text(
            username,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

          subtitle: Row(
            children: <Widget>[
              Icon(Icons.linear_scale, color: Colors.yellowAccent),
              Text(udharscore.toString(), style: TextStyle(color: Colors.white))
            ],
          ),
          trailing: IconButton(
            icon: Icon(Icons.add_outlined),
            onPressed: () => openForm(userid, username),
          ),
        ),
      ),
    );
  }
}
