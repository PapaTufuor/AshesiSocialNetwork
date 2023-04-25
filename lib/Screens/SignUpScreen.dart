import 'package:finals1/Screens/ProfileScreen.dart';
import 'package:finals1/Screens/WelcomeScreen.dart';
import 'package:finals1/Services/auth_service.dart';
import 'package:finals1/Widgets/RoundedButton.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late String _email;
  late String _password;
  late String _name;
  late String _dob;
  late String _yearGroup;
  bool _hasCampusResidence=false;
  late String _favoriteFood;
  late String _favoriteMovie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF44336) ,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Sign Up",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center ,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter your Full Name",
                ),
                onChanged: (value){
                  _name=value;
                },
              ),
              SizedBox(height: 30),
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter your email",
                ),
                onChanged: (value){
                  _email=value;
                },
              ),
              SizedBox(height: 30),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Enter your password",
                ),
                onChanged: (value){
                  _password=value;
                },
              ),
              const SizedBox(height: 30),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter your Date of Birth',
                ),
                onChanged: (value) {
                  _dob = value;
                },
              ),
              SizedBox(height: 30),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your Year Group',
                ),
                onChanged: (value) {
                  _yearGroup = value;
                },
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Checkbox(
                    value: _hasCampusResidence,
                    onChanged: (value) {
                      setState(() {
                        _hasCampusResidence = value!;
                      });
                    },
                  ),
                  const Text('Do you have On Campus Residence?'),
                ],
              ),
              SizedBox(height: 30),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter your Favorite Food',
                ),
                onChanged: (value) {
                  _favoriteFood = value;
                },
              ),
              const SizedBox(height: 30),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter your Favorite Movie',
                ),
                onChanged: (value) {
                  _favoriteMovie = value;
                },
              ),
              SizedBox(height:40),

              ElevatedButton(onPressed: () async {
                bool isValid= await AuthService.signUp(
                    _name,
                    _email,
                    _password);
                if(isValid){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>WelcomeScreen()));
                } else{
                  print("something went wrong");
                }

              }, child: Text("Sign Up"))


            ],
          ),
        ),
      ),
    );
  }
}
