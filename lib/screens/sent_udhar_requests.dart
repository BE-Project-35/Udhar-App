// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:udhar_app/models/udhar_transaction.dart';
import 'package:udhar_app/screens/RequestScreen.dart';
import 'package:udhar_app/services/transaction_service.dart';
import 'package:udhar_app/services/user_service.dart';
import 'package:udhar_app/widgets/transactiontile.dart';

class SentUdharRequests extends StatelessWidget {
  const SentUdharRequests({super.key});

  void openRequestScreen(BuildContext context, String transactionid, int amount,
      String borrowerName, String lenderName, String endDate, String status) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => RequestScreen(
                amount: amount,
                transactionid: transactionid,
                borrowername: borrowerName,
                lenderName: lenderName,
                endDate: endDate,
                status: status,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
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
                            'No Udhar requests sent',
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
                return Column(
                  children: [
                    // Container(
                    //   margin: EdgeInsets.only(top: 30, bottom: 20),
                    //   child: Text(
                    //     "UDHAR REQUESTS SENT",
                    //     style: TextStyle(
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 30,
                    //       color: Colors.yellowAccent,
                    //     ),
                    //   ),
                    // ),
                    Expanded(
                      child: SizedBox(
                        height: 200,
                        child: ListView.builder(
                          padding:
                              const EdgeInsets.fromLTRB(6.0, 7.0, 6.0, 15.0),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            // return Card(
                            //   color: const Color.fromARGB(244, 255, 255, 255),
                            //   child: ListTile(
                            //     leading: const Icon(Icons.account_circle_sharp),
                            //     title: Text(
                            //         "Request Recieved from ${snapshot.data![index].borrowerName}"),
                            //     subtitle: Text(snapshot.data![index].status),
                            //     trailing: Text(snapshot.data![index].amount.toString()),
                            //   ),
                            // );
                            return GestureDetector(
                              onTap: () => {
                                openRequestScreen(
                                  context,
                                  snapshot.data![index].transactionID,
                                  snapshot.data![index].amount,
                                  snapshot.data![index].borrowerName,
                                  snapshot.data![index].lenderName,
                                  snapshot.data![index].requestedDt,
                                  snapshot.data![index].status,
                                )
                              },
                              child: TransactionTile(
                                  name: snapshot.data![index].lenderName,
                                  status: snapshot.data![index].status,
                                  amount: snapshot.data![index].amount,
                                  message: "Udhar request sent to "),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ));
  }
}
