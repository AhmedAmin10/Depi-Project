import 'package:flutter/material.dart';
import 'package:money_map/Screens/expenses.dart';
import '../widgets/contact.dart';
import '../widgets/currency.dart';
import '../widgets/language.dart';
import '../widgets/notification.dart';
import '../widgets/security.dart';
import '../widgets/theme.dart';
import 'my_balance.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String selectedLanguage = 'English'; // Track selected language
  String selectedCurrency = 'USD'; // Default currency
  int _selectedIndex = 2; // State variable for the selected index

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Settings',
            style: TextStyle(
                color: Color(0xff272e81), fontWeight: FontWeight.bold),
          ),
          // leading: IconButton(
          //   icon: Icon(
          //     Icons.arrow_back,
          //     color: Colors.grey[700],
          //     size: 28,
          //   ),
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => const HomePage()),
          //     );
          //   },
          // ),
          // actions: [
          //   IconButton(
          //     icon: Icon(
          //       LucideIcons.search,
          //       color: Colors.grey[700],
          //       size: 28,
          //     ),
          //     onPressed: () {},
          //   ),
          //   IconButton(
          //     icon: Icon(
          //       LucideIcons.bellDot,
          //       color: Colors.grey[700],
          //       size: 28,
          //     ),
          //     onPressed: () {},
          //   ),
          // ],
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            const SizedBox(height: 30),
            _buildListTile(
              icon: Icons.attach_money,
              title: 'Currency',
              subtitle: selectedCurrency, // Show the selected currency here
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Currency()),
                );

                if (result != null) {
                  setState(() {
                    selectedCurrency = result; // Update selected currency
                  });
                }
              },
            ),
            _buildDivider(),
            _buildListTile(
              icon: Icons.language,
              title: 'Language',
              subtitle: selectedLanguage,
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LanguageScreen(
                      selectedLanguage: selectedLanguage,
                    ),
                  ),
                );

                if (result != null) {
                  setState(() {
                    selectedLanguage = result; // Update selected language
                  });
                }
              },
            ),
            _buildDivider(),
            _buildListTile(
              icon: Icons.brightness_6,
              title: 'Theme',
              subtitle: 'Select Theme',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ThemeScreen()),
                );
              },
            ),
            _buildDivider(),
            _buildListTile(
              icon: Icons.lock,
              title: 'Security',
              subtitle: 'Fingerprint',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Security()),
                );
              },
            ),
            _buildDivider(),
            _buildListTile(
              icon: Icons.notifications,
              title: 'Notification',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyNotification()),
                );
              },
            ),
            _buildDivider(),
            _buildListTile(
              icon: Icons.info,
              title: 'About',
              onTap: () {},
            ),
            _buildDivider(),
            _buildListTile(
              icon: Icons.phone,
              title: 'Contact Us',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Contact()),
                );
              },
            ),
          ],
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
              default:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyBalance()),
                );
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

  Widget _buildListTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required void Function() onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xff272e81)),
      title: Text(title),
      subtitle: subtitle != null
          ? Text(subtitle, style: const TextStyle(color: Colors.white))
          : null,
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return const Divider(height: 20);
  }
}
