import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Transaction {
  //use final in every class attribute
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  //constructor
  Transaction({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.date,
  });
}
