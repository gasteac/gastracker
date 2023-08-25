import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import 'package:gastracker/models/expense.dart';

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.OnaddExpense});
  final void Function(Expense) OnaddExpense;
  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    //esta linea (para abajo) solo se ejecuta dsp de que showDataPicker le da un valor a pickedDate
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpendeData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (amountIsInvalid ||
        _titleController.text.trim().isEmpty ||
        _amountController.text.trim().isEmpty ||
        _selectedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text("Datos invalidos", style: Theme.of(context).textTheme.titleSmall),
                content: Text("Por favor ingresa datos validos", style: Theme.of(context).textTheme.titleSmall),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: Text("Okay:(", style: Theme.of(context).textTheme.titleSmall))
                ],
              ));
      return;
    } else {
      widget.OnaddExpense(Expense(
          title: _titleController.text,
          amount: enteredAmount,
          date: _selectedDate!,
          category: _selectedCategory));
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 80, 24, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                label: Text(
              "Titulo",
              style: Theme.of(context).textTheme.titleSmall,
            )),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  maxLength: 50,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                      prefixText: '\$',
                      label: Text('Cantidad',
                          style: Theme.of(context).textTheme.titleSmall)),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                        _selectedDate == null
                            ? 'Fecha:'
                            : formatter.format(_selectedDate!),
                        style: Theme.of(context).textTheme.titleSmall),
                    IconButton(
                        onPressed: _presentDatePicker,
                        icon: const Icon(Icons.calendar_month))
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Text("Categoria",
                style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(width: 26),
            DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map((category) => DropdownMenuItem(
                        value: category,
                        child: Text(category.name.toUpperCase(),
                            style: Theme.of(context).textTheme.titleSmall)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    if (value == null) {
                      return;
                    }
                    _selectedCategory = value;
                  });
                })
          ]),

                  ElevatedButton.icon(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10)),
                              backgroundColor: MaterialStateColor.resolveWith((states) => const Color.fromARGB(106, 128, 128, 128)),
                    ),
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      //Navigator.of(context).pop();
                      Navigator.pop(context);
                    },
                    label: const Text(
                      'Cancelar',
                    ),
                  ),
            ],
          ),
        const SizedBox(height: 20,),
         Row(
           children: [
             Expanded(
               child: ElevatedButton.icon(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                      ),
                      icon: const Icon(Icons.add),
                      onPressed: _submitExpendeData,
                      label: const Text(
                        'Agregar',
                      ),
                    ),
             ),
           ],
         ),
        ],
      ),
      
    );
  }
}
