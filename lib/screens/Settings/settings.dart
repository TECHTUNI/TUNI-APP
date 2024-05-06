import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuni_web/provider/product_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings Page'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Account Settings'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Notification Settings'),
            onTap: () {
              // Add functionality to navigate to notification settings
            },
          ),
          ListTile(
            title: Text('Privacy Settings'),
            onTap: () {
              // Add functionality to navigate to privacy settings
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: Text('Log out'),
            onTap: () {
              // Add functionality to navigate to privacy settings
            },
          ),
          // Add more ListTiles as needed for other settings
        ],
      ),
    );
  }
}
