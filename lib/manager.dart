import 'package:flutter/material.dart';
import 'package:e_auction/login.dart';
import 'package:e_auction/managerpanel.dart';

class ManagerLogin extends StatelessWidget {
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
                      Text("Manager",style: TextStyle(fontSize: 30),),
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
                          if(_email=="admin@email.com" && _password=="pass123"){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ManagerPanel()));
                          }
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
                        onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>Login()));},
                        child: Text("Default Login"),
                      ),
                      SizedBox(height: 20,),
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