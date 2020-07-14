import 'package:Henfam/pages/explore/menu/menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Henfam/pages/explore/menu/basketForm.dart';
import 'package:Henfam/pages/explore/menu/menuOrderForm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Henfam/auth/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RequestConfirm extends StatelessWidget {
  final date;
  final range;
  final BasketData args;
  final uid;
  final String loc;
  final String name;

  RequestConfirm(
      this.date, this.range, this.args, this.uid, this.loc, this.name);

  final firestoreInstance = Firestore.instance;

  String getDay(DateTime date) {
    final today = DateTime.now();
    return (today.day == date.day) ? "Today" : "Tomorrow";
  }

  List<String> getTimes(DateTime date, DateTime range) {
    final interval = Duration(hours: range.hour, minutes: range.minute);
    final endDate = date.add(interval);

    final formatter = DateFormat.jm();
    final startTime = formatter.format(date);
    final endTime = formatter.format(endDate);
    List<String> lst = [];
    lst.add(startTime);
    lst.add(endTime);
    return lst;
    //return '$startTime - $endTime';
  }

  List<Map> convertOrdersToMap(List<FoodInfo> ords) {
    List<Map> orders = [];
    ords.forEach((FoodInfo ord) {
      Map order = ord.toJson();
      orders.add(order);
    });
    return orders;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: Text("Do you want to submit this order?",
          style: TextStyle(fontSize: 22.0)),
      message: Text(
          "Delivery Window: " +
              getTimes(date, range)[0] +
              " - " +
              getTimes(date, range)[1],
          style: TextStyle(fontSize: 20.0)),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text("Confirm"),
          isDefaultAction: true,
          onPressed: () {
            firestoreInstance.collection("orders").add({
              "user_id": {
                "name": name,
                "uid": uid,
                "rest_name_used": args.restaurant_name,
                "basket": convertOrdersToMap(args.orders),
                "location": loc,
                "delivery_window": {
                  "start_time": getTimes(date, range)[0],
                  "end_time": getTimes(date, range)[1]
                }
              }
            });
            Menu.order = []; //clears order after submitting
            Navigator.popUntil(
                context, ModalRoute.withName(Navigator.defaultRouteName));
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text("Cancel"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
