import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:udhar_app/models/udhar_transaction.dart';
import 'package:udhar_app/services/transaction_service.dart';
import 'package:udhar_app/services/user_service.dart';

class RecievedUdharRequests extends StatelessWidget {
  const RecievedUdharRequests({super.key});

  // Future<List<UdharTransaction>> request_list;
  // void getRequests(){
  //    setState(() {
  //     request_list=TransactionService().getUdharRequests(0);
  //   });
  // }

//  Future<String?> getName(String id) async {
//     // Future<String?> s =
//     //     UserService().readValueById("exHunjsIN3gDcxLbB0iBPHJVVyg1");
//     Future<String>? result =
//         await UserService().readValueById(id);
//     return result;
//   }

  // return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('udhar please'),
  //       actions: [
  //         IconButton(
  //           onPressed: () {
  //             getName();
  //             FirebaseAuth.instance.signOut();
  //           },
  //           icon: Icon(
  //             Icons.exit_to_app,
  //             color: Theme.of(context).colorScheme.primary,
  //           ),
  //         ),
  //       ],
  //     ),
  //     body: const Center(
  //       child: UdharRequests(),
  //     ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 88, 55, 173),
      
        body:Center(
      child: StreamBuilder<List<UdharTransaction>>(
        stream: TransactionService().getRecievedUdharRequests(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Container(
      decoration: const BoxDecoration(color: Color.fromARGB(255, 88, 55, 173),),
      child: const Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.warning,
          color: Colors.white,
          size: 32,
        ),
        SizedBox(width: 8), 
        Text(
          'No data Available',
          textDirection: TextDirection.ltr,
          
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ]
      ),
      ),
    );
          
          } else {
            // Render the list of custom objects
            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(6.0,7.0,6.0,15.0),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                // return ListTile(
                //   title: Text(snapshot.data![index].userName),
                //   // Customize ListTile as needed
                // );
                return Card(
                  color: const Color.fromARGB(244, 255, 255, 255),
                  child: ListTile(
                    leading: const Icon(Icons.account_circle_sharp),
                    title: Text(
                        "Request Recieved from ${snapshot.data![index].borrowerName}"),
                    subtitle: Text(snapshot.data![index].status),
                    trailing: Text(snapshot.data![index].amount.toString()),
                  ),
                          
                );
              },
            );
          }
        },
      ),
    ));
    // return MaterialApp(
    //   home: Scaffold(
    //     body: Center(
    //       child: StreamBuilder<List<UdharTransaction>>(
    //         stream: TransactionService().getUdharRequests(),
    //         builder: (context, snapshot) {
    //           if (snapshot.connectionState == ConnectionState.waiting) {
    //             return const CircularProgressIndicator();
    //           } else if (snapshot.hasError) {
    //             return Text('Error: ${snapshot.error}');
    //           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
    //             return const Text('No data available');
    //           } else {
    //             // Render the list of custom objects
    //             return ListView.builder(
    //               itemCount: snapshot.data!.length,
    //               itemBuilder: (context, index) {
    //                 // return ListTile(
    //                 //   title: Text(snapshot.data![index].userName),
    //                 //   // Customize ListTile as needed
    //                 // );
    //                 return (Card(
    //                   child: Text(snapshot.data![index].userName),
    //                 ));
    //               },
    //             );
    //           }
    //         },
    //       ),
    //     ),
    //   ),
    // );
  }
}
