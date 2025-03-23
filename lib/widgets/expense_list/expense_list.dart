import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expense_list/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expense.dart';
class ExpenseList extends StatelessWidget {
  ExpenseList ({required this.expenses,required this.removelist,super.key
  });
  List<expense> expenses;
  final void Function(expense expenses) removelist;


  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount: expenses.length,itemBuilder: (ctx,index){
      return Dismissible (
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.3),
          margin: Theme.of(context).cardTheme.margin,

        ),
        onDismissed: (left) {
          removelist(expenses[index]);
        },
        key: ValueKey(expenses[index]),
          child: ExpenseItems(expenses[index]));
    });
  }
}
