import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:udhar_app/models/udhar_transaction.dart';
import 'package:udhar_app/services/transaction_service.dart';
import 'package:udhar_app/services/user_service.dart';

class SentUdharRequests extends StatelessWidget {
  const SentUdharRequests({super.key});

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
        body: Center(
          child: StreamBuilder<List<UdharTransaction>>(
            stream: TransactionService().getSentUdharRequests(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text('No data available');
              } else {
                // Render the list of custom objects
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(
                            "Udhar Request sent to ${snapshot.data![index].lenderName}"),
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
  }
}
