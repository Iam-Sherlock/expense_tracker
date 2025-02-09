import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _enteredTitle = TextEditingController();
  final _enteredAmount = TextEditingController();

  void _presentDatepicker() {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    SfDateRangePicker(minDate: firstDate, maxDate: now);

    // showDatePicker(
    //     context: context,
    //     firstDate: firstDate,
    //     lastDate: now,
    //     initialDate: now);
  }

  void dispose() {
    _enteredTitle.dispose();
    super.dispose();
  }

  String _selectedDate = '';

  void _onDateSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    print('Inside methods');
    setState(() {
      _selectedDate = args.value.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    return Padding(
      padding: EdgeInsets.all(20),
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
                const Text('Select Date'),
                IconButton(
                    onPressed: () {
                      setState(() {
                        print('Set State');
                      });

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Pick a Date"),
                            content: SizedBox(
                              height: 300, 
                              width: 300,// Adjust height to fit picker
                              child: SfDateRangePicker(
                                minDate: firstDate, maxDate: now,
                                onSelectionChanged: _onDateSelectionChanged,
                                selectionMode:
                                    DateRangePickerSelectionMode.single,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("Close"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.calendar_month))
              ],
            ))
          ]),
          Row(
            children: [
              ElevatedButton(
                  onPressed: () {
                    print(_enteredTitle.text);
                    print(_enteredAmount.text);
                  },
                  child: Text("Save")),
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
