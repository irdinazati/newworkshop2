import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constants/Constants.dart';

class SettingPage extends StatelessWidget {
  void handleTelegramSettings() {
    // Add logic for handling Telegram settings here
  }

  void handleAlertNotificationSettings() {
    // Add logic for handling alert notification settings here
  }

  void handleLogout() {
    // Add logic for handling the logout action here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: AutiTrackColor, // Use your color constant here
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ElevatedButton(
            onPressed: handleTelegramSettings,
            child: Text('Account', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              primary: AutiTrackColor, // Use your color constant here
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: handleAlertNotificationSettings,
            child: Text('Edit Profile', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              primary: AutiTrackColor, // Use your color constant here
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Add functionality for Notifications button
            },
            child: Text('Notifications', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              primary: AutiTrackColor, // Use your color constant here
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: handleAlertNotificationSettings,
            child: Text('Info', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              primary: AutiTrackColor, // Use your color constant here
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: handleLogout,
            child: Text('Logout', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              primary: AutiTrackColor, // Use your color constant here
            ),
          ),
        ],
      ),
    );
  }
}
