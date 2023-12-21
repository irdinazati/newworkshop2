import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workshopnew/auth/authenticationService.dart';
import '../constants/constants.dart';
import '../model/feedModel.dart';
import '../model/usermodel.dart';
import '../services/databaseServices.dart';
import '../widget/feedContainer.dart';
import 'addFeedPage.dart';
import 'settingPage.dart';
import 'package:provider/provider.dart';
class MainFeedPage extends StatefulWidget {
  final String currentUserId;

  const MainFeedPage({required this.currentUserId});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainFeedPage> {
  int _selectedTab = 0; // Initialize the selected tab index
  List _followingFeeds = [];
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
    // Clear user data - You can use your method to clear user data here
    //_clearUserData();
  }

  setupFollowingTweets() async {
    setState(() {
      _loading = true;
    });
    List followingFeeds = await DatabaseServices.getHomeFeeds(widget.currentUserId);
    if (mounted) {
      setState(() {
        _followingFeeds = followingFeeds;
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setupFollowingTweets();
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthenticationService>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        title: Text(
          'AutiTrack',
          style: TextStyle(
            color: AutiTrackColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: _openSettings,
            color: AutiTrackColor,
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
            color: Colors.green[300],
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () {
          authService.signOut();
        },
)         ],
        ),
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddFeedPage(
                currentUserId: widget.currentUserId,
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        children: [
          _loading ? LinearProgressIndicator() : SizedBox.shrink(),
          SizedBox(height: 5),
          // Your other body elements
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
        onTap: (index) {
          setState(() {
            _selectedTab = index;
            if (index == 1) { // Check if the tapped index corresponds to the "Message" tab
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddFeedPage(
                    currentUserId: widget.currentUserId,
                  ),
                ),
              );
            }
          });
        },
        activeColor: Colors.green[200],
        currentIndex: _selectedTab,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.message)),
          BottomNavigationBarItem(icon: Icon(Icons.mood)),
          BottomNavigationBarItem(icon: Icon(Icons.person)),
        ],
      ),

    );
  }
}
