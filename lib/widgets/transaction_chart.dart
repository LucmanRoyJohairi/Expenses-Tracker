import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionChart extends StatefulWidget {
  final List<Transaction> recentTransactions;

  TransactionChart({this.recentTransactions});

  @override
  _TransactionChartState createState() => _TransactionChartState();
}

class _TransactionChartState extends State<TransactionChart> {
  List<Map<String, Object>> get transactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;
      for (var i = 0; i < widget.recentTransactions.length; i++) {
        var shortDate = widget.recentTransactions[i];
        if (shortDate.date.day == weekDay.day &&
            shortDate.date.month == weekDay.month &&
            shortDate.date.year == weekDay.year) {
          totalSum += widget.recentTransactions[i].amount;
        }
      }
      return {'day': DateFormat.E(weekDay), 'amount': totalSum};
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            //width: double.infinity,
            padding: EdgeInsets.all(30),
            child: Text(
              'For the Chart',
              style: TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
