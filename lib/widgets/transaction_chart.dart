import 'package:expenses_app/widgets/chart_bar.dart';
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
      print("ge" + DateFormat.E().format(weekDay));

      return {
        // 'day': DateFormat.E().format(weekDay).substring(0, 1),
        'day': DateFormat.E().format(weekDay),
        'amount': totalSum
      };
    });
  }

  // void List<Map> daysTracler(){
  //   return
  // }
  double get maxSpent {
    return transactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(transactionValues);
    return Card(
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: transactionValues.map((data) {
          return Flexible(
            fit: FlexFit.tight,
            child: Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: ChartBar(
                label: data['day'],
                spentAmount: data['amount'],
                spentAmountPercent: (data['amount'] as double) / maxSpent,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
// Text("${data['day']}  ${data['amount']}")
// Column(
// children: [
// Text("${data['day']}"),
// SizedBox(
// height: 10,
// ),
// Text("${data['amount']}")
// ],
// );
