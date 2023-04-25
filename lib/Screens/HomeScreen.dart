import 'package:finals1/Constants/Constants.dart';
import 'package:finals1/Screens/CreatePostScreen.dart';
import 'package:flutter/material.dart';
import 'package:finals1/Models/Tweet.dart';
import 'package:finals1/Models/UserModel.dart';
import 'package:finals1/Services/DatabaseServices.dart';
import 'package:finals1/Widgets/PostContainer.dart';


class HomeScreen extends StatefulWidget {
  final String currentUserId;

  const HomeScreen({super.key, required this.currentUserId});



  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List _followingTweets=[];
  bool _loading=false;

  buildTweets(Tweet tweet,UserModel author){
    return Container(
      padding: EdgeInsets.symmetric(horizontal:15),
      child: PostContainer(
          tweet: tweet,
          author: author,
          currentUserId: widget.currentUserId,

      ),
    );
  }

    showFollowingTweets(String currentUserId){
      List<Widget> followingTweetsList=[];
      for(Tweet tweet in _followingTweets) {
        followingTweetsList.add(FutureBuilder(
            future: usersRef.doc(tweet.authorId).get(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if (snapshot.hasData){
                UserModel author= UserModel.fromDoc(snapshot.data);
                return buildTweets(tweet, author);
              } else{
                return SizedBox.shrink();
              }
            }));
      }
      return followingTweetsList;
    }


    setupFollowingTweets() async{
    setState(() {
      _loading=true;
    });
    List followingTweets =
        await DatabaseServices.getHomeTweets(widget.currentUserId);
      if(mounted){
        setState(() {
          _followingTweets=followingTweets;
          _loading=false;
        });
      }
    }
  @override

  void initState(){
    super.initState();
    setupFollowingTweets();
  }
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Image.asset('assets/voice.png'),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CreatePostScreen(
                      currentUserId: widget.currentUserId,
                    )));
          },
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          centerTitle: true,
          leading: Container(
            height: 40,
            child: Image.asset('assets/logo.jpg'),
          ),
          title: Text(
            'Home Screen',
            style: TextStyle(
              color: KTweeterColor,
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () => setupFollowingTweets(),
          child: ListView(
            physics: BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            children: [
              _loading ? LinearProgressIndicator() : SizedBox.shrink(),
              SizedBox(height: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 5),
                  Column(
                    children: _followingTweets.isEmpty && _loading == false
                        ? [
                      SizedBox(height: 5),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Text(
                          'There is No New Tweets',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      )
                    ]
                        : showFollowingTweets(widget.currentUserId),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
