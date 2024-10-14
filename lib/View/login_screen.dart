import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

import '../Controoler/login.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller =Get.put(authController());
    return Scaffold(
      backgroundColor: Color(0xfff2e2cf),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 80,),
          Center(
            child: CircleAvatar(
              radius: 85,
              backgroundImage: AssetImage("assets/img/images.jpg"),
            ),
          ),


          Center(
            child: Text("           Welcome To \nGood Habit Book Riding ",style: TextStyle(

              fontWeight: FontWeight.bold,
              fontSize: 23,
                color: Color(0xff4981A7)
            ),),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Enter Email",style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color:   Color(0xff4981A7)
                ),),
                TextField(
                  controller: controller.txtEmail,
                ),
                SizedBox(height: 20,),
                Text("Enter Password",style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color:   Color(0xff4981A7)
                ),),
                TextField(
                  controller: controller.txtName,
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Center(
            child: GestureDetector(
              onTap: () async {


                await controller.signUp(controller.txtEmail.text, controller.txtName.text);
                controller.txtEmail.clear();
                controller.txtName.clear();


              },
              child: Container(
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Color(0xffcba715)
                ),
                child: Center(
                  child: Text("Login",style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 20),),
                ),
              ),
            ),
          ),



        ],
      ),
    );
  }
}
