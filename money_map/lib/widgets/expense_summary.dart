import 'dart:core';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/data.dart';
import 'my_bar_graph.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime start;

  const ExpenseSummary({super.key, required this.start});

  @override
  Widget build(BuildContext context) {
    double total = 0;
    List<double> values = [];
    // Call dailySummary() using Provider to get the daily summary data
    Map<String, double> dailyExpenses = context.watch<Data>().dailySummary();

    // Initialize daysAmount as an empty map to hold the expenses for 7 days
    Map<int, double> daysAmount = {};

    // Populate daysAmount for 7 days starting from the `start` date
    for (int i = 0; i < 7; i++) {
      DateTime currentDay = start.add(Duration(days: i));
      String formattedDate = currentDay.day.toString().padLeft(2, '0') +
          currentDay.month.toString().padLeft(2, '0') +
          currentDay.year.toString();

      // Retrieve the expense for the current day from the dailySummary
      double dailyExpense = dailyExpenses[formattedDate] ?? 0;
      total += dailyExpense;
      values.add(dailyExpense);
      daysAmount.putIfAbsent(i, () => dailyExpense);
    }

    // Find the maximum expense to scale the graph
    values.sort();
    double maxY = values.last * 1.1;
    if (maxY == 0) {
      maxY = 100;
    }

    return Consumer<Data>(
      builder: (context, value, child) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // Center the text and graph
              children: [
                Center(
                  child: Text(
                    'Weekly Total : £$total',
                    style: GoogleFonts.montserrat(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff272e81),
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Space between text and graph
                SizedBox(
                  height: 200,
                  child: MyBarGraph(daysAmount: daysAmount, maxY: maxY),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
