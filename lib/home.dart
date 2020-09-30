import 'package:first_app/home01.dart';
import 'package:first_app/menu.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  String canteenName;
  String userID='a@bcom';
  MyHomePage(this.canteenName,this.userID);


  @override
  _MyHomePageState createState() => _MyHomePageState(canteenName,userID);
}

class _MyHomePageState extends State<MyHomePage> {
     String canteenName= '',userID;
     _MyHomePageState(this.canteenName,this.userID);
    Future<SharedPreferences> _pref = SharedPreferences.getInstance();
    @override
    void initState() {
     _pref.then((value) {
       setState(() {
         //canteenName = value.getString('canteenCurrent');
         print(canteenName);
       });
     });
      // TODO: implement initState
      super.initState();
    }

  int _currentindex = 0;

  // var tabs = [
  //   Center(child: Homedish(canteenName)),
  //   Center(child: Menu(canteenName)),
  //   Center(child: Text('profile')),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        title: Text('WELCOME TO DELICEUS'),
      ),*/
      body: IndexedStack(
        index: _currentindex,
          children: [
            Homedish(canteenName,userID),
            Menu(canteenName,userID),
        Text('Profile')

          ],),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentindex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            //backgroundColor: Colors.blue),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: 'Menu',
            //backgroundColor: Colors.black),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Profile',
            //backgroundColor: Colors.green),
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentindex = index;
          });
        },
      ),
    );
  }
}
