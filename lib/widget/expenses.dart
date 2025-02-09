import 'package:expense_tracker/widget/new_expense.dart';
import 'package:flutter/material.dart';
import 'expense_list/expense_list.dart';
import '../models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredexpenses = [
    Expense(
        title: "Food",
        amount: 10,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        title: "Movie",
        amount: 5,
        date: DateTime.now(),
        category: Category.leisure)
  ];

  void _addExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => NewExpense(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Tracker"),
        actions: [
          IconButton(
              onPressed: () {
                _addExpenseOverlay();
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Text("The List"),
          Expanded(child: ExpenseList(expenses: _registeredexpenses)),
        ],
      ),
    );
  }
}
