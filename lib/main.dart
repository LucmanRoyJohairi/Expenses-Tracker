import 'package:flutter/material.dart';
import './widgets/transaction_chart.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        //accentColor:
        //primaryColor: Color(0xff90caf9),

        fontFamily: 'Quicksand',
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: Colors.blueAccent),
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _userTransaction = [
    // Transaction(
    //   id: 't001',
    //   title: 'Smartphone',
    //   amount: 50.99,
    //   date: DateTime.now(),
    // ),
  ];

  //get the transactions from 7 days ago
  List<Transaction> get recentTransactions {
    return _userTransaction.where((t) {
      return t.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String title, String amount, DateTime selectedDate) {
    String enteredTitle = title;
    double enteredAmount = double.parse(amount);
    print(enteredAmount);
    setState(() {
      _userTransaction.add(
        Transaction(
          id: 't00' + (_userTransaction.length).toString(),
          title: enteredTitle,
          amount: enteredAmount,
          date: selectedDate,
        ),
      );
    });
  }

  void deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((transaction) {
        return transaction.id == id;
      });
    });
  }

  void showAddTransactionScreen(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(
            addTransac: _addNewTransaction,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showAddTransactionScreen(context);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center, //top to bottom
          // crossAxisAlignment: CrossAxisAlignment.stretch, // left to right
          children: [
            TransactionChart(
              recentTransactions: recentTransactions,
            ),
            TransactionList(
              transactions: _userTransaction,
              delTransac: deleteTransaction,
            ),
            //: Container(child: Image.asset('assets/images/empty.png')),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showAddTransactionScreen(context);
        },
      ),
    );
  }
}
// Container(
// width: double.infinity,
// //padding: EdgeInsets.all(40),
// child: ListTile(
// leading: Text(purchased.amount.toString()),
// title: Text(purchased.title),
// subtitle: Text(purchased.date.toString()),
// ),
// ),
