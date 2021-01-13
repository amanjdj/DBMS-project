import 'package:e_auction/rating.dart';
import 'package:flutter/material.dart';
import 'package:e_auction/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ManagerPanel extends StatefulWidget {
  @override
  _ManagerPanelState createState() => _ManagerPanelState();
}

class _ManagerPanelState extends State<ManagerPanel> {
  List<Photo> postList = [];
  var itemdata;
  @override
  void initState() {
    super.initState();
    void getitems() async {
      String url = "http://127.0.0.1:5000/showitems";
      http.Response response = await http.get(url);
      setState(() {
        itemdata = jsonDecode(response.body);
      });

      for (int i = 0; i < itemdata.length; i++) {
        Photo post = Photo(
            itemdata[i]['amount'],
            itemdata[i]['datelimit'],
            itemdata[i]['detail'],
            itemdata[i]['itemstatus'],
            itemdata[i]['name'],
            itemdata[i]['id']);
        postList.add(post);
      }
      print(postList);
    }

    getitems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello Manager"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
          )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              FlatButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Rating()));
                },
                child: Container(
                    color: Colors.black26,
                    height: 100,
                    width: 300,
                    child: Center(
                      child: Text(
                        "Check Ratings",
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  child: postList.length == 0
                      ? Text("No Items")
                      : ListView.builder(
                          itemCount: postList.length,
                          itemBuilder: (_, index) {
                            return ItemUI(
                                postList[index].id,
                                postList[index].amount,
                                postList[index].date,
                                postList[index].detail,
                                postList[index].status,
                                postList[index].name);
                          },
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget ItemUI(int id, int amount, String date, String detail, String status,
      String name) {
    return Card(
      color: Colors.lightBlueAccent,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("ID:${id.toString()}"),
            Text(name),
            Text("Bid: ${amount.toString()}"),
            Text("Expiry: $date"),
            Text("Detail: $detail"),
            Text("Current Status: $status"),
          ],
        ),
      ),
    );
  }
}

class Photo {
  String date, detail, status, name;
  int amount, id;
  Photo(this.amount, this.date, this.detail, this.status, this.name, this.id);
}
