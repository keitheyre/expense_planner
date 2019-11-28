import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:expense_planner/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  "No Transaction added yet",
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 200,
                    child: Image.asset(
                      "assets/images/waiting.png",
                      fit: BoxFit.cover,
                    )),
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: Row(
                    children: <Widget>[
                      //* Container for the amount on the left
                      Container(
                        margin: EdgeInsets.all(20),
                        child: Text(
                          "€${transactions[index].amount.toStringAsFixed(2)}",
                          style: Theme.of(context).textTheme.title,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                        padding: EdgeInsets.all(20),
                      ),
                      //* Column for the title and the date ontop of one another
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            transactions[index].title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 26),
                          ),
                          Text(
                            DateFormat("dd MMM y").format(
                              transactions[index].date,
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
