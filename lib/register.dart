import 'package:e_auction/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  String _email;
  String _password;
  String _name;
  String _address;
  String _type='c';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
          child:Center(
            child: Column(
              children: [
                Text("E-Auction",style: TextStyle(fontSize: 40),),
                SizedBox(height:20),
                Container(
                  height: 500,
                  width: 400,
                  decoration: BoxDecoration(
                      borderRadius:BorderRadius.circular(20),border: Border.all(color: Colors.lightBlueAccent,width: 3)
                  ),
                  child: Column(

                    children: [
                      Text("Register",style: TextStyle(fontSize: 30),),
                      SizedBox(height: 20,),
                      TextFormField(
                        decoration: InputDecoration(filled:true,hintText: "Name"),
                        onChanged: (value){_name=value;},
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        decoration: InputDecoration(filled:true,hintText: "Email"),
                        onChanged: (value){_email=value;},
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        decoration: InputDecoration(filled:true,hintText: "Password"),
                        onChanged: (value){_password=value;},
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        decoration: InputDecoration(filled:true,hintText: "Address"),
                        onChanged: (value){_address=value;},
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            child: Container(
                              height: 35,
                              width: 120,
                              color: _type=='c'?Colors.lightBlueAccent:Colors.white,
                              child: Center(child: Text("Customer",style: TextStyle(fontSize: 20),)),
                            ),
                            onTap: (){
                              setState(() {
                                _type="c";
                              });
                            },
                          ),
                          GestureDetector(
                            child: Container(
                              height: 35,
                              width: 120,
                              color: _type=='s'?Colors.lightBlueAccent:Colors.white,
                              child: Center(child: Text("Seller",style: TextStyle(fontSize: 20),)),
                            ),
                            onTap: (){
                              setState(() {
                                _type="s";
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      FlatButton(
                        child: Container(
                          color: Colors.lightBlueAccent,
                          height: 50,
                          width: 120,
                          child: Center(child: Text("Register",style: TextStyle(fontSize: 20,color: Colors.black),)),
                        ),
                        onPressed: (){
                          void register()async{
                            String url="http://127.0.0.1:5000/signup";
                            Map<String, String> headers = { "accept": "application/json","Content-type": "application/json"};
                            var item = jsonEncode({'email': _email.trim().toString(),'password': _password.trim().toString(),'name':_name,
                            'type':_type,
                              'address':_address
                            });// Enter your own desired data or you can take input from user as well.
                            http.Response response = await http.post(url, headers:headers,body: item);
                            print(response.body);
                            if(response.body.toString()=="signupdone"){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                            }
                          }
                          register();
                        },
                      ),
                      SizedBox(height: 20,),
                      GestureDetector(
                        onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>Login()));},
                        child: Text("Login"),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
