import 'package:flutter/material.dart';

class notification extends StatefulWidget {
  const notification({super.key});

  @override
  State<notification> createState() => _NotificationState();
}

class _NotificationState extends State<notification> {
  bool _expenseAlertEnabled = true;
  bool _budgetAlertEnabled = true;
  bool _tipsAndArticlesEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Notifications',
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
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        children: [
          SizedBox(height: 30),
          _buildNotificationTile(
            icon: Icons.notifications,
            title: 'Expense Alert',
            subtitle: 'Get notified about your expenses',
            value: _expenseAlertEnabled,
            onChanged: (value) {
              setState(() {
                _expenseAlertEnabled = value;
              });
            },
          ),
          _buildDivider(),
          _buildNotificationTile(
            icon: Icons.monetization_on,
            title: 'Budget',
            subtitle: 'Get notified when you\'re exceeding your budget limit',
            value: _budgetAlertEnabled,
            onChanged: (value) {
              setState(() {
                _budgetAlertEnabled = value;
              });
            },
          ),
          _buildDivider(),
          _buildNotificationTile(
            icon: Icons.lightbulb_outline,
            title: 'Tips & Articles',
            subtitle: 'Small & useful pieces of practical financial advice',
            value: _tipsAndArticlesEnabled,
            onChanged: (value) {
              setState(() {
                _tipsAndArticlesEnabled = value;
              });
            },
          ),
          _buildDivider(),
        ],
      ),
    );
  }

  Widget _buildNotificationTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.purple),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(height: 20);
  }
}
