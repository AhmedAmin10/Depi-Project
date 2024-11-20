import 'package:hive/hive.dart';
import 'expense.dart';
import 'income.dart';


class HiveDataBase {
  final _myBox = Hive.box("expense_database");

  // Save both expenses and incomes
  void saveData(List<Expense> allExpense, List<Income> allIncome) {
    // Save expenses
    List<List<dynamic>> allExpenses = [];
    for (var expense in allExpense) {
      List<dynamic> expenses = [
        expense.name,
        expense.price,
        expense.date.millisecondsSinceEpoch,
      ];
      allExpenses.add(expenses);
    }
    _myBox.put("ALL_EXPENSES", allExpenses);

    // Save incomes
    List<List<dynamic>> allIncomes = [];
    for (var income in allIncome) {
      List<dynamic> incomes = [
        income.name,
        income.amount,
        income.date.millisecondsSinceEpoch,
      ];
      allIncomes.add(incomes);
    }
    _myBox.put("ALL_INCOMES", allIncomes);
  }

  // Read both expenses and incomes
  List<Expense> readExpenses() {
    List savedExpenses = _myBox.get("ALL_EXPENSES") ?? [];
    List<Expense> allExpenses = [];
    for (int i = 0; i < savedExpenses.length; i++) {
      String name = savedExpenses[i][0];
      String price = savedExpenses[i][1];
      DateTime date = DateTime.fromMillisecondsSinceEpoch(savedExpenses[i][2]);

      Expense expense = Expense(name: name, price: price, date: date);
      allExpenses.add(expense);
    }
    return allExpenses;
  }

  List<Income> readIncomes() {
    List savedIncomes = _myBox.get("ALL_INCOMES") ?? [];
    List<Income> allIncomes = [];
    for (int i = 0; i < savedIncomes.length; i++) {
      String name = savedIncomes[i][0];
      String amount = savedIncomes[i][1];
      DateTime date = DateTime.fromMillisecondsSinceEpoch(savedIncomes[i][2]);

      Income income = Income(name: name, amount: amount, date: date);
      allIncomes.add(income);
    }
    return allIncomes;
  }
}