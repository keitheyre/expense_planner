import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/new_transaction.dart';
import 'package:expense_planner/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _transactions = [
    Transaction(
        id: "001", title: "New Shoes", amount: 25.99, date: DateTime.now()),
    Transaction(
        id: "002", title: "Groceries", amount: 63.99, date: DateTime.now()),
  ];

  void _addNewTransaction(String inputTitle, double inputAmount) {
    final newTrans = Transaction(
      title: inputTitle,
      amount: inputAmount,
      id: DateTime.now().toString(),
      date: DateTime.now(),
    );

    setState(() {
      _transactions.add(newTrans);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(_addNewTransaction),
        TransactionList(_transactions),
      ],
    );
  }
}
