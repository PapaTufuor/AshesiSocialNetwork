import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_storage/firebase_storage.dart';

const Color KTweeterColor=Color(0xffb0414a);

final _fireStore=FirebaseFirestore.instance;

final usersRef= _fireStore.collection('users');
final followersRef= _fireStore.collection('followers');

final followingRef= _fireStore.collection('following');

final storageRef = FirebaseStorage.instance.ref();

final tweetsRef = _fireStore.collection('tweets');

final feedRefs = _fireStore.collection('feeds');

final likesRef = _fireStore.collection('likes');

final activitiesRef = _fireStore.collection('activities');
