import 'package:flutter/material.dart';
import 'package:finals1/Constants/Constants.dart';
import 'package:finals1/Models/Activity.dart';
import 'package:finals1/Models/UserModel.dart';
import 'package:finals1/Services/DatabaseServices.dart';

class NotificationScreen extends StatefulWidget {
  final String currentUserId;

  const NotificationScreen({Key? key, required this.currentUserId}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Activity> _activities =[];


  setupActivities() async{
    List<Activity> activities =
        await DatabaseServices.getActivities(widget.currentUserId);
    if(mounted) {
      setState(() {
        _activities=_activities;
      });
    }

  }


  buildActivity(Activity activity) {
    return FutureBuilder(
      future: usersRef.doc(activity.fromUserId).get(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(!snapshot.hasData){
          return SizedBox.shrink();
        } else{
          UserModel user = UserModel.fromDoc(snapshot.data);
          return Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 20,
                 child:FadeInImage(
                    placeholder: AssetImage('assets/placeholder.png'),
                    image: NetworkImage(user.profilePicture),
                 ),),

                title: activity.follow == true
                    ? Text('${user.name} follows you')
                    : Text('${user.name} liked your tweet'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Divider(
                  color: KTweeterColor,
                  thickness: 1,
                ),
              )
            ],
          );
        }
      });
  }

  @override
  void initState(){
    super.initState();
    setupActivities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: KTweeterColor,
          centerTitle: true,
          elevation: 0.5,
          title: Text(
            'Notifications',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () => setupActivities(),
          child: ListView.builder(
              itemCount: _activities.length,
              itemBuilder: (BuildContext context, int index) {
                Activity activity = _activities[index];
                return buildActivity(activity);
              }),
        ));
  }
}

