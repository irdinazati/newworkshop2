// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:workshopnew/screen/settingPage.dart';
// import '../Constants/Constants.dart';
// import 'addFeedPage.dart';
// import 'mainFeedPage.dart';
//
// class Menu extends StatefulWidget {
//   final String currentUserId;
//
//   const Menu({Key? key, required this.currentUserId}) : super(key: key);
//
//   @override
//   _MenuState createState() => _MenuState();
// }
//
// class _MenuState extends State<Menu> {
//   int _selectedTab = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: [
//         MainFeedPage(
//           currentUserId: widget.currentUserId,
//         ),
//         AddFeedPage(
//           currentUserId: widget.currentUserId,
//         ),
//       ].elementAt(_selectedTab),
//       bottomNavigationBar: CupertinoTabBar(
//         onTap: (index) {
//           setState(() {
//             _selectedTab = index;
//           });
//         },
//         activeColor: Colors.green[200], // Replace with your desired color
//         currentIndex: _selectedTab,
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.home)),
//           BottomNavigationBarItem(icon: Icon(Icons.message)),
//           BottomNavigationBarItem(icon: Icon(Icons.mood)),
//           BottomNavigationBarItem(icon: Icon(Icons.person)),
//         ],
//       ),
//     );
//   }
// }