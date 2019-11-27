import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function newTransactionOnClick;

  NewTransaction(this.newTransactionOnClick);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              // onChanged: (titleInput) {
              //   title = titleInput;
              // },
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              // onChanged: (amountInput) {
              //   amount = amountInput;
              // },
              controller: amountController,
            ),
            FlatButton(
                child: Text("Add Transaction"),
                textColor: Colors.purple,
                onPressed: () {
                  newTransactionOnClick(
                    titleController.text,
                    double.parse(amountController.text),
                  );
                }),
          ],
        ),
      ),
    );
  }
}