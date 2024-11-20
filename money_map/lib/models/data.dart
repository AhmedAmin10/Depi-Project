import 'package:flutter/material.dart';
import 'expense.dart';
import 'income.dart';
import 'hive_database.dart';

class Data extends ChangeNotifier {
  List<Expense> overall = [];
  List<Income> incomes = [];

  final db = HiveDataBase();

  // Prepare data by reading both expenses and incomes from the database
  void prepareData() {
    overall = db.readExpenses();
    incomes = db.readIncomes();
  }

  // Getter for all expenses
  List<Expense> getAll() {
    return overall;
  }

  // Getter for all incomes
  List<Income> getIncomes() {
    return incomes;
  }

  // Add new expense
  void add(Expense item) {
    overall.add(item);
    notifyListeners();
    db.saveData(overall, incomes); // Save both expenses and incomes
  }

  // Edit expense
  void edit(Expense expense, String newName, String newPrice, DateTime newDate) {
    delete(expense);
    add(Expense(name: newName, price: newPrice, date: newDate));
  }

  // Delete expense
  void delete(Expense item) {
    overall.remove(item);
    notifyListeners();
    db.saveData(overall, incomes); // Save both expenses and incomes
  }

  // Add new income
  void addIncome(Income income) {
    incomes.add(income);
    notifyListeners();
    db.saveData(overall, incomes); // Save both expenses and incomes
  }

  // Edit income
  void editIncome(Income income, String newName, String newAmount, DateTime newDate) {
    deleteIncome(income);
    addIncome(Income(name: newName, amount: newAmount, date: newDate));
  }

  // Delete income
  void deleteIncome(Income income) {
    incomes.remove(income);
    notifyListeners();
    db.saveData(overall, incomes); // Save both expenses and incomes
  }

  // get day
  String getDay(DateTime time) {
    switch (time.weekday) {
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      case 7:
        return "Sunday";
      default:
        return "";
    }
  }

  // get the date for the start of the week
  DateTime getStartWeek() {
    DateTime? start;
    DateTime today = DateTime.now();
    for (int i = 0; i < 7; i++) {
      DateTime day = today.subtract(Duration(days: i));
      if (getDay(day) == 'Saturday') {
        start = day;
      }
    }
    return start!;
  }

  Map<String, double> dailySummary() {
    Map<String, double> daily = {};
    for (var item in overall) {
      String date = item.date.day.toString().padLeft(2, '0') +
          item.date.month.toString().padLeft(2, '0') +
          item.date.year.toString();
      double price = double.parse(item.price);
      // if(daily.containsKey(date)){
      //   double newExpense = daily[date]!;
      //   newExpense += price;
      //   daily[date] = newExpense;
      // }
      // else{
      //   daily.addAll({date: price});
      // }
      daily.update(date, (existingExpense) => existingExpense + price,
          ifAbsent: () => price);
    }
    return daily;
  }
}