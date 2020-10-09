import 'package:firebase_database/firebase_database.dart';
import 'package:first_app/config/config.dart';
import 'package:flutter/material.dart';


class Profile extends StatefulWidget {
  Map userData;
  Profile(this.userData);
  @override
  _ProfileState createState() => _ProfileState(userData);
}

class _ProfileState extends State<Profile> {
  Map userData;
  _ProfileState(this.userData);
  DatabaseReference dRef = FirebaseDatabase.instance.reference();
  @override
  void initState() {
    print(userData);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print(userData);
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  height: 300,
                  width: 200,
                  image: NetworkImage('${userData['url']}'),
                ),
                Text(userData['name']),
                SizedBox(height: 10,),
                Text(userData['email']),
                SizedBox(height: 10,),
                Text(userData['department']),
                SizedBox(height: 10,),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
