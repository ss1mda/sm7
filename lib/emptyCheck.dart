// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sm7/utilities/constants(login).dart';

class EmptyCheck extends StatefulWidget {
  @override
  _EmptyCheckState createState() => _EmptyCheckState();
}

final jsonString = {"position": 1,"table":1,"person":1,"mask":1};

class myPainter extends CustomPainter
{
  String target;
  myPainter(this.target);

  void _emptytable(Canvas canvas,Size size) {
    Paint paint = Paint()
      ..color = Colors.grey
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;
    canvas.drawRect(Offset(100,100) & const Size(200, 150), paint);
  }

  void _table(Canvas canvas,Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;
    canvas.drawRect(Offset(100,100) & const Size(200, 150), paint);
  }

  void _noperson(Canvas canvas,Size size) {
    Paint paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width.toInt() / 2, size.width.toInt() / 2), 20, paint);
  }

  void _person_mask(Canvas canvas,Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width.toInt() / 2, size.width.toInt() / 2), 20, paint);
  }

  void _person_nomask(Canvas canvas,Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width.toInt() / 2, size.width.toInt() / 2), 20, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    if(target == "p1"){
      _person_mask(canvas, size);
    }else if(target == "t1"){
      _table(canvas, size);
    }else if(target == "p2"){
      _person_nomask(canvas, size);
    }
    // _emptytable(canvas,size);
    // _table(canvas, size);
    // _noperson(canvas, size);
    // _person_nomask(canvas, size);
    // _person_mask(canvas, size);

    // if (jsonString[0] == 0) {
    //   if (jsonString[1] == 0) { //0번테이블, 빈자리
    //     _emptytable(canvas, size);
    //     _noperson(canvas, size);
    //   } else { //0번테이블, 자리있음
    //     if (jsonString[3] == 1 && jsonString[4] == 0) { //0번테이블 사람있음, 마스크 안꼈음
    //       _table(canvas, size);
    //       _person_nomask(canvas, size);
    //     } else
    //     if (jsonString[3] == 1 && jsonString[4] == 1) { //0번테이블 사람있음, 마스크 안꼈음
    //       _table(canvas, size);
    //       _person_mask(canvas, size);
    //     }
    //   }
    // } else if(jsonString[0] == 1){ //1번테이블, 빈자리
    //   if (jsonString[1] == 0) { //1번테이블, 빈자리
    //     _emptytable(canvas, size);
    //     _noperson(canvas, size);
    //   } else { //1번테이블, 자리있음
    //     if (jsonString[3] == 1 && jsonString[4] == 0) { //1번테이블 사람있음, 마스크 안꼈음
    //       _table(canvas, size);
    //       _person_nomask(canvas, size);
    //     } else
    //     if (jsonString[3] == 1 && jsonString[4] == 1) { //1번테이블 사람있음, 마스크 안꼈음
    //       _table(canvas, size);
    //       _person_mask(canvas, size);
    //     }
    //   }
    // }else{
    //   if (jsonString[1] == 0) { //2번테이블, 빈자리
    //     _emptytable(canvas, size);
    //     _noperson(canvas, size);
    //   } else { //2번테이블, 자리있음
    //     if (jsonString[3] == 1 && jsonString[4] == 0) { //2번테이블 사람있음, 마스크 안꼈음
    //       _table(canvas, size);
    //       _person_nomask(canvas, size);
    //     } else
    //     if (jsonString[3] == 1 && jsonString[4] == 1) { //2번테이블 사람있음, 마스크 안꼈음
    //       _table(canvas, size);
    //       _person_mask(canvas, size);
    //     }
    //   }
    // }
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
                      children: <Widget>[
                        Container(
                          height:100,
                          width:100,
                          alignment: Alignment.center,
                          child:CustomPaint(
                            painter: myPainter("p1"),
                          ),
                        ),
                        Container(
                          height:400,
                          width:400,
                          alignment: Alignment.center,
                          child:CustomPaint(
                            painter: myPainter("t1"),
                          ),
                        ),
                        Container(
                          height:100,
                          width:100,
                          alignment: Alignment.center,
                          child:CustomPaint(
                            painter: myPainter("p2"),
                          ),
                        ),
                        // SizedBox(
                        //   height: 50,
                        // ),
                        // Container(
                        //   height:100,
                        //   width:150,
                        //   child:CustomPaint(
                        //     painter: myPainter("p1"),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // Container(
                        //   height:150,
                        //   width:150,
                        //   child:CustomPaint(
                        //     painter: myPainter("t1"),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // Container(
                        //   height:10,
                        //   width:150,
                        //   child:CustomPaint(
                        //     painter: myPainter("p2"),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 50,
                        // ),
                        // Container(
                        //   height:10,
                        //   width:150,
                        //   child:CustomPaint(
                        //     painter: myPainter("p1"),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // Container(
                        //   height:100,
                        //   width:150,
                        //   child:CustomPaint(
                        //     painter: myPainter("t1"),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // Container(
                        //   height:10,
                        //   width:150,
                        //   child:CustomPaint(
                        //     painter: myPainter("p2"),
                        //   ),
                        // ),
                      ]))
            ],
          ),
        ),
      ),
    );
  }
}
