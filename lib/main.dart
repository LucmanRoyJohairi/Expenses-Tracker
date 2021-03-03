//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './widgets/transaction_chart.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
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
                fontSize: 20,
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

  //for the switch
  bool _showchart = false;

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final theAppBar = AppBar(
      title: Text('Personal Expenses'),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            showAddTransactionScreen(context);
          },
        )
      ],
    );
    final listOfTransaction = Container(
      height: (MediaQuery.of(context).size.height -
          theAppBar.preferredSize.height -
          MediaQuery.of(context).padding.top),
      child: TransactionList(
        transactions: _userTransaction,
        delTransac: deleteTransaction,
      ),
    );
    final toggleChart = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Show Chart'),
        Switch(
          activeColor: Colors.blue,
          value: _showchart,
          onChanged: (val) {
            setState(() {
              _showchart = val;
            });
          },
        ),
      ],
    );

    return Scaffold(
      appBar: theAppBar,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center, //top to bottom
          // crossAxisAlignment: CrossAxisAlignment.stretch, // left to right
          children: [
            if (isLandscape) toggleChart,

            if (!isLandscape)
              Container(
                height: (MediaQuery.of(context).size.height -
                        theAppBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
                child: TransactionChart(
                  recentTransactions: recentTransactions,
                ),
              ),
            if (!isLandscape) listOfTransaction,
            if (isLandscape)
              (_showchart)
                  ? Container(
                      height: (MediaQuery.of(context).size.height -
                              theAppBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.7,
                      child: TransactionChart(
                        recentTransactions: recentTransactions,
                      ),
                    )
                  : listOfTransaction
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
