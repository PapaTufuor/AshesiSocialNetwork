import 'package:flutter/material.dart';
import 'package:finals1/Constants/Constants.dart';
import 'package:finals1/Models/Tweet.dart';
import 'package:finals1/Models/UserModel.dart';
import 'package:finals1/Services/DatabaseServices.dart';

class PostContainer extends StatefulWidget {

  final Tweet tweet;
  final UserModel author;
  final String currentUserId;


  const PostContainer({Key? key, required this.tweet, required this.author, required this.currentUserId}) : super(key: key);

  @override
  State<PostContainer> createState() => _PostContainerState();
}

class _PostContainerState extends State<PostContainer> {
  int _likesCount = 0;
  bool _isLiked = false;

  initTweetLikes() async{
    bool isLiked =
        await DatabaseServices.isLikeTweet(widget.currentUserId, widget.tweet);
    if (mounted){
      setState(() {
        _isLiked=isLiked;
      });
    }

  }

  likeTweet(){
    if(_isLiked) {
      DatabaseServices.unlikeTweet(widget.currentUserId, widget.tweet);
      setState(() {
        _isLiked=false;
        _likesCount--;
      });
    }else{
      DatabaseServices.likeTweet(widget.currentUserId, widget.tweet);
      setState(() {
        _isLiked=true;
        _likesCount++;
      });
    }
  }

      @override
      void initState(){
        super.initState();
        _likesCount=widget.tweet.likes;
        initTweetLikes();
      }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                child:FadeInImage(
                  placeholder: AssetImage('assets/placeholder.png'),
                  image: NetworkImage(widget.author.profilePicture),
                ),
              ),
              SizedBox(width: 10),
              Text(
                widget.author.name,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Text(
            widget.tweet.text,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          widget.tweet.image.isEmpty
              ? SizedBox.shrink()
              : Column(
            children: [
              SizedBox(height: 15),
              Container(
                height: 250,
                decoration: BoxDecoration(
                    color: KTweeterColor,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.tweet.image),
                    )),
              )
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      _isLiked ? Icons.favorite : Icons.favorite_border,
                      color: _isLiked ? Colors.blue : Colors.black,
                    ),
                    onPressed: likeTweet,
                  ),
                  Text(
                    _likesCount.toString() + ' Likes',
                  ),
                ],
              ),
              Text(
                widget.tweet.timestamp.toDate().toString().substring(0, 19),
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
          SizedBox(height: 10),
          Divider()
        ],
      ),


    );
  }
}