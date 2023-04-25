import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finals1/Models/Tweet.dart';
import 'package:finals1/Screens/FeedScreen.dart';
import 'package:finals1/Services/StorageService.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:finals1/Constants/Constants.dart';
import 'package:finals1/Services/DatabaseServices.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostScreen extends StatefulWidget {
  final String currentUserId;

  const CreatePostScreen({super.key, required this.currentUserId});



  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  late String _tweetText;
  late String _emailText;
  late File _pickedImage=File('assets/placeholder.png');
  bool _loading=false;
  final picker=ImagePicker();


  handleImageFromGallery() async{
    try{
      File imageFile = (await ImagePicker().pickImage(source: ImageSource.gallery) as File);

      if(imageFile != null){
        setState(() {
          _pickedImage=imageFile;
        });
      }
    } catch(e) {
      print(e);
    }
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: KTweeterColor,
        centerTitle: true,
        title: Text(
          'Your Thoughts',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              width: 800,
              height:400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border:Border.all(color: Colors.grey)
              ),
              child: TextField(
                maxLength: 280,
                maxLines: 7,
                decoration: InputDecoration(
                  hintText: "What's on your mind?",
                  border:InputBorder.none,
                  contentPadding: EdgeInsets.all(10)
                ),
                onChanged: (value) {
                  _tweetText = value;
                },
              ),
            ),
            Container(

              height: 50,
              decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(10),
                  border:Border.all(color: Colors.grey)
              ),
              child: TextField(
                maxLength: 280,
                maxLines: 7,
                decoration: InputDecoration(
                    hintText: "Who's talking?",
                    border:InputBorder.none,
                    contentPadding: EdgeInsets.all(10)
                ),
                onChanged: (value) {
                  _emailText = value;
                },
              ),
            ),
            SizedBox(height: 10),
            _pickedImage == null
                ? SizedBox.shrink()
                : Column(
              children: [
                // Container(
                //   height: 200,
                //   decoration: BoxDecoration(
                //       // color: KTweeterColor,
                //       image: DecorationImage(
                //         fit: BoxFit.cover,
                //         image: FileImage(_pickedImage),
                //       )),
                // ),
                SizedBox(height: 20),
              ],
            ),
            GestureDetector(
              onTap: handleImageFromGallery,
              child: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(
                    color: KTweeterColor,
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.camera_alt,
                  size: 50,
                  color: KTweeterColor,
                ),
              ),
            ),
            SizedBox(height: 20),

            ElevatedButton(

              onPressed: () async {
                setState(() {
                  _loading = true;
                });
                if (_tweetText != null && _tweetText.isNotEmpty) {
                  String image;
                  if (_pickedImage == null) {
                    image = '';
                  } else {
                    image =
                    await StorageService.uploadTweetPicture(_pickedImage);
                  }
                  Tweet tweet = Tweet(
                    text: _tweetText,
                    image: image,
                    authorId: widget.currentUserId,
                    likes: 0,
                    retweets: 0,
                    timestamp: Timestamp.fromDate(
                      DateTime.now(),
                    ), id: '',
                  );
                  DatabaseServices.createTweet(tweet);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>FeedScreen(currentUserId: 'RBWBlwsgxTNYFLUrC9XCO690Wix2')));
                }
                setState(() {
                  _loading = false;
                });
              },
              child: Text("Tell Everybody"),
            ),
            SizedBox(height: 20),
            _loading ? CircularProgressIndicator() : SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
