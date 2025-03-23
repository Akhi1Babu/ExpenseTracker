import 'package:expense_tracker/widgets/expense.dart';
import 'package:expense_tracker/widgets/expense_list/expense_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
final formatter=DateFormat.yMd();

const uuid=Uuid();
enum Category{
  work,leisure,travel,food
}
const CategoryIcons = {
  Category.work : Icons.money,
Category.leisure: Icons.party_mode,

  Category.food : Icons.food_bank,
  Category.travel: Icons.travel_explore,


};

class expense{

  expense({
    required this.title, required this.amount ,required this.date,required this.category
  }):id=uuid.v4();


  String id;
  String title;
  double amount;
  DateTime date;
  Category category;
  String get formatdate{
    return formatter.format(date);
}

}
class ExpenseBucket{
  ExpenseBucket({required this.category,required this.expenses});
  ExpenseBucket.forCategory(List<expense> allexpenses,this.category) :expenses =allexpenses.where((expense)=>expense.category==category).toList();
  final Category category;
  List<expense>expenses;
  double get TotalExpenses{
    double sum=0;

  for(final expense in expenses){
    sum+=expense.amount;
  }

    return sum;
  }

}