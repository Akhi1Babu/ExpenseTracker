import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expense_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  ExpenseList({required this.expenses, required this.removelist, super.key});

  final List<expense> expenses;
  final void Function(expense expenses) removelist;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) {
        final expenseItem = expenses[index];

        return Dismissible(
          key: ValueKey(expenseItem.id), // Unique key for each item
          background: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            color: Colors.red.withOpacity(0.7), // Red background
            child: const Icon(Icons.delete, color: Colors.white, size: 32), // Delete icon
          ),
          secondaryBackground: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            color: Colors.red.withOpacity(0.3),
            child: const Icon(Icons.delete_forever, color: Colors.white, size: 32),
          ),
          direction: DismissDirection.endToStart, // Swipe from right to left
          onDismissed: (direction) {
            removelist(expenseItem); // Remove item from list

            // Show Snackbar with undo option
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Expense deleted'),
                action: SnackBarAction(
                  label: 'UNDO',
                  onPressed: () {
                    // Re-add the expense if undo is pressed
                    expenses.insert(index, expenseItem);
                  },
                ),
              ),
            );
          },
          child: ExpenseItems(expenseItem),
        );
      },
    );
  }
}
