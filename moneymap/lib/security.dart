import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class Security extends StatefulWidget {
  const Security({super.key});

  @override
  State<Security> createState() => _SecurityState();
}

class _SecurityState extends State<Security> {
  // Define boolean variables to track the state of each switch
  bool isLockScreenEnabled = true; // Initial state for Lock Screen
  bool isFingerprintEnabled = true; // Initial state for Fingerprint
  bool isFaceIdEnabled = false; // Initial state for Face ID
  bool isSecurityNotificationsEnabled = true; // Initial state for Security Notifications

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true, // Center the title
          title: Text(
            'Security',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.grey[700],
              size: 28,
            ),
            onPressed: () {
              Navigator.pop(context);
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
            ListTile(
              leading: Icon(Icons.lock_outline, color: Colors.purple),
              title: Text('Lock Screen'),
              trailing: Switch(
                value: isLockScreenEnabled,
                onChanged: (value) {
                  setState(() {
                    isLockScreenEnabled = value; // Update the state
                  });
                },
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.fingerprint, color: Colors.purple),
              title: Text('Fingerprint'),
              trailing: Switch(
                value: isFingerprintEnabled,
                onChanged: (value) {
                  setState(() {
                    isFingerprintEnabled = value; // Update the state
                  });
                },
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.face, color: Colors.purple),
              title: Text('Face ID'),
              trailing: Switch(
                value: isFaceIdEnabled,
                onChanged: (value) {
                  setState(() {
                    isFaceIdEnabled = value; // Update the state
                  });
                },
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.security, color: Colors.purple),
              title: Text('App Pin'),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
              onTap: () {}, // Define the action for App Pin
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.notifications, color: Colors.purple),
              title: Text('Security Notifications'),
              trailing: Switch(
                value: isSecurityNotificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    isSecurityNotificationsEnabled = value; // Update the state
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
