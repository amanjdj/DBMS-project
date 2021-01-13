import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:core';
import 'dart:convert';
import 'package:e_auction/login.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HomeCustomer extends StatefulWidget {
  @override
  _HomeCustomerState createState() => _HomeCustomerState();
}

class _HomeCustomerState extends State<HomeCustomer> {
  var itemdata;
  int custID;
  String custName;
  void getCustomer() async {
    String url = "http://127.0.0.1:5000/currentuser";
    http.Response response = await http.get(url);
    var user = jsonDecode(response.body);
    setState(() {
      custID = int.parse(user[0]);
      custName = user[1];
    });
    print(custName);
  }

  void getitems() async {
    String url = "http://127.0.0.1:5000/showitems";
    http.Response response = await http.get(url);
    setState(() {
      itemdata = jsonDecode(response.body);
    });

    for (int i = 0; i < itemdata.length; i++) {
      Post post = Post(
          itemdata[i]['amount'],
          itemdata[i]['datelimit'],
          itemdata[i]['detail'],
          itemdata[i]['imageUrl'],
          itemdata[i]['itemstatus'],
          itemdata[i]['name'],
          itemdata[i]['id']);
      postList.add(post);
    }
  }

  List<Post> postList = [];
  @override
  void initState() {
    super.initState();

    getitems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Welcome"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              void logout() async {
                String url = "http://127.0.0.1:5000/logout";
                http.Response response = await http.get(url);
                if (response.body.toString() == "loggedout") {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Login()));
                } else {
                  print("Error");
                }
              }

              logout();
            },
          )
        ],
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                width: 800,
                child: postList.length == 0
                    ? Text("No data")
                    : GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemCount: postList.length,
                        itemBuilder: (_, index) {
                          return MyUI(
                            postList[index].amount,
                            postList[index].date,
                            postList[index].detail,
                            postList[index].url,
                            postList[index].status,
                            postList[index].name,
                            postList[index].id,
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget MyUI(
    int amount,
    String date,
    String detail,
    String url,
    String status,
    String name,
    int id,
  ) {
    return Container(
      margin: EdgeInsets.all(20),
      height: 80,
      width: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: status == "over" ? Colors.black : Colors.green)),
      child: Column(
        children: [
          Container(
            color: Colors.grey,
            width: 300,
            child: Center(
              child: Text(
                name,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          Container(
            height: 200,
            width: 200,
            child: Image.network(url),
          ),
          Text(
            "Last Bid:₹ ${amount.toString()}",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
          Text("Detail: $detail"),
          Text("Last Date: ${date.toString()}"),
          Text("Current status: $status"),
          Container(
            child: status == "over"
                ? null
                : Column(
                    children: [
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              child: Container(
                                height: 20,
                                width: 60,
                                color: Colors.yellow,
                                child: Text("+100"),
                              ),
                              onTap: () {
                                void updateMoney() async {
                                  var f = await getCustomer();
                                  String url =
                                      "http://127.0.0.1:5000/updateamount";
                                  Map<String, String> headers = {
                                    "accept": "application/json",
                                    "Content-type": "application/json"
                                  };
                                  var item = jsonEncode({
                                    'increment': 100,
                                    'id': id,
                                    'username': custName,
                                    'userid': custID
                                  });
                                  http.Response response = await http.post(url,
                                      headers: headers, body: item);
                                  if (response.body.toString() ==
                                      "amountupdated") {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomeCustomer()));
                                    print(detail);
                                  } else {
                                    print("cant update amount");
                                  }
                                }

                                updateMoney();
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              child: Container(
                                height: 20,
                                width: 60,
                                color: Colors.yellow,
                                child: Text("+1000"),
                              ),
                              onTap: () {
                                void updateMoney() async {
                                  var f = await getCustomer();
                                  String url =
                                      "http://127.0.0.1:5000/updateamount";
                                  Map<String, String> headers = {
                                    "accept": "application/json",
                                    "Content-type": "application/json"
                                  };
                                  var item = jsonEncode({
                                    'increment': 1000,
                                    'id': id,
                                    'username': custName,
                                    'userid': custID
                                  });
                                  http.Response response = await http.post(url,
                                      headers: headers, body: item);
                                  if (response.body.toString() ==
                                      "amountupdated") {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomeCustomer()));
                                    print(detail);
                                  } else {
                                    print("cant update amount");
                                  }
                                }

                                updateMoney();
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              child: Container(
                                height: 20,
                                width: 60,
                                color: Colors.yellow,
                                child: Text("+10000"),
                              ),
                              onTap: () {
                                void updateMoney() async {
                                  var f = await getCustomer();
                                  String url =
                                      "http://127.0.0.1:5000/updateamount";
                                  Map<String, String> headers = {
                                    "accept": "application/json",
                                    "Content-type": "application/json"
                                  };
                                  var item = jsonEncode({
                                    'increment': 10000,
                                    'id': id,
                                    'username': custName,
                                    'userid': custID
                                  });
                                  http.Response response = await http.post(url,
                                      headers: headers, body: item);
                                  if (response.body.toString() ==
                                      "amountupdated") {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomeCustomer()));
                                    print(detail);
                                  } else {
                                    print("cant update amount");
                                  }
                                }

                                updateMoney();
                              },
                            ),
                          ],
                        ),
                      ),
                      RatingBar.builder(
                          itemSize: 20,
                          initialRating: 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                          onRatingUpdate: (rating) {
                            void rate() async {
                              var g = await getitems();
                              String url = "http://127.0.0.1:5000/rating";
                              Map<String, String> headers = {
                                "accept": "application/json",
                                "Content-type": "application/json"
                              };
                              var item = jsonEncode({
                                'id': id.toString(),
                                'rate': rating.toString()
                              });
                              http.Response response = await http.post(url,
                                  headers: headers, body: item);
                            }

                            rate();
                          }),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class Post {
  String date, detail, url, status, name;
  int amount, id;
  Post(this.amount, this.date, this.detail, this.url, this.status, this.name,
      this.id);
}
