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
  bool isSecurityNotificationsEnabled =
      true; // Initial state for Security Notifications

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true, // Center the title
          title: const Text(
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
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            const SizedBox(height: 30),
            ListTile(
              leading: const Icon(Icons.lock_outline, color: Color(0xff272e81)),
              title: const Text('Lock Screen'),
              trailing: Switch(
                value: isLockScreenEnabled,
                onChanged: (value) {
                  setState(() {
                    isLockScreenEnabled = value; // Update the state
                  });
                },
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.fingerprint, color: Color(0xff272e81)),
              title: const Text('Fingerprint'),
              trailing: Switch(
                value: isFingerprintEnabled,
                onChanged: (value) {
                  setState(() {
                    isFingerprintEnabled = value; // Update the state
                  });
                },
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.face, color: Color(0xff272e81)),
              title: const Text('Face ID'),
              trailing: Switch(
                value: isFaceIdEnabled,
                onChanged: (value) {
                  setState(() {
                    isFaceIdEnabled = value; // Update the state
                  });
                },
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.security, color: Color(0xff272e81)),
              title: const Text('App Pin'),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
              onTap: () {}, // Define the action for App Pin
            ),
            const Divider(),
            ListTile(
              leading:
                  const Icon(Icons.notifications, color: Color(0xff272e81)),
              title: const Text('Security Notifications'),
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
