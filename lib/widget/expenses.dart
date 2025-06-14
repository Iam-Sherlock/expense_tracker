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
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(
        onAddExpense: _addExpense,
      ),
    );
  }

  void _addExpense(Expense expensedata) {
    setState(() {
      _registeredexpenses.add(expensedata);
    });
  }

  void _removeExpense(Expense expensedata) {
    final registeredIndex = _registeredexpenses.indexOf(expensedata);
    setState(() {
      _registeredexpenses.remove(expensedata);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Undo"),
      duration: Duration(seconds: 3),
      action: SnackBarAction(
          label: "Undo",
          onPressed: () =>
              {_registeredexpenses.insert(registeredIndex, expensedata)}),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text("It is good to see!! When you have no Expenses."),
    );
    if (_registeredexpenses.isNotEmpty) {
      mainContent = Column(
        children: [
          Text("The List",style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),),
          Expanded(
              child: ExpenseList(
            expenses: _registeredexpenses,
            removeExpense: _removeExpense,
          )),
        ],
      );
    }

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
        body: mainContent);
  }
}
