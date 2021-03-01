import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  DateTime chosenDate;

  void addNew() {
    String t = titleController.text;
    String a = amountController.text;

    widget.addTransac(t, a, chosenDate);
    Navigator.of(context).pop();
  }

  void showDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        setState(() {
          chosenDate = pickedDate;
        });
      }
    });
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
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Text(
                    chosenDate == null
                        ? 'No Date Selected'
                        : 'Picked Date: ${DateFormat.yMd().format(chosenDate)}',
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: IconButton(
                    icon: Icon(
                      Icons.calendar_today,
                      color: Colors.blue,
                    ),
                    onPressed: showDate,
                  ),
                ),
              ],
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
