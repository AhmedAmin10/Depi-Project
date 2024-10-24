import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:moneymap/contact.dart';
import 'package:moneymap/currancy.dart';
import 'package:moneymap/language.dart';
import 'package:moneymap/security.dart';
import 'package:moneymap/notification.dart'; // Import the Notification screen
import 'theme.dart'; // Import the theme screen

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String selectedLanguage = 'English'; // Track selected language
  String selectedCurrency = 'USD'; // Default currency

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Settings',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.grey[700],
              size: 28,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Settings()),
              );
            },
          ),
          actions: [
            IconButton(
              icon: Icon(
                LucideIcons.search,
                color: Colors.grey[700],
                size: 28,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                LucideIcons.bellDot,
                color: Colors.grey[700],
                size: 28,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          children: [
            SizedBox(height: 30),
            _buildListTile(
              icon: Icons.attach_money,
              title: 'Currency',
              subtitle: selectedCurrency, // Show the selected currency here
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Currency()),
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
                  MaterialPageRoute(builder: (context) => ThemeScreen()),
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
                  MaterialPageRoute(builder: (context) => Security()),
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
                  MaterialPageRoute(builder: (context) => notification()),
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
                  MaterialPageRoute(builder: (context) => Contact()),
                );
              },
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
      leading: Icon(icon, color: Colors.purple),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle, style: TextStyle(color: Colors.grey)) : null,
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return Divider(height: 20);
  }
}
