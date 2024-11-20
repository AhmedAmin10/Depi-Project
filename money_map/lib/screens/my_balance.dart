import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:money_map/Screens/settings.dart';
import 'package:provider/provider.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/data.dart';
import '../models/expense.dart';
import '../models/income.dart';
import 'expenses.dart';

class MyBalance extends StatefulWidget {
  const MyBalance({super.key});
  @override
  State<MyBalance> createState() => _MyBalanceState();
}

class _MyBalanceState extends State<MyBalance> {
  final incomeNameController = TextEditingController(),
      incomePriceController = TextEditingController(),
      expenseNameController = TextEditingController(),
      expensePriceController = TextEditingController();

  final int _selectedIndex = 1; // State variable for the selected index
  DateTime selectedDate = DateTime.now(); // Variable to store the selected date

  @override
  void initState() {
    super.initState();
    Provider.of<Data>(context, listen: false).prepareData();
  }

  void editExpense(Expense expense) {
    setState(() {
      selectedDate = expense.date; // Pre-fill the selected date
    });

    // Pre-fill the controllers with existing data
    expenseNameController.text = expense.name;
    expensePriceController.text = expense.price;

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Edit Expense'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: expenseNameController,
                    decoration: const InputDecoration(
                      labelText: 'Expense Name',
                      hintText: 'EX: food, books..etc',
                    ),
                  ),
                  TextField(
                    controller: expensePriceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Expense Price',
                      hintText: "0.00",
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: Text(
                        'Pick Date: ${DateFormat.yMd().format(selectedDate)}'),
                  ),
                ],
              ),
              actions: [
                MaterialButton(
                    onPressed: () {
                      saveEditExpense(expense);
                    },
                    child: const Text('Save')),
                MaterialButton(
                  onPressed: cancel,
                  child: const Text('Cancel'),
                )
              ],
            ));
  }

  void deleteExpense(Expense item) {
    Provider.of<Data>(context, listen: false).delete(item);
    MotionToast.success(
      title: const Text("Expense Deleted Successfully"),
      description: const Text(""),
    ).show(context);
  }

  void saveEditExpense(Expense expense) {
    if (expenseNameController.text.isNotEmpty &&
        expensePriceController.text.isNotEmpty) {
      Provider.of<Data>(context, listen: false).edit(
          expense,
          expenseNameController.text,
          expensePriceController.text,
          selectedDate);
      MotionToast.success(
        title: const Text("Expense Edited Successfully"),
        description: const Text(""),
      ).show(context);
    } else {
      MotionToast.error(
              title: const Text("Error"),
              description: const Text("Please enter correct expense details"))
          .show(context);
    }
    cancel();
  }

  void addNewIncome() {
    setState(() {
      selectedDate = DateTime.now(); // Reset date when adding a new expense
    });

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Add New Income'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: incomeNameController,
                    decoration: const InputDecoration(
                      labelText: 'Income Source',
                      hintText: 'EX: Salary, Bonus, Allowance...etc',
                    ),
                  ),
                  TextField(
                    controller: incomePriceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Amount',
                      hintText: "0.00",
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: Text(
                        'Pick Date: ${DateFormat.yMd().format(selectedDate)}'),
                  ),
                ],
              ),
              actions: [
                MaterialButton(onPressed: save, child: const Text('Save')),
                MaterialButton(
                  onPressed: cancel,
                  child: const Text('Cancel'),
                )
              ],
            ));
  }

  void editIncome(Income income) {
    setState(() {
      selectedDate = income.date; // Pre-fill the selected date
    });

    // Pre-fill the controllers with existing data
    incomeNameController.text = income.name;
    incomePriceController.text = income.amount;

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Edit Income'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: incomeNameController,
                    decoration: const InputDecoration(
                      labelText: 'Income Name',
                      hintText: 'EX: Salary, Bonus, Allowance...etc',
                    ),
                  ),
                  TextField(
                    controller: incomePriceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Amount',
                      hintText: "0.00",
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: Text(
                        'Pick Date: ${DateFormat.yMd().format(selectedDate)}'),
                  ),
                ],
              ),
              actions: [
                MaterialButton(
                    onPressed: () {
                      saveEdit(income);
                    },
                    child: const Text('Save')),
                MaterialButton(
                  onPressed: cancel,
                  child: const Text('Cancel'),
                )
              ],
            ));
  }

  void save() {
    if (incomeNameController.text.isNotEmpty &&
        incomePriceController.text.isNotEmpty) {
      Provider.of<Data>(context, listen: false).addIncome(Income(
          name: incomeNameController.text,
          amount: incomePriceController.text,
          date: selectedDate)); // Save with the selected date
      MotionToast.success(
        title: const Text("Income Added Successfully"),
        description: const Text(""),
      ).show(context);
    } else {
      MotionToast.error(
              title: const Text("Error"),
              description: const Text("Please enter correct income details"))
          .show(context);
    }
    cancel();
  }

  void saveEdit(Income income) {
    if (incomeNameController.text.isNotEmpty &&
        incomePriceController.text.isNotEmpty) {
      Provider.of<Data>(context, listen: false).editIncome(income,
          incomeNameController.text, incomePriceController.text, selectedDate);
      MotionToast.success(
        title: const Text("Income Edited Successfully"),
        description: const Text(""),
      ).show(context);
    } else {
      MotionToast.error(
              title: const Text("Error"),
              description: const Text("Please enter correct income details"))
          .show(context);
    }
    cancel();
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    incomePriceController.clear();
    incomeNameController.clear();
  }

  void deleteIncome(Income item) {
    Provider.of<Data>(context, listen: false).deleteIncome(item);
    MotionToast.success(
      title: const Text("Income Deleted Successfully"),
      description: const Text(""),
    ).show(context);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> all = [];
    double totalIncome = 0, totalExpenses = 0;
    double getBalance() {
      var incomes = Provider.of<Data>(context, listen: false).getIncomes();
      var expenses = Provider.of<Data>(context, listen: false).getAll();
      all.clear();

      all.addAll(incomes);
      all.addAll(expenses);

      all.sort((a, b) => b.date.compareTo(a.date));

      totalIncome = incomes.fold(0.0, (sum, income) {
        return sum + double.parse(income.amount);
      });

      totalExpenses = expenses.fold(0.0, (sum, expense) {
        return sum + double.parse(expense.price);
      });
      return totalIncome - totalExpenses;
    }

    return Consumer<Data>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: addNewIncome,
          backgroundColor: const Color(0xff272e81),
          foregroundColor: Colors.white,
          child: const Icon(Icons.add),
        ),
        body: Column(
          children: [
            // Balance Section
            Padding(
              padding: const EdgeInsets.only(
                  top: 50, bottom: 10), // Adjust top and bottom space as needed
              child: Center(
                child: Text(
                  "Your Balance \n£${getBalance().toStringAsFixed(2)}\n",
                  style: GoogleFonts.montserrat(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff272e81),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            // Income and Expense Section
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10), // Reduced horizontal padding
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Income Section
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.green,
                        child: Icon(
                          Icons.arrow_upward,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                          width: 10), // Reduced space between icon and text
                      Text(
                        'Income\n£${totalIncome.toString()}',
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  // Spacer to push the Expense section to the right
                  const Spacer(),
                  // Expense Section
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Icon(
                          Icons.arrow_downward,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                          width: 10), // Reduced space between icon and text
                      Text(
                        'Expense\n£${totalExpenses.toString()}',
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(
                  top: 20), // Adjust space before the title
              child: Center(
                child: Text(
                  "All Transactions",
                  style: GoogleFonts.montserrat(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff272e81),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            // Inner ListView
            Expanded(
              child: ListView.builder(
                itemCount: all.length, // Use the combined list length
                itemBuilder: (context, index) {
                  final item =
                      all[index]; // Get each item from the combined list

                  return Slidable(
                    endActionPane: ActionPane(
                      motion: const StretchMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (BuildContext context) {
                            // Delete based on whether it's income or expense
                            if (item is Income) {
                              deleteIncome(item);
                            } else {
                              deleteExpense(item);
                            }
                          },
                          icon: Icons.delete,
                          backgroundColor: Colors.red,
                          borderRadius: BorderRadius.circular(4),
                          foregroundColor: Colors.white,
                        ),
                        SlidableAction(
                          onPressed: (BuildContext context) {
                            // Edit based on whether it's income or expense
                            if (item is Income) {
                              editIncome(item);
                            } else {
                              editExpense(item);
                            }
                          },
                          icon: Icons.edit,
                          backgroundColor: Colors.blue,
                          borderRadius: BorderRadius.circular(4),
                          foregroundColor: Colors.white,
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(
                        item.name,
                        style: const TextStyle(
                          color: Color(0xff272e81),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${item.date.day.toString().padLeft(2, '0')} / ${item.date.month.toString().padLeft(2, '0')} / ${item.date.year}',
                        style: const TextStyle(
                          color: Color(0xff9496c1),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      trailing: Text(
                        // If it's an income, show amount in green, otherwise show expense price in red
                        item is Income ? '£${item.amount}' : '£${item.price}',
                        style: TextStyle(
                          color: item is Income ? Colors.green : Colors.red,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: FlashyTabBar(
          selectedIndex: _selectedIndex,
          showElevation: true,
          onItemSelected: (index) {
            // Handle tab selection
            switch (index) {
              case 0:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Expenses()),
                );
                break;
              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyBalance()),
                );
                break;
              case 2:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Settings()),
                );
                break;
              default:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyBalance()),
                );
            }
          },
          items: [
            FlashyTabBarItem(
              icon: const Icon(Icons.attach_money),
              title: const Text('My Expenses'),
            ),
            FlashyTabBarItem(
              icon: const Icon(Icons.account_balance_wallet),
              title: const Text('My Balance'),
            ),
            FlashyTabBarItem(
              icon: const Icon(Icons.settings),
              title: const Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
