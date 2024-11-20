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
import '../widgets/expense_summary.dart';
import 'my_balance.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final expenseNameController = TextEditingController(),
      expensePriceController = TextEditingController();

  int _selectedIndex = 0; // State variable for the selected index
  DateTime selectedDate = DateTime.now(); // Variable to store the selected date

  @override
  void initState() {
    super.initState();
    Provider.of<Data>(context, listen: false).prepareData();
  }

  void addNewExpense() {
    setState(() {
      selectedDate = DateTime.now(); // Reset date when adding a new expense
    });

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Add New Expense'),
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
                MaterialButton(onPressed: save, child: const Text('Save')),
                MaterialButton(
                  onPressed: cancel,
                  child: const Text('Cancel'),
                )
              ],
            ));
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
                      saveEdit(expense);
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
    if (expenseNameController.text.isNotEmpty &&
        expensePriceController.text.isNotEmpty) {
      Provider.of<Data>(context, listen: false).add(Expense(
          name: expenseNameController.text,
          price: expensePriceController.text,
          date: selectedDate)); // Save with the selected date
      MotionToast.success(
        title: const Text("Expense Added Successfully"),
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

  void saveEdit(Expense expense) {
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

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    expensePriceController.clear();
    expenseNameController.clear();
  }

  void deleteExpense(Expense item) {
    Provider.of<Data>(context, listen: false).delete(item);
    MotionToast.success(
      title: const Text("Expense Deleted Successfully"),
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
    return Consumer<Data>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: addNewExpense,
          backgroundColor: const Color(0xff272e81),
          foregroundColor: Colors.white,
          child: const Icon(Icons.add),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 30),
                child: ExpenseSummary(start: value.getStartWeek()),
              ),
              Center(
                child: Text(
                  "Your Expenses",
                  style: GoogleFonts.montserrat(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff272e81),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 400,
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: value.getAll().length,
                  itemBuilder: (context, index) {
                    final expense = value.getAll()[index];
                    return Slidable(
                      endActionPane: ActionPane(
                        motion: const StretchMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (BuildContext context) {
                              deleteExpense(expense);
                            },
                            icon: Icons.delete,
                            backgroundColor: Colors.red,
                            borderRadius: BorderRadius.circular(4),
                            foregroundColor: Colors.white,
                          ),
                          SlidableAction(
                            onPressed: (BuildContext context) {
                              editExpense(expense); // Trigger edit dialog
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
                          expense.name,
                          style: const TextStyle(
                            color: Color(0xff272e81),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          '${expense.date.day.toString().padLeft(2, '0')} / ${expense.date.month.toString().padLeft(2, '0')} / ${expense.date.year}',
                          style: const TextStyle(
                            color: Color(0xff9496c1),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        trailing: Text(
                          '£${expense.price}',
                          style: const TextStyle(
                            color: Colors.red,
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
        ),
        bottomNavigationBar: FlashyTabBar(
          selectedIndex: _selectedIndex,
          showElevation: true,
          onItemSelected: (index) => setState(() {
            _selectedIndex = index;
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
            }
          }),
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
