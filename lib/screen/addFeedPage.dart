import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:workshopnew/screen/settingPage.dart';

import '../Constants/Constants.dart';
import 'mainFeedPage.dart';

class AddFeedPage extends StatefulWidget {
  final String currentUserId;

  const AddFeedPage({Key? key, required this.currentUserId}) : super(key: key);

  @override
  _AddFeedPageState createState() => _AddFeedPageState();
}

class _AddFeedPageState extends State<AddFeedPage> {
  late String _feedText = '';
  File? _pickedImage;
  bool _loading = false;

  void _openSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingPage()),
    );
  }

  // Function to handle logout
  void _logout() {
    Navigator.pushReplacementNamed(context, '/login');
    _clearUserData(); // Call your method to clear user data here
  }
  void _clearUserData() {
    // Implement code to clear user-related data based on currentUserId
    // For example:
    // Clearing user-specific tokens
    // AuthService.clearUserTokens(currentUserId);

    // Clearing cached data for that user
    // CacheService.clearUserData(currentUserId);

    // Resetting preferences for that user
    // PreferencesService.resetUserPreferences(currentUserId);
  }



  Future<void> handleImageFromGallery() async {
    try {
      final ImagePicker _picker = ImagePicker();
      final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          _pickedImage = File(pickedImage.path);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void hideKeyboard() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green[200],
        centerTitle: true,
        title: Text(
          'Feed',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        // Add an AppBar with a back button
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: _openSettings,
            color: AutiTrackColor, // Adjust the color as needed
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: AutiTrackColor, // Adjust color as needed
              ),
              child: Text(
                'Navigation Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainFeedPage(
                      currentUserId: widget.currentUserId,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Feed'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddFeedPage(
                      currentUserId: widget.currentUserId,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Message'),
              onTap: () {
                // Implement functionality for the Message option
                // For example, navigating to a different page
              },
            ),
            ListTile(
              title: Text('Activity'),
              onTap: () {
                // Implement functionality for the Activity option
                // For example, showing a dialog box
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Activity"),
                      content: Text("Activity functionality to be implemented."),
                      actions: <Widget>[
                        TextButton(
                          child: Text("Close"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            ListTile(
              title: Text('Account'),
              onTap: () {
                // Implement functionality for the Account option
                // For example, executing an action
              },
            ),
            // Divider to separate from other options
            Divider(thickness: 1, color: Colors.grey),

            // Logout option
            ListTile(
              title: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.green[300], // Change the color for emphasis
                  fontWeight: FontWeight.bold, // Bold text for emphasis
                ),
              ),
              onTap: () {
                _logout();
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 20),
            TextField(
              maxLength: 280,
              maxLines: 7,
              decoration: InputDecoration(
                hintText: 'What is on your mind?',
              ),
              onChanged: (value) {
                setState(() {
                  _feedText = value;
                });
              },
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: handleImageFromGallery,
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.green, // Replace with your desired color
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      size: 50,
                      color: Colors.green[200], // Replace with your desired color
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: hideKeyboard,
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.green, // Replace with your desired color
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.keyboard_hide,
                      size: 40,
                      color: Colors.green[200],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  _loading = true;
                });
                // Your logic to handle posting feed goes here
                // For brevity, I'm omitting the implementation
                setState(() {
                  _loading = false;
                });
              },
              child: Text('Post'),
            ),
            SizedBox(height: 20),
            _loading ? CircularProgressIndicator() : SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}