// ignore_for_file: must_be_immutable, prefer_final_fields

import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:numberpicker/numberpicker.dart';
// import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:udhar_app/services/transaction_service.dart';

class RequestForm extends StatefulWidget {
  RequestForm({super.key, required this.lenderID, required this.lenderName});
  String lenderName;
  String lenderID;

  @override
  State<RequestForm> createState() => _RequestFormState();
}

class _RequestFormState extends State<RequestForm> {
  final _form = GlobalKey<FormState>();

  void _submit() {
    TransactionService ts = TransactionService();
    ts.sendUdharRequest(
        widget.lenderID, _amount, _roi, _enddate.toString(), widget.lenderName);
    print("udharrequestSent");
    Navigator.pop(context);
  }

  int _amount = 0;
  int _roi = 0;
  DateTime _enddate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(58, 66, 86, 1.0),
      child: Card(
        color: const Color.fromRGBO(58, 66, 86, 1.0),
        // margin: const EdgeInsets.all(50),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: _form,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                      hoverColor: Colors.white,
                      enabledBorder: OutlineInputBorder(),
                      focusColor: Colors.white,
                      labelStyle: TextStyle(color: Colors.white, fontSize: 15),
                      helperText: "ENTER THE AMOUNT",
                      labelText: 'Amount to Request'),
                  keyboardType: TextInputType.number,
                  autocorrect: false,
                  textCapitalization: TextCapitalization.none,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _amount = int.parse(value);
                    });
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text('Rate of Interest',
                    style: TextStyle(color: Colors.white)),
                const SizedBox(
                  height: 10,
                ),
                NumberPicker(
                  textStyle: TextStyle(color: Colors.white),
                  minValue: 0,
                  step: 1,
                  haptics: true,
                  axis: Axis.horizontal,
                  maxValue: 15,
                  value: _roi,
                  onChanged: (value) => setState(() => _roi = value),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.black26),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                // SizedBox(
                //   height: 250,
                //   child: ScrollDatePicker(
                //     selectedDate: _enddate,
                //     locale: const Locale('en'),
                //     onDateTimeChanged: (DateTime value) {
                //       setState(() {
                //         _enddate = value;
                //       });
                //     },
                //   ),
                // ),
                ElevatedButton(
                    onPressed: () {
                      _submit();
                    },
                    child: const Text("SUBMIT")),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
