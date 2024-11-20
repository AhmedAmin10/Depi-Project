import 'package:flutter/material.dart';
// Ensure 'More' class exists and is correctly imported

class Currency extends StatefulWidget {
  const Currency({super.key});

  @override
  State<Currency> createState() => _CurrencyState();
}

class _CurrencyState extends State<Currency> {
  String _selectedCurrency = 'USD'; // Default to USD to avoid null issues

  final List<Map<String, String>> currencies = [
    // {'name': 'United States', 'code': 'USD'},
    // {'name': 'Indonesia', 'code': 'IDR'},
    // {'name': 'Japan', 'code': 'JPY'},
    // {'name': 'Russia', 'code': 'RUB'},
    // {'name': 'Germany', 'code': 'EUR'},
    // {'name': 'Korea', 'code': 'WON'},
    {'name' : 'Egypt', 'code': 'EGY'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context, _selectedCurrency); // Pass back the selected currency
                    },
                    icon: const Icon(
                      Icons.chevron_left,
                      size: 30,
                      color: Color(0xFF001B94),
                    ),
                  ),
                  const Text(
                    "Currency",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff272e81),
                    ),
                  ),
                  const SizedBox(width: 30), // Placeholder for spacing
                ],
              ),
              const SizedBox(height: 30),
              Expanded(
                child: ListView.separated(
                  itemCount: currencies.length,
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.grey[800],
                    thickness: 0.5,
                  ),
                  itemBuilder: (context, index) {
                    final currency = currencies[index];
                    return RadioListTile<String>(
                      value: currency['code']!,
                      groupValue: _selectedCurrency,
                      onChanged: (value) {
                        setState(() {
                          _selectedCurrency = value!;
                        });
                      },
                      title: Text(
                        "${currency['name']} (${currency['code']})",
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      activeColor: const Color(0xff272e81),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
