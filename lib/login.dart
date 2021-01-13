import 'package:e_auction/manager.dart';
import 'package:e_auction/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_auction/customerhome.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:e_auction/sellerhome.dart';

class Login extends StatelessWidget {
  String _email;
  String _password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:Center(
          child: Column(
            children: [
              Text("E-Auction",style: TextStyle(fontSize: 40),),
              SizedBox(height:20),
              Container(
                height: 450,
                width: 400,
                decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(20),border: Border.all(color: Colors.lightBlueAccent,width: 3)
                ),
                child: Column(

                  children: [
                    Text("Login",style: TextStyle(fontSize: 30),),
                    SizedBox(height: 20,),
                    TextFormField(
                      decoration: InputDecoration(filled:true,hintText: "Email"),
                      onChanged: (value){_email=value;},
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      obscureText:true,
                      decoration: InputDecoration(filled:true,hintText: "Password",),
                      onChanged: (value){_password=value;},
                    ),
                    SizedBox(height: 20,),
                    FlatButton(
                      onPressed: (){
                        void login()async{
                          String url="http://127.0.0.1:5000/login";
                          Map<String, String> headers = { "accept": "application/json","Content-type": "application/json"};
                          var item = jsonEncode({'email': _email.trim().toString(),'password': _password.trim().toString()});// Enter your own desired data or you can take input from user as well.
                          http.Response response = await http.post(url, headers:headers,body: item);
                          if(response.body.toString()=="welcomecustomer"){
                            print(response.body.toString());
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeCustomer()));
                          }
                          else if(response.body.toString()=="welcomeseller"){
                            print(response.body.toString());
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeSeller()));
                          }
                          else{
                            print("problem detected");
                            print(response.body);
                          }
                        }
                        login();
                      },
                      child: Container(
                        color: Colors.lightBlueAccent,
                        height: 50,
                        width: 120,
                        child: Center(child: Text("Submit",style: TextStyle(fontSize: 20,color: Colors.black),)),
                      ),
                    ),
                    SizedBox(height: 20,),
                    GestureDetector(
                      onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>Register()));},
                      child: Text("Create account"),
                    ),
                    SizedBox(height: 20,),
                    GestureDetector(
                      onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>ManagerLogin()));},
                      child: Text("Manager Login"),
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
