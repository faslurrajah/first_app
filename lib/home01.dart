import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:first_app/cart.dart';
import 'package:first_app/models/menu.dart';
import 'package:first_app/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:first_app/menu.dart';

// ignore: must_be_immutable
class Homedish extends StatefulWidget {
  String canteenName;
  String userID;
  Homedish(this.canteenName,this.userID);
  @override
  _HomedishState createState() => _HomedishState(canteenName,userID);
}

class _HomedishState extends State<Homedish> {
  String canteenName;
  String userID;
  _HomedishState(this.canteenName,this.userID);
  String pname;
  String pprice;
  Map products = {};
  List productNames=[];
  DatabaseReference dRef = FirebaseDatabase.instance.reference();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dRef.child('products').child(canteenName).once().then((value) {
      Map val = value.value;
      setState(() {
        products =  val;
        val.forEach((key, value) {
          productNames.add(key);
        });
      });

      print(val);
    });
  }
  @override
  CreateTodos() {

  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text('Delicious'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).push(new CupertinoPageRoute(
                  builder: (BuildContext context) => Mycart(canteenName,userID)));
            },
          )
        ],
      ),
      body: Center(
        // color: Colors.grey[200],
        child: Column(
          //  mainAxisSize: MainAxisSize.max,
          //  mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text(
                'TRENDING DISHES',
                textAlign: TextAlign.left,
                style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(310, 0, 50, 0),
              child: FlatButton(
                //color: Colors.white,
                textColor: Colors.blue,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.all(3.0),
                splashColor: Colors.green,
                onPressed: () {
                  Navigator.of(context).push(new CupertinoPageRoute(
                      builder: (BuildContext context) => Menu(canteenName,userID)));
                },
                child: Text(
                  "SEE ALL",
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
// scrollDirection: Axis.horizontal,
                  itemCount: productNames.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: InkWell(
                                splashColor: Colors.blue.withAlpha(30),
                                onTap: () {
                                  Navigator.of(context).push(
                                      new CupertinoPageRoute(
                                          builder:
                                              (BuildContext context) =>
                                              Prdoucts()));
                                },
                                child: Container(
                                  height: 132,
                                  child: Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 18.0),
                                          child: Container(
                                              child: Image.network(
                                                products[productNames[index]]['imageLink'],
                                                height: 100,
                                              )),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.all(14.0),
                                          child: Column(
                                            children: [
                                              Text('Product Name:'),
                                              new Text(
                                                productNames[index],
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                              Text('Product Price:'),
                                              new Text(
                                                '${products[productNames[index]]['price']}',
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                              //Spacer(),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 60.0),
                                          child: FlatButton(
                                            color: Colors.green,
                                            textColor: Colors.white,
                                            disabledColor: Colors.grey,
                                            disabledTextColor:
                                            Colors.black,
                                            padding: EdgeInsets.all(3.0),
                                            splashColor: Colors.green,
                                            onPressed: () {
                                              print(userID);
                                              dRef.child('cart').child(canteenName).child(userID).push().set({
                                                'itemName' : '${productNames[index]}',
                                                'price' : '${products[productNames[index]]['price']}'
                                              });
                                            },
                                            child: Text(
                                              "ADD TO CART",
                                              style: TextStyle(
                                                  fontSize: 12.0),
                                            ),
                                          ),
                                        ),
                                      ],
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
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text(
                'RECOMMENDED DISHES',
                textAlign: TextAlign.left,
                style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(310, 0, 10, 0),
              child: FlatButton(
                //color: Colors.white,
                textColor: Colors.blue,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.all(3.0),
                splashColor: Colors.green,
                onPressed: () {
                  Navigator.of(context).push(new CupertinoPageRoute(
                      builder: (BuildContext context) => Menu(canteenName,userID)));
                },
                child: Text(
                  "SEE ALL",
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
// scrollDirection: Axis.horizontal,
              shrinkWrap: true,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: InkWell(
                                splashColor: Colors.blue.withAlpha(30),
                                onTap: () {
                                  Navigator.of(context).push(
                                      new CupertinoPageRoute(
                                          builder:
                                              (BuildContext context) =>
                                              Prdoucts()));
                                },
                                child: Container(
                                  height: 132,
                                  child: Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 18.0),
                                          child: Container(
                                              child: Image.network(
                                                products[productNames[index]]['imageLink'],
                                                height: 100,
                                              )),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.all(14.0),
                                          child: Column(
                                            children: [
                                              Text('Product Name:'),
                                              new Text(
                                                productNames[index],
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                              Text('Product Price:'),
                                              new Text(
                                                '${products[productNames[index]]['price']}',
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                              //Spacer(),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 60.0),
                                          child: FlatButton(
                                            color: Colors.green,
                                            textColor: Colors.white,
                                            disabledColor: Colors.grey,
                                            disabledTextColor:
                                            Colors.black,
                                            padding: EdgeInsets.all(3.0),
                                            splashColor: Colors.green,
                                            onPressed: () {
                                              dRef.child('cart').child(canteenName).child(userID).push().set({
                                                'itemName' : '${productNames[index]}',
                                                'price' : '${products[productNames[index]]['price']}'
                                              });
                                            },
                                            child: Text(
                                              "ADD TO CART",
                                              style: TextStyle(
                                                  fontSize: 12.0),
                                            ),
                                          ),
                                        ),
                                      ],
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
          ],
        ),
      ),
    );
  }
}
