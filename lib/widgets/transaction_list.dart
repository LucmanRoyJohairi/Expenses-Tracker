import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function delTransac;

  TransactionList({this.transactions, this.delTransac});

  @override
  Widget build(BuildContext context) {
    return (transactions.length == 0)
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Container(
                  height: constraints.maxHeight * 0.1,
                  child: Image.asset(
                    'assets/images/file.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                    'No Transactions...',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 2,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: FittedBox(
                          child: Text(
                            '\$${transactions[index].amount.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        delTransac(transactions[index].id);
                      },
                    ),
                  ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
// Card(
// elevation: 3,
// margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
// child: Padding(
// padding: const EdgeInsets.all(10),
// child: Row(
// children: [
// Container(
// padding: EdgeInsets.all(10),
// margin: EdgeInsets.all(10),
// //border
// decoration: BoxDecoration(
// border: Border.all(
// color: Theme.of(context).primaryColor,
// width: 2,
// ),
// ),
//
// child: Expanded(
// child: Text(
// '\$${transactions[index].amount.toStringAsFixed(2)}',
// style: TextStyle(
// fontSize: 20,
// //fontWeight: FontWeight.bold,
// color: Theme.of(context).primaryColor,
// ),
// ),
// ),
// ),
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Container(
// //Title
// padding: EdgeInsets.all(10),
// child: Text(
// transactions[index].title,
// style: Theme.of(context).textTheme.headline6,
// ),
// ),
// Container(
// //DATE
// padding: EdgeInsets.all(10),
// child: Text(
// //intl package
// DateFormat.yMMMd()
// .format(transactions[index].date),
// style: TextStyle(
// fontSize: 15,
// color: Colors.grey,
// ),
// ),
// ),
// ],
// ),
// ],
// ),
// ),
// );
