import 'package:finals1/Constants/Constants.dart';
import 'package:finals1/Screens/HomeScreen.dart';
import 'package:finals1/Screens/NotificationScreen.dart';
import 'package:finals1/Screens/ProfileScreen.dart';
import 'package:finals1/Screens/SearchScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class FeedScreen extends StatefulWidget {

  final String currentUserId;
  const FeedScreen({Key? key, required this.currentUserId}) : super(key: key);



  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {

   int _selectedTab =0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:[
        const HomeScreen(currentUserId: 'RBWBlwsgxTNYFLUrC9XCO690Wix2'),

        const SearchScreen(
          currentUserId: 'RBWBlwsgxTNYFLUrC9XCO690Wix2',
        ),
        NotificationScreen(
          currentUserId: widget.currentUserId,
        ),
        ProfileScreen (
          currentUserId:widget.currentUserId,
          visitedUserId: widget.currentUserId,
        ),
      ].elementAt(_selectedTab),
      bottomNavigationBar: CupertinoTabBar(
          onTap: (index){
            setState(() {
              _selectedTab=index;
            });
          },
            activeColor: KTweeterColor,
            currentIndex: _selectedTab,
          items:const [
            BottomNavigationBarItem(icon: Icon(Icons.home),),
            BottomNavigationBarItem(icon: Icon(Icons.search)),
            BottomNavigationBarItem(icon: Icon(Icons.notifications)),
            BottomNavigationBarItem(icon: Icon(Icons.person)),
          ],
      ),

    );
  }
}
