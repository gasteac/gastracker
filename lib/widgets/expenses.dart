import 'package:flutter/material.dart';
import 'package:gastrack/widgets/expenses_list/expenses_list.dart';
import 'package:gastrack/models/expense.dart';
import "package:gastrack/widgets/new_expense.dart";
import 'package:gastrack/widgets/chart/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Pizza',
      amount: 3000,
      date: DateTime.now(),
      category: Category.comida,
    ),
    Expense(
      title: 'Zapatillas',
      amount: 24000,
      date: DateTime.now(),
      category: Category.ocio,
    ),
    Expense(
      title: 'Viaje Google',
      amount: 25000,
      date: DateTime.now(),
      category: Category.viajes,
    ),
    Expense(
      title: 'Gates of Olympus',
      amount: 5000,
      date: DateTime.now(),
      category: Category.casino,
    ),
    Expense(
      title: 'Maletin',
      amount: 5000,
      date: DateTime.now(),
      category: Category.trabajo,
    ),
    Expense(
      title: 'UTN',
      amount: 14000,
      date: DateTime.now(),
      category: Category.transporte,
    ),
    Expense(
      title: 'Fibertel',
      amount: 20000,
      date: DateTime.now(),
      category: Category.hogar,
    ),
    Expense(
      title: 'AyudaComunitaria',
      amount: 50000,
      date: DateTime.now(),
      category: Category.otros,
    ),
  ];

  void _openAddExpenseModal() {
    showModalBottomSheet(
      useSafeArea:
          true, //que no choque con la camara o elementos importante de dif celulares
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return NewExpense(onAddExpense: _addExpense);
      },
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.insert(0, expense);
    });
  }

  void _removeAllExpenses() {
    setState(() {
      _registeredExpenses.clear();
    });
  }

  void deleteAll() {
    showModalBottomSheet(
      useSafeArea:
          true, //que no choque con la camara o elementos importante de dif celulares
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return SizedBox(
          width: double.infinity,
          child: Container(
            margin: const EdgeInsets.fromLTRB(0, 250, 0, 0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Text(
                    "¿Estas seguro que deseas eliminar todos los gastos?"),
                const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () {
                      _removeAllExpenses();
                      Navigator.of(context).pop();
                    },
                    child: const Text("Eliminar todos")),
                const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cancelar")),
              ],
            ),
          ),
        );
      },
    );
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Gasto eliminado"),
      duration: const Duration(seconds: 4),
      action: SnackBarAction(
        label: "Deshacer",
        onPressed: () {
          setState(() {
            _registeredExpenses.insert(expenseIndex, expense);
          });
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = Center(
        child: Text(
      "No posees gastos :D",
      style: Theme.of(context).textTheme.titleMedium,
    ));
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
          expenses: _registeredExpenses, onRemoveExpense: _removeExpense);
    }
    return Scaffold(
      resizeToAvoidBottomInset: false, //this line.
      appBar: AppBar(
        actions: [
          Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: ElevatedButton(
                  onPressed: _openAddExpenseModal,
                  child: const Text("Agregar")))
        ],
        title: const Text(
          'GASTRACK ✨🫰',
          style: TextStyle(fontFamily: 'Aladin', fontWeight: FontWeight.w500),
        ),
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Deslize para eliminar",
                        style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(width: 10),
                    ElevatedButton(
                        onPressed: deleteAll,
                        child: const Text("Eliminar todos"))
                  ],
                ),
                const SizedBox(height: 5),
                Expanded(child: mainContent),
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _registeredExpenses)),
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Deslize para eliminar",
                              style: Theme.of(context).textTheme.titleSmall),
                          const SizedBox(width: 10),
                          ElevatedButton(
                              onPressed: deleteAll,
                              child: const Text("Eliminar todos"))
                        ],
                      ),
                      Expanded(child: mainContent),
                    ],
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddExpenseModal,
        tooltip: 'Agregar',
        child: const Icon(Icons.add),
      ), //
    );
  }
}
