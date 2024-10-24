import 'package:flutter/material.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key});

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  ThemeMode _themeMode = ThemeMode.system; // Track selected theme mode

  void _changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Select Theme'),
          backgroundColor: Colors.purple,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Return to the previous screen
            },
          ),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          children: [
            ListTile(
              title: Text('Light Theme'),
              leading: Radio<ThemeMode>(
                value: ThemeMode.light,
                groupValue: _themeMode,
                onChanged: (ThemeMode? value) {
                  if (value != null) {
                    _changeTheme(value);
                    // You might want to save the theme choice here
                    Navigator.pop(context, value); // Return the selected theme
                  }
                },
              ),
            ),
            ListTile(
              title: Text('Dark Theme'),
              leading: Radio<ThemeMode>(
                value: ThemeMode.dark,
                groupValue: _themeMode,
                onChanged: (ThemeMode? value) {
                  if (value != null) {
                    _changeTheme(value);
                    // You might want to save the theme choice here
                    Navigator.pop(context, value); // Return the selected theme
                  }
                },
              ),
            ),
            ListTile(
              title: Text('System Default'),
              leading: Radio<ThemeMode>(
                value: ThemeMode.system,
                groupValue: _themeMode,
                onChanged: (ThemeMode? value) {
                  if (value != null) {
                    _changeTheme(value);
                    // You might want to save the theme choice here
                    Navigator.pop(context, value); // Return the selected theme
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
