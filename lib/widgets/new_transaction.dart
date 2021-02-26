import 'package:flutter/material.dart';
import '../models/transaction.dart';

class NewTransaction extends StatefulWidget {
  //final List<Transaction> userTransaction;
  final Function addTransac;

  NewTransaction({this.addTransac});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void addNew() {
    String t = titleController.text;
    String a = amountController.text;

    widget.addTransac(t, a);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      //elevation: 2,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 30, right: 30, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              keyboardType: TextInputType.text,
              onSubmitted: (val) =>
                  addNew(), //refers to the check sign after typing
              // onChanged: (newVal) {
              //   titleInput = newVal;
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (val) => addNew(),
              // onChanged: (newVal) {
              //   amountInput = newVal;
              // },
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              padding: EdgeInsets.all(10),
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                addNew();
                // print(titleController.text);
                // print(amountController.text);
              },
            )
          ],
        ),
      ),
    );
  }
}
