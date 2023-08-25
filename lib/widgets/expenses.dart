import 'package:flutter/material.dart';
import 'package:gastracker/widgets/expenses_list/expenses_list.dart';
import 'package:gastracker/models/expense.dart';
import "package:gastracker/widgets/new_expense.dart";
import 'package:gastracker/widgets/chart/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Pizza',
      amount: 10.99,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: 'Shoes',
      amount: 99.99,
      date: DateTime.now(),
      category: Category.leisure,
    ),
    Expense(
      title: 'Tires',
      amount: 199.99,
      date: DateTime.now(),
      category: Category.travel,
    ),
  ];

  void _openAddExpenseModal() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return NewExpense(OnaddExpense: _addExpense);
      },
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.insert(0, expense);
    });
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
    Widget mainContent = const Center(
        child: Text(
      "No se encontraron gastos",
      style: TextStyle(fontSize: 20),
    ));
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
          expenses: _registeredExpenses, onRemoveExpense: _removeExpense);
    }
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: _openAddExpenseModal,
              icon: const Icon(
                Icons.add_box_rounded,
                size: 40,
              )),
        ],
        title: const Text('✨Agenda de Gastos✨'),
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(child: mainContent),
          
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
