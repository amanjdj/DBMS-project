import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:e_auction/login.dart';

class SellerPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Text("Item added proceed to login"),
            SizedBox(height: 20,),
            Center(
              child: GestureDetector(
                onTap: (){
                  void logout()async{
                    String url="http://127.0.0.1:5000/logout";
                    http.Response response = await http.get(url);
                    if(response.body.toString()=="loggedout"){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
                    }
                    else{print("Error");}
                  }
                  logout();
                },
                child: Container(
                  height: 50,
                  width: 150,
                  color: Colors.black12,
                  child: Center(child: Text("Login->",style: TextStyle(fontSize: 30),)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
