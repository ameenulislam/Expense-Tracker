import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransaction extends StatefulWidget {
  final Function addTx;
  AddTransaction(this.addTx);

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime date;

  void submitTransaction() {
    var inputTitle = titleController.text;
    var inputAmount = double.parse(amountController.text);

    if (inputTitle.isEmpty || inputAmount <= 0 || date == null) {
      return;
    }
    widget.addTx(
        titleController.text, double.parse(amountController.text), date);

    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        date = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: "Title"),
                controller: titleController,
                style: Theme.of(context).textTheme.bodyText1,
                onSubmitted: (_) => submitTransaction(),
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: "Price",
                    fillColor: Theme.of(context).primaryColorDark),
                controller: amountController,
                style: Theme.of(context).textTheme.bodyText1,
                onSubmitted: (_) => submitTransaction(),
                keyboardType: TextInputType.number,
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        date == null
                            ? 'No date chosen'
                            : DateFormat.yMd().format(date),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    FlatButton(
                        onPressed: _showDatePicker,
                        child: Text(
                          'Choose date',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        )),
                  ],
                ),
              ),
              RaisedButton(
                onPressed: submitTransaction,
                child: Text(
                  "Save",
                  style: TextStyle(
                      fontFamily: ('Quicksand'),
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                textColor: Theme.of(context).textTheme.button.color,
                color: Theme.of(context).primaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
