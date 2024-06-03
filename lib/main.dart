import 'dart:async';

import 'package:exam2_flutter/Colors/color.dart';
import 'package:exam2_flutter/Styles/textstyle.dart';
import 'package:exam2_flutter/core/config/get_it_config.dart';
import 'package:exam2_flutter/model/people_model.dart';
import 'package:exam2_flutter/service/auth_service.dart';
import 'package:exam2_flutter/service/people_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      //SecondPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 1, 37, 23),
      body: Padding(
        padding: const EdgeInsets.only(right: 10, left: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 200,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("r",
                      style: TextStyle(fontSize: 50, color: white_primary)),
                  Text("i",
                      style: TextStyle(fontSize: 50, color: special_green)),
                  Text("i",
                      style: TextStyle(fontSize: 50, color: special_green)),
                  Text("d",
                      style: TextStyle(fontSize: 50, color: white_primary)),
                  Text("e",
                      style: TextStyle(fontSize: 50, color: white_primary)),
                ],
              ),
            ),
            Text(
              "Welcome to RIIDE",
              style: meduim,
            ),
            Row(
              children: [
                Text(
                  textAlign: TextAlign.left,
                  "USERNAME",
                  style: small,
                ),
              ],
            ),
            TextField(
              onChanged: (value) {
                core.get<SharedPreferences>().setString('USERNAME', value);
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: fieldcol,
                  hintText: "Enter email or username",
                  hintStyle: TextStyle(color: textfieldcol)),
            ),
            Row(
              children: [
                Text(
                  textAlign: TextAlign.left,
                  "PASSWORD",
                  style: small,
                ),
              ],
            ),
            TextField(
              onChanged: (value) {
                core.get<SharedPreferences>().setString('USERNAME', value);
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: fieldcol,
                  hintText: "Enter your password",
                  hintStyle: TextStyle(color: textfieldcol)),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 4, left: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Remmeber me", style: TextStyle(color: Colors.white)),
                  Text("Forget password", style: TextStyle(color: small_blue)),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SecondPage(),
                    ));
              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                width: 500,
                decoration: const BoxDecoration(
                    color: button,
                    borderRadius: BorderRadius.all(Radius.circular(9))),
                child: Text("Sign in", style: TextStyle(color: Colors.white)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don’t have an account ?", style: small),
                Text(" Sign up", style: TextStyle(color: small_blue)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(right: 10, left: 10),
            height: 300,
            width: 500,
            decoration: BoxDecoration(color: Color(0xFF3E3E3E)),
            child: Container(
              width: 300,
              height: 48,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.arrow_back),
                  Text(
                    "Invite Friends",
                    style: meduim,
                  ),
                  Icon(Icons.delete),
                ],
              ),
            ),
          ),
          Container(
            //padding: EdgeInsets.only(bottom: 10),
            height: 42,
            width: 300,
            decoration: BoxDecoration(
              color: Color(0xFF3E3E3E),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.search),
                  Text(
                    "Search here..",
                    style: meduim,
                  ),
                  Icon(Icons.record_voice_over),
                ]),
          )
        ],
      ),
    );
  }
}
