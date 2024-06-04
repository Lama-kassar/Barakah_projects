import 'dart:async';

import 'package:exam2_flutter/Colors/color.dart';
import 'package:exam2_flutter/Styles/textstyle.dart';
import 'package:exam2_flutter/core/config/get_it_config.dart';
import 'package:exam2_flutter/model/people_model.dart';
import 'package:exam2_flutter/service/auth_service.dart';
import 'package:exam2_flutter/service/people_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: core.get<SharedPreferences>().getString('USERNAME') == null
            ? const LoginPage()
            : SecondPage()
        // LoginPage(),
        //SecondPage(),
        // InvitPage(),
        );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 1, 37, 23),
      body: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20, top: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("r",
                      style: TextStyle(
                        fontSize: 50,
                        color: whitePrimary,
                      )),
                  Text("i",
                      style: TextStyle(fontSize: 50, color: specialGreen)),
                  Text("i",
                      style: TextStyle(fontSize: 50, color: specialGreen)),
                  Text("d",
                      style: TextStyle(fontSize: 50, color: whitePrimary)),
                  Text("e",
                      style: TextStyle(fontSize: 50, color: whitePrimary)),
                ],
              ),
            ),
            Text(
              "Welcome to RIIDE",
              style: headTile,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                //textAlign: TextAlign.left,
                "USERNAME",
                style: TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: whitePrimary),
              ),
            ),
            TextField(
              onChanged: (value) {
                core.get<SharedPreferences>().setString('USERNAME', value);
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: searchcol,
                  hintText: "Enter email or username",
                  hintStyle: const TextStyle(color: textusrcol)),
            ),
            const Row(
              children: [
                Text(
                  textAlign: TextAlign.left,
                  "PASSWORD",
                  style: TextStyle(
                      letterSpacing: 1.5,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: whitePrimary),
                ),
              ],
            ),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: searchcol,
                  hintText: "Enter your password",
                  hintStyle: const TextStyle(color: textusrcol)),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 4, left: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Remmeber me", style: TextStyle(color: whitePrimary)),
                  Text("Forget password", style: TextStyle(color: smallBlue)),
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
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 500,
                  decoration: const BoxDecoration(
                      color: button,
                      borderRadius: BorderRadius.all(Radius.circular(9))),
                  child: Text(
                    "Sign in",
                    style: small,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don’t have an account ?", style: small),
                  const Text(" Sign up", style: TextStyle(color: smallBlue)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  List<People> result = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackPrimary,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(right: 10, left: 10),
            height: 200,
            width: 500,
            decoration: const BoxDecoration(color: Color(0xFF3E3E3E)),
            child: Container(
              width: 300,
              height: 48,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: blackPrimary,
                    ),
                    width: 48,
                    height: 48,
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: whitePrimary,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InvitPage(),
                          ));
                    },
                    child: Text(
                      "Invite Friends",
                      style: headTile,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: blackPrimary,
                    ),
                    width: 48,
                    height: 48,
                    child: const Icon(
                      Icons.delete,
                      color: whitePrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          FutureBuilder(
            future: PeopleServiceImp().getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<People> peop = snapshot.data as List<People>;
                print(peop);
                result = peop;
                return StatefulBuilder(builder: (context, refresh) {
                  return Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 20),
                        child: Container(
                          width: 370,
                          height: 42,
                          child: TextField(
                            style: small,
                            onChanged: (value) {
                              result = [];
                              refresh(() {
                                peop.forEach(
                                  (element) {
                                    if (element.message.contains(value)) {
                                      result.add(element);
                                    }
                                  },
                                );
                              });
                              print("resss");
                              print(result);
                            },
                            decoration: InputDecoration(
                              hintText: "Search here..",
                              hintStyle: small,
                              prefixIcon: const Icon(
                                Icons.search,
                                color: button,
                              ),
                              suffixIcon: Image.asset(
                                "assets/images/Vector.png",
                                color: textusrcol,
                                height: 20,
                                width: 15,
                              ),
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Container(
                          height: 300,
                          child: ListView.builder(
                            itemCount: result.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return ListTile(
                                hoverColor: specialGreen,
                                focusColor: textusrcol,
                                leading: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromARGB(255, 126, 238, 130),
                                  ),
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(
                                      result[index].image,
                                    ),
                                  ),
                                ),
                                title: Row(
                                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      result[index].name,
                                      style: nameStyle,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 25),
                                      child: Container(
                                        width: 14,
                                        height: 15,
                                        decoration: const BoxDecoration(
                                            color: specialGreen,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30))),
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          result[index]
                                              .unread_message_count
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: whitePrimary),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle: Text(
                                  result[index].message,
                                  style: minismall,
                                ),
                                trailing: Text(
                                  "12 mar",
                                  style: minismall,
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  );
                });
              } else {
                return Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40)),
                            width: 400,
                            height: 42,
                            child: TextField(
                              decoration: InputDecoration(
                                icon: const Icon(
                                  Icons.search,
                                  color: button,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const LinearProgressIndicator()
                  ],
                );
              }
            },
          )
        ],
      ),
    );
  }
}

class InvitPage extends StatelessWidget {
  const InvitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: blackPrimary,
        body:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Container(
            padding: const EdgeInsets.only(right: 10, left: 10),
            height: 200,
            width: 500,
            decoration: const BoxDecoration(color: Color(0xFF3E3E3E)),
            child: Container(
              width: 300,
              height: 48,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: blackPrimary,
                      ),
                      width: 45,
                      height: 45,
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: whitePrimary,
                      ),
                    ),
                  ),
                  Text(
                    "Invite Friends",
                    style: headTile,
                  ),
                  InkWell(
                    onTap: () {
                      core.get<SharedPreferences>().clear();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: blackPrimary,
                      ),
                      width: 45,
                      height: 45,
                      child: const Icon(
                        Icons.delete,
                        color: whitePrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Image.asset(
              fit: BoxFit.fitHeight,
              "assets/images/present.png",
              width: 300,
              height: 300,
            ),
          ),
          const Text(
            "Invite Friends",
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.w700, color: whitePrimary),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 20),
            child: Text(
                textAlign: TextAlign.center,
                "Sign up a friend with your referral \n code and earn \$RIIDE and/or free rides.",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: whitePrimary)),
          ),
          Container(
            width: 400,
            height: 45,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(9))),
            child: const TextField(
              style: TextStyle(
                  fontSize: 15,
                  //fontWeight: FontWeight.w100,
                  color: whitePrimary),
              decoration: InputDecoration(
                filled: true,
                fillColor: searchcol,
                hintText: "Share your invite code",
                hintStyle: TextStyle(
                    fontSize: 15,
                    //fontWeight: FontWeight.w100,
                    color: whitePrimary),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 25),
            child: Container(
              //padding: const EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              height: 45,
              width: 400,
              decoration: const BoxDecoration(
                  color: button,
                  borderRadius: BorderRadius.all(Radius.circular(9))),
              child: Text(
                "Invite Friends",
                style: small,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ]));
  }
}
