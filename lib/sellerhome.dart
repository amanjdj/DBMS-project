import 'package:e_auction/customerhome.dart';
import 'package:e_auction/login.dart';
import 'package:e_auction/sellerpanel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeSeller extends StatefulWidget {
  @override
  _HomeSellerState createState() => _HomeSellerState();
}

class _HomeSellerState extends State<HomeSeller> {
  String _name, _url, _time, _detail, _amount;
  var currentuserID;

  @override
  void initState() {
    super.initState();
    Future<String> getCurrentUser() async {
      String url = "http://127.0.0.1:5000/currentuser";
      http.Response response = await http.get(url);
      var user = jsonDecode(response.body);
      setState(() {
        currentuserID = int.parse(user[0]);
      });
      print(currentuserID);
    }

    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Add Items",
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 400,
                width: 800,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border:
                        Border.all(color: Colors.lightBlueAccent, width: 3)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextFormField(
                      decoration:
                          InputDecoration(filled: true, hintText: "Name"),
                      onChanged: (value) {
                        _name = value;
                      },
                    ),
                    TextFormField(
                      decoration:
                          InputDecoration(filled: true, hintText: "Detail"),
                      onChanged: (value) {
                        _detail = value;
                      },
                    ),
                    TextFormField(
                      decoration:
                          InputDecoration(filled: true, hintText: "Image URL"),
                      onChanged: (value) {
                        _url = value;
                      },
                    ),
                    TextFormField(
                      decoration:
                          InputDecoration(filled: true, hintText: "Amount(₹)"),
                      onChanged: (value) {
                        _amount = value;
                      },
                    ),
                    TextFormField(
                      decoration:
                          InputDecoration(filled: true, hintText: "Date"),
                      onChanged: (value) {
                        _time = value;
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    FlatButton(
                      onPressed: () {
                        void additem() async {
                          String url = "http://127.0.0.1:5000/additems";
                          Map<String, String> headers = {
                            "accept": "application/json",
                            "Content-type": "application/json"
                          };
                          var item = jsonEncode({
                            "name": _name,
                            "url": _url,
                            "detail": _detail,
                            "amount": _amount,
                            "date": _time,
                            "seller": currentuserID
                          });
                          http.Response response = await http.post(url,
                              headers: headers, body: item);
                          if (response.body.toString() == "itemadded") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SellerPanel()));
                          } else {
                            print("something wrong");
                          }
                        }

                        additem();
                      },
                      child: Container(
                        color: Colors.lightBlueAccent,
                        height: 50,
                        width: 120,
                        child: Center(
                            child: Text(
                          "Submit",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        )),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
