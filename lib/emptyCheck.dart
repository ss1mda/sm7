// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sm7/utilities/constants(login).dart';

class EmptyCheck extends StatefulWidget {
  @override
  _EmptyCheckState createState() => _EmptyCheckState();
}

final Map<String, dynamic> jsonString2 = {
  'table3': { //테이블3
    'chair': {
      'up': 2, //0빈자리, 1마스크한사람, 2마스크안한사람, 3error
      'down': 1
    },
    'object':
    {
      "notebook": 1, //노트북 갯수
      "book": 0, //책 갯수
      "bag": 2, //가방 갯수
      "cup": 2 // 컵 갯수
    }
  }
};
//바뀐거로

class myPainter extends CustomPainter {
  String target;
  myPainter(this.target);


  void _emptytable(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.grey
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;
    canvas.drawRect(Offset(-80, -30) & const Size(160, 60), paint);
  }

  void _table(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;
    canvas.drawRect(Offset(-80, -30) & const Size(160, 60), paint);
  }

  void _noperson(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(0, 0), 20, paint);
  }

  void _person_mask(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(0, 0), 20, paint);
  }

  void _person_nomask(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(0, 0), 20, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (target == "p1") {
      _person_mask(canvas, size);
    } else if (target == "p2") {
      _person_nomask(canvas, size);
    } else if (target == "p3") {
      _person_mask(canvas, size);
    } else if (target == "p4") {
      _noperson(canvas, size);
    } else if (target == "p5" && jsonString2.keys.first.toString() == "table3" && jsonString2["table3"]["chair"].keys.first.toString() == "up")
    {
      if(jsonString2["table3"]["chair"]["up"] == 0){
        _noperson(canvas, size);
      }else if(jsonString2["table3"]["chair"]["up"] == 1){
        _person_mask(canvas, size);
      }else if(jsonString2["table3"]["chair"]["up"] == 2){
        _person_nomask(canvas, size);
      }else{
        _person_nomask(canvas, size);
      }
    } else if (target == "p6" && jsonString2.keys.first.toString() == "table3" && jsonString2["table3"]["chair"].keys.last.
        toString() == "down")
    { if(jsonString2["table3"]["chair"]["down"] == 0){
      _noperson(canvas, size);
    }else if(jsonString2["table3"]["chair"]["down"] == 1){
      _person_mask(canvas, size);
    }else if(jsonString2["table3"]["chair"]["down"] == 2){
      _person_nomask(canvas, size);
    }else{
      _person_nomask(canvas, size);
    }
    } else if (target == "t1") {
      _table(canvas, size);
    } else if (target == "t2") {
      _emptytable(canvas, size);
    } else if (target == "t3") {
      _table(canvas, size);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class _EmptyCheckState extends State<EmptyCheck> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("좌석 & 마스크 확인", style: TextStyle(fontSize: 20.0)),
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0.0,
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
              SafeArea(
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(
                            height: 80,
                          ),
                          Container(
                            // alignment: Alignment.center,
                            child: CustomPaint(
                              painter: myPainter("p1"),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            // alignment: Alignment.center,
                            child: CustomPaint(
                              painter: myPainter("t1"),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            // alignment: Alignment.center,
                            child: CustomPaint(
                              painter: myPainter("p2"),
                            ),
                          ),
                          SizedBox(
                            height: 70,
                          ),
                          Container(
                            // alignment: Alignment.center,
                            child: CustomPaint(
                              painter: myPainter("p3"),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            // alignment: Alignment.center,
                            child: CustomPaint(
                              painter: myPainter("t2"),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            // alignment: Alignment.center,
                            child: CustomPaint(
                              painter: myPainter("p4"),
                            ),
                          ),
                          SizedBox(
                            height: 70,
                          ),
                          Container(
                            // alignment: Alignment.center,
                            child: CustomPaint(
                              painter: myPainter("p5"),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            // alignment: Alignment.center,
                            child: CustomPaint(
                              painter: myPainter("t3"),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            // alignment: Alignment.center,
                            child: CustomPaint(
                              painter: myPainter("p6"),
                            ),
                          ),
                          SizedBox(
                            height: 80,
                          ),
                        ])),
              )
            ],
          ),
        ),
      ),
    );
  }
}