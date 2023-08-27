import 'package:flutter/material.dart';
import 'package:gastrack/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});
  final Expense expense;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expense.title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 2),
            Row(children: [
              Text('\$ ${expense.amount.toStringAsFixed(2)}' , style: Theme.of(context).textTheme.titleSmall),
              const Spacer(),
              Row(
                children: [
                  Icon(categoryIcons[expense.category]),
                  const SizedBox(width: 5),
                  Text(expense.formattedDated, style: Theme.of(context).textTheme.titleSmall),
                ],
              )
            ])
          ],
        ),
      ),
    );
  }
}
