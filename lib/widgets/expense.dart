import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expense_list/expense_list.dart';

class Expense extends StatefulWidget {
  Expense({super.key});

  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  List<expense> _resisteredExpenses = [
    expense(
        title: "USA Trip",
        amount: 991.99,
        date: DateTime.now(),
        category: Category.work),
    expense(
        title: "City Trip",
        amount: 19.99,
        date: DateTime.now(),
        category: Category.leisure),
  ];
  void _addExpense(expense expenses){
    setState(() {
      _resisteredExpenses.add(expenses);

    });

  }
  void _removeExpense(expense expenses){
    final expenseIndex=_resisteredExpenses.indexOf(expenses);
    setState(() {
      _resisteredExpenses.remove(expenses);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Expense Deleted.."),
      duration: Duration(seconds: 3),
      action: SnackBarAction(label: 'Undo', onPressed: (){
        setState(() {
          _resisteredExpenses.insert(expenseIndex, expenses);

        });

      }),
      ),


    );
  }
  void _OpenAddExpenseOverlay(){

    showModalBottomSheet(context: context, builder: (ctx) => NewExpenses(_addExpense),
    isScrollControlled: true,
    );


  }
  @override
  Widget build(BuildContext context) {
    Widget maincontent=Center(
      child: Text('No expense found, Strart adding some ..'),
    );
    if(_resisteredExpenses.isNotEmpty){
     maincontent= ExpenseList(
          expenses: _resisteredExpenses,
          removelist: _removeExpense
      );

    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Flutter Expense Tracker",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _OpenAddExpenseOverlay,
            icon: Icon(Icons.add),
          ),
        ],
      ),


      body: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 16),

            ),
          ),
          Chart(expenses: _resisteredExpenses),
          Expanded(child: maincontent),
        ],
      ),
    );
  }
}
