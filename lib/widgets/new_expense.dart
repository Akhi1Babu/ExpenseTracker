import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
final formatter = DateFormat.yMd();

class NewExpenses extends StatefulWidget {
  NewExpenses(this.onAddExpenses,{super.key});
  final void Function(expense expenses) onAddExpenses;
  @override
  State<NewExpenses> createState() {
    // TODO: implement createState
    return _NewExpensesState();
  }
}

class _NewExpensesState extends State<NewExpenses> {
  final _tilteController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;
  void showingAlertBox(){
    if(Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) =>
            CupertinoAlertDialog(
              title: Text("Invalid Input"),
              content: Text(
                  "Make Sure that you entered a Valid Tile,Amount and Date"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: Text("Close"),
                ),
              ],
            ),);
    }
    else{
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Invalid Input"),
          content: Text(
              "Make Sure that you entered a Valid Tile,Amount and Date"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text("Close"),
            ),
          ],
        ),);
    }

  }

  void _submitExpenseDate() {
    final enteredamount = double.tryParse(_amountController.text);
    final amoutIsInvalid = enteredamount == null || enteredamount < 0;
    if (_tilteController.text.trim().isEmpty ||
        amoutIsInvalid ||
        _selectedDate == null) {
      showingAlertBox();
      return;

      //error
    }
    widget.onAddExpenses(expense(title: _tilteController.text, amount: enteredamount, date: _selectedDate!  , category: _selectedCategory));
    Navigator.pop(context);
  }

  void _presentDataPicker() async {
    final presentdate = DateTime.now();
    final firstDate = DateTime(
        presentdate.year - 1, presentdate.month - 1, presentdate.day - 1);
    final lastDate = presentdate;
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: presentdate,
        firstDate: firstDate,
        lastDate: lastDate);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  void dispose() {
    _tilteController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final keyboardspace= MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx,constraints){
      final width= constraints.maxWidth;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 30, 16, keyboardspace+16),
            child: Column(
              children: [
                if (width>=600)
                  Row(
                    children: [

                      Expanded(
                        child: TextField(
                          controller: _tilteController,
                          maxLength: 50,
                          decoration: InputDecoration(label: Text('title')),
                        ),
                      ),
                      SizedBox(width: 12.0),
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          maxLength: 50,
                          decoration:
                          InputDecoration(prefixText: '\$', label: Text('Amount')),
                        ),
                      ),


                    ],
                  )
                else
                TextField(
                  controller: _tilteController,
                  maxLength: 50,
                  decoration: InputDecoration(label: Text('title')),
                ),
                if(width >=600)
                  Row(
                    children: [                    DropdownButton(
                        value: _selectedCategory,
                        items: Category.values
                            .map(
                              (category) => DropdownMenuItem(
                            value: category,
                            child: Text(
                              category.name.toUpperCase(),
                            ),
                          ),
                        )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }

                          setState(() {
                            _selectedCategory = value;
                          });
                        }),
                      SizedBox(width:12.0),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(_selectedDate == null
                                ? 'No Date Selected'
                                : formatter.format(_selectedDate!)),
                            IconButton(
                                onPressed: _presentDataPicker,
                                icon: Icon(Icons.calendar_month)),
                          ],
                        ),
                      )



                    ],
                  )
              else
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        maxLength: 50,
                        decoration:
                        InputDecoration(prefixText: '\$', label: Text('Amount')),
                      ),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(_selectedDate == null
                              ? 'No Date Selected'
                              : formatter.format(_selectedDate!)),
                          IconButton(
                              onPressed: _presentDataPicker,
                              icon: Icon(Icons.calendar_month)),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                if(width >=600)
                  Row(
                    children: [
                      Spacer(),
                      ElevatedButton(
                          onPressed: _submitExpenseDate, child: Text("Save Expense")),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Cancel",
                          ))


                    ],
                  )
                else
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: _submitExpenseDate, child: Text("Save Expense")),
                    Spacer(),
                    DropdownButton(
                        value: _selectedCategory,
                        items: Category.values
                            .map(
                              (category) => DropdownMenuItem(
                            value: category,
                            child: Text(
                              category.name.toUpperCase(),
                            ),
                          ),
                        )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }

                          setState(() {
                            _selectedCategory = value;
                          });
                        }),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                        ))

                  ],
                ),
              ],
            ),
          ),
        ),
      );

    });




  }
}
