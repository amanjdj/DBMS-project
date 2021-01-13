import 'package:e_auction/managerpanel.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Rating extends StatefulWidget {
  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  var itemdata2;
  List<Rate> postList2 = [];

  @override
  void initState() {
    super.initState();
    void getitems2() async {
      String url = "http://127.0.0.1:5000/showrating";
      http.Response response = await http.get(url);
      setState(() {
        itemdata2 = jsonDecode(response.body);
      });

      for (int i = 0; i < itemdata2.length; i++) {
        Rate rate =
            Rate(itemdata2[i][0].toString(), itemdata2[i][1].toString());
        postList2.add(rate);
      }
      print(postList2);
    }

    getitems2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ratings"),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ManagerPanel()));
              })
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            width: 300,
            child: postList2 == 0
                ? Text("NO data")
                : ListView.builder(
                    itemCount: postList2.length,
                    itemBuilder: (_, index) {
                      return RatingUI(
                          postList2[index].id, postList2[index].rate);
                    },
                  ),
          ),
        ),
      ),
    );
  }

  Widget RatingUI(String id, String rate) {
    return Card(
      color: Colors.lightBlue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Product ID: $id"),
          SizedBox(
            width: 40,
          ),
          Text("Rating: $rate")
        ],
      ),
    );
  }
}

class Rate {
  String rate, id;
  Rate(this.id, this.rate);
}
