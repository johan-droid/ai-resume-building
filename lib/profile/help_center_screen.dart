import 'package:flutter/material.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Help Center"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          Text("Contact Us", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: Icon(Icons.phone),
              title: Text("Customer Support"),
              subtitle: Text("+91 12345 67890"),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.email),
              title: Text("Support Email"),
              subtitle: Text("help@rezoom.app"),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.location_on),
              title: Text("Office Address"),
              subtitle: Text("123 Tech Park, Bangalore, India"),
            ),
          ),
        ],
      ),
    );
  }
}