import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:udhar_app/models/udhar_transaction.dart';
import 'package:udhar_app/services/transaction_service.dart';
import 'package:udhar_app/widgets/transactiontile.dart';
import 'package:udhar_app/services/user_service.dart';

class SentUdharRequests extends StatelessWidget {
  const SentUdharRequests({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        body: Center(
          child: StreamBuilder<List<UdharTransaction>>(
            stream: TransactionService().getSentUdharRequests(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(58, 66, 86, 1.0),
                  ),
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
                        ]),
                  ),
                );
              } else {
                // Render the list of custom objects
                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(6.0, 7.0, 6.0, 15.0),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    // return Card(
                    //   child: ListTile(
                    //     title: Text(
                    //         "Udhaar Request sent to ${snapshot.data![index].lenderName}"),
                    //         leading: const Icon(Icons.account_circle_sharp),
                    //     subtitle: Text(snapshot.data![index].status),
                    //     trailing: Text(snapshot.data![index].amount.toString()),
                    //   ),
                    // );
                    return TransactionTile(
                        name: snapshot.data![index].lenderName,
                        status: snapshot.data![index].status,
                        amount: snapshot.data![index].amount,
                        message: "requested from");
                  },
                );
              }
            },
          ),
        ));
  }
}
