// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sm7/detectPage.dart';
import 'package:sm7/emptyCheck.dart';
import 'package:sm7/utilities/constants(login).dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Store Management 7", style: TextStyle(fontSize: 20.0)),
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0.0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            UserAccountsDrawerHeader(
              accountName: Text("강남2호점"),
              accountEmail: Text("강남2호점@ediya.com"),
              decoration: BoxDecoration(color: Colors.black),
            ),
          ],
        ),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: const [
                      Color.fromARGB(195, 0, 0, 0),
                      Color.fromARGB(215, 0, 0, 0),
                      Color.fromARGB(235, 0, 0, 0),
                      Color.fromARGB(252, 0, 0, 0),
                    ],
                    stops: const [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      icon: Icon(Icons.door_sliding_outlined,
                          size: 50.0, color: Colors.white),
                      label: Text(" 출입 마스크 확인",
                          style: TextStyle(fontSize: 25.0)),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          minimumSize: Size(250, 80),
                          elevation: 0.0),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EmptyCheck()));
                      },
                    ),
                    SizedBox(height: 75.0),
                    ElevatedButton.icon(
                      icon: Icon(Icons.masks, size: 50.0, color: Colors.white),
                      label: Text(" 좌석 & 마스크 확인",
                          style: TextStyle(fontSize: 25.0)),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          minimumSize: Size(250, 80),
                          elevation: 0.0),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EmptyCheck()));
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}