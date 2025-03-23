import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';


class ExpenseItems extends StatelessWidget{
  ExpenseItems(this.items,{super.key});
  final expense items;

  @override
  Widget build(context){
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(items.title,
            style: Theme.of(context).textTheme.titleLarge,),
            SizedBox(height: 10,),
            Row(
              children: [
                Text('\$ ${items.amount.toStringAsFixed(2)}'),//12.3243=>12.32
               Spacer(),
                Row(
                  children: [
                    Icon(CategoryIcons[items.category]),
                    SizedBox(width: 6,),
                    Text(items.formatdate),
                  ],

                )




              ],

      )
          ],
        )
      ),
    );

  }

}