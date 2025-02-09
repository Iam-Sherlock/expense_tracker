import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(children: [
          Text(expense.title),
          const SizedBox(
            height: 4,
          ),
          Row(
            children: [
              Text('Rs ${expense.amount.toStringAsFixed(2)}'),
              const Spacer(),
              // const Spacer(),              
              Row(
                children: [
                  Icon(categoryIcons[expense.category]),
                  SizedBox(width: 8),
                  Text(expense.formattedDate)
                ],
              )
            ],
          ), //used to use only 2 decimal points
        ]),
      ),
    );
  }
}
