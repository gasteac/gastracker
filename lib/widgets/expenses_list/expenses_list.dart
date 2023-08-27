import 'package:flutter/material.dart';
import 'package:gastrack/models/expense.dart';
import 'package:gastrack/widgets/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});
  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.8),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: const Icon(Icons.delete, color: Colors.white, size: 30),
          ),
          onDismissed: (direction) {
            onRemoveExpense(expenses[index]);
          },
          key: ValueKey(expenses[index]),
          child: ExpenseItem(expenses[index])),
    );
  }
}
