import 'package:expense_planner/widgets/chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';

import 'models/transaction.dart';

void main() {
  runApp(MyApp());
  // SystemChrome.setPreferredOrientations(
  //   [
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitUp,
  //   ],
  // );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Expense App',
        home: MyHomePage(),
        //* Theme the entire app from here
        theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.blueAccent,
          errorColor: Colors.red,
          fontFamily: "Quicksand",
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
                button: TextStyle(
                  color: Colors.white,
                ),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          ),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];
  bool showChart = false;

  //Return a list of transations where the date is within the last 7 days, also convert Iterable to List
  List<Transaction> get _recentTransactions {
    return _transactions
        .where((item) {
          return item.date.isAfter(
            DateTime.now().subtract(
              Duration(days: 7),
            ),
          );
        })
        .toList()
        .reversed
        .toList();
  }

  void _addNewTransaction(
      String titleInput, double amountInput, DateTime choosenDate) {
    final newTransaction = Transaction(
      title: titleInput,
      amount: amountInput,
      date: choosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  void _deleteTransaction(String transactionId) {
    setState(() {
      _transactions.removeWhere((tx) => tx.id == transactionId);
    });
  }

  //Show a modul from the bottom sheet
  void _startAddNewTransaction(ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final bool isLandscape =
        (MediaQuery.of(context).orientation == Orientation.landscape);

    final appBar = AppBar(
      title: Text("Expense App"),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          color: Colors.white,
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );

    final transactionsList = Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.7,
      child: TransactionList(_transactions, _deleteTransaction),
    );
    return Scaffold(
      appBar: appBar,
      body: ListView(
        children: <Widget>[
          if (isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Show Chart"),
                Switch(
                  value: showChart,
                  onChanged: (value) {
                    setState(() {
                      showChart = value;
                      print("Showing: " + showChart.toString());
                    });
                  },
                ),
              ],
            ),
          if (!isLandscape)
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.3,
              child: Chart(_recentTransactions),
            ),
          if (!isLandscape) transactionsList,
          if (isLandscape)
            showChart
                ? Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.6,
                    child: Chart(_recentTransactions),
                  )
                : transactionsList
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
