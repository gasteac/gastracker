import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();
const uuid = Uuid();

enum Category {
  comida,
  viajes,
  trabajo,
  ocio,
  casino,
  transporte,
  hogar,
  otros
}

const categoryIcons = {
  Category.comida: Icons.lunch_dining,
  Category.viajes: Icons.flight_takeoff,
  Category.ocio: Icons.movie,
  Category.trabajo: Icons.work,
  Category.casino: Icons.casino,
  Category.transporte: Icons.bus_alert,
  Category.hogar: Icons.home,
  Category.otros: Icons.more_rounded,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDated {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket({
    required this.category,
    required this.expenses,
  });
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category) 
  : expenses = allExpenses.where((expense) => expense.category == category).toList();

  final Category category;
  final List<Expense> expenses;
  double get totalExpenses {
    double sum = 0;
    for (var expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
