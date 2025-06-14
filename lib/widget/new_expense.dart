import 'package:flutter/material.dart';
import '../models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _enteredTitle = TextEditingController();
  final _enteredAmount = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedcategory = Category.food;

  void _presentDatepicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final picketDate = await showDatePicker(
        context: context,
        firstDate: firstDate,
        lastDate: now,
        initialDate: now);

    setState(() {
      _selectedDate = picketDate;
    });
  }


  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_enteredAmount.text);
    final amountIsValid = enteredAmount == null || enteredAmount <= 0;
    if (_enteredAmount.text.trim().isEmpty ||
        amountIsValid ||
        _selectedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("Invalid Input"),
                content: const Text("Empty Input Make sure you fill something"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Okay'))
                ],
              ));
      return;
    }
    widget.onAddExpense(Expense(
        title: _enteredTitle.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedcategory));
    Navigator.pop(context);
  }

 


  void dispose() {
    _enteredTitle.dispose();
    _enteredAmount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 48, 20, 20),
      child: Column(
        children: [
          TextField(
            controller: _enteredTitle,
            maxLength: 50,
            decoration: InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(children: [
            Expanded(
              child: TextField(
                controller: _enteredAmount,
                maxLength: 5,
                decoration:
                    InputDecoration(label: Text('Amount'), prefixText: ('\$ ')),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_selectedDate == null
                    ? "Please Select an Date"
                    : formatter.format(_selectedDate!)),
                IconButton(
                    onPressed: () {
                      _presentDatepicker();
                    },
                    icon: Icon(Icons.calendar_month))
              ],
            ))
          ]),
          Row(
            children: [
              DropdownButton(
                  value: _selectedcategory,
                  items: Category.values
                      .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toString().toUpperCase())))
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedcategory = value;
                    });
                    print(value);
                  }),
              const Spacer(),
              ElevatedButton(
                  onPressed: () {
                    _submitExpenseData();
                    print(_enteredTitle.text);
                    print(_enteredAmount.text);
                    // Navigator.pop(context);
                  },
                  child: Text("Save")),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"))
            ],
          ),
        ],
      ),
    );
  }
}
