import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();
  final favoriteFoodController = TextEditingController();
  final favoriteMovieController = TextEditingController();
  final campusResidenceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/placeholder.png'),
              ),
              // SizedBox(height: 16),
              // TextField(
              //   controller: nameController,
              //   decoration: InputDecoration(
              //     labelText: 'Name',
              //   ),
              // ),
              TextField(
                controller: ageController,
                decoration: InputDecoration(
                  labelText: 'Age',
                ),
              ),
              // TextField(
              //   controller: emailController,
              //   decoration: InputDecoration(
              //     labelText: 'Email',
              //   ),
              // ),
              TextField(
                controller: favoriteFoodController,
                decoration: InputDecoration(
                  labelText: 'Favorite Food',
                ),
              ),
              TextField(
                controller: favoriteMovieController,
                decoration: InputDecoration(
                  labelText: 'Favorite Movie',
                ),
              ),
              TextField(
                controller: campusResidenceController,
                decoration: InputDecoration(
                  labelText: 'Campus Residence',
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                child: Text('Save Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
