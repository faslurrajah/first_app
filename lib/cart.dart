import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:first_app/cartdb.dart';
import 'package:first_app/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/cart.dart';

class Mycart extends StatefulWidget {
  DatabaseReference dRef = FirebaseDatabase.instance.reference();
  String userID,canteenName;
  Mycart(this.canteenName,this.userID);
  @override
  _MycartState createState() => _MycartState(canteenName,userID);
}

class _MycartState extends State<Mycart> {
  String userID, canteenName;

  _MycartState(this.canteenName, this.userID);

  //final _store = Store();
  DatabaseReference dRef ;
  Map cartData = {'ggg': {'price': 0}};
  List keys = [];
  int totalCost=0;

  @override
  void initState() {
    Firebase.initializeApp();
    dRef = FirebaseDatabase.instance.reference();
    // TODO: implement initState
    super.initState();
    dRef.child('cart').child(canteenName).child(userID).once().then((value) {
      Map val = value.value;
      print(val);
      setState(() {
        cartData = val;
        val.forEach((key, value) {
          keys.add(key);
          int tempPrice= int.parse(value['price']);
          totalCost = totalCost + (tempPrice );

        });
        cartData.forEach((key, value) { cartData[key]['q'] = 1;});
      });
      //
      print(val);
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).push(new CupertinoPageRoute(
                builder: (BuildContext context) =>
                    MyHomePage(canteenName, userID)));
          },
        ),
      ),
      body: Center(
        // color: Colors.grey[200],
        child:Column(
//  mainAxisSize: MainAxisSize.max,
//  mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
// scrollDirection: Axis.horizontal,
                  itemCount: keys.length,
                  itemBuilder: (context, index) {
                    var count=1;
                    return Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: InkWell(
                                splashColor: Colors.blue.withAlpha(30),
                                child: Container(
                                  height: 100,
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      children: <Widget>[
// Spacer(),
                                        SizedBox(width: 10,),
                                        new Text(
                                          cartData[keys[index]]['itemName'],
                                          style: TextStyle(
                                            fontSize: 20,
                                              fontWeight:
                                              FontWeight.bold),
                                        ),
                                        //Spacer(),
                                        new Text(
                                          cartData[keys[index]]['price'],
                                          style: TextStyle(
                                            fontSize: 20,
                                              fontWeight:
                                              FontWeight.bold),
                                        ),
                                        Row(
                                          children: [
                                            IconButton(icon: Icon(Icons.remove), onPressed: (){
                                              setState(() {
                                               if(cartData[keys[index]]['q'] >= 1 ){
                                                 cartData[keys[index]]['q'] = cartData[keys[index]]['q']-1;
                                                 print(cartData[keys[index]]['q']);
                                                 //print(cartData[keys[index]]['price'] * cartData[keys[index]]['q']);
                                                 int tempPrice= int.parse(cartData[keys[index]]['price']);
                                                 int tempQ = cartData[keys[index]]['q'];
                                                 print(tempQ*tempPrice);
                                                 totalCost = totalCost - (tempPrice);
                                               }
                                                  });
                                            },),

                                            CircleAvatar(child: Text('${cartData[keys[index]]['q']}'),),
                                            IconButton(icon: Icon(Icons.add), onPressed: (){
                                              setState(() {
                                                  cartData[keys[index]]['q'] = cartData[keys[index]]['q']+1;
                                                  print(cartData[keys[index]]['q']);
                                                  //totalCost=totalCost + cartData[keys[index]]['q'] * cartData[keys[index]]['price'];
                                                  int tempPrice= int.parse(cartData[keys[index]]['price']);
                                                  int tempQ = cartData[keys[index]]['q'];
                                                  print(tempQ*tempPrice);
                                                  totalCost = totalCost + (tempPrice);

                                              });
                                            },),
                                          ],
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.delete),
                                          color: Colors.redAccent,
                                          onPressed: () {
                                            dRef.child('cart').child(canteenName).child(userID).child(keys[index]).set(null);
                                            Navigator.of(context).pushReplacement(new CupertinoPageRoute(
                                                builder: (BuildContext context) => Mycart(canteenName,userID)));
                                            // _store.deleteProduct(
                                            //     CarT[index].piID);
                                          },
                                        )
                                      ],
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
            new Container(
              width: 150.0,
              height: 50,
              padding: const EdgeInsets.only(top: 16.0),
              child: Center(child: Text('$totalCost',style: TextStyle(fontSize: 20),)),
            ),
            new Container(
              width: 400.0,
              padding: const EdgeInsets.only(top: 16.0),
              child: new RaisedButton(
                child: new Text("Send Order",
                    style: new TextStyle(
                      color: Colors.black,
                    )),
                colorBrightness: Brightness.dark,
                onPressed: () {
                  cartData.forEach((key, value) {
                    if(value['q']!=0) {
                      int tempPrice= int.parse(value['price']);
                      int tempQ= value['q'];
                      var itemCost=0;
                      itemCost = itemCost + (tempPrice*tempQ );
                      dRef.child('orders').child(canteenName).child(userID).child(value['itemName']).set(
                          {
                            'p' : value['price'],
                            'q' : value['q'],
                            't' : itemCost
                          }
                      );
                    }
                  });

                    print(cartData);
                },
                color: Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// }