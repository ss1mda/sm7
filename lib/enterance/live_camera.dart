import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sm7/enterance/bounding_box.dart';
import 'package:sm7/enterance/camera.dart';
import 'dart:math' as math;
import 'package:tflite/tflite.dart';

//실시간 카메라
class LiveFeed extends StatefulWidget {
  final List<CameraDescription> cameras;
  LiveFeed(this.cameras);

  @override
  _LiveFeedState createState() => _LiveFeedState();
}

class _LiveFeedState extends State<LiveFeed> {
  List<dynamic>? _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;

  //tflite 모델 load
  loadTfModel() async {
    await Tflite.loadModel(
      // model: "assets/ssd_mobilenet.tflite", //컴퓨터,노트북 등 싹다 판단
      // model: "assets/model4.tflite", //mask판단
      model: "assets/ssdlite_mobilenet_v2.tflite", //mask판단
      // labels: "assets/ssd_mobilenet.txt",
      // labels: "assets/model.txt", //Mask,Nomask
      labels: "assets/model2.txt",
    );
  }

  //인식하기위한 이미지 크기 세팅
  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  void initState() {
    super.initState();
    loadTfModel();
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Detect", style: TextStyle(fontSize: 20.0)),
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Stack(
        children: <Widget>[
          //카메라작동(camera.dart)
          CameraFeed(widget.cameras, setRecognitions),
          //박스 그리기(bounding_box)
          BoundingBox(
            _recognitions == null ? [] : _recognitions!,
            math.max(_imageHeight, _imageWidth),
            math.min(_imageHeight, _imageWidth),
            screen.height,
            screen.width,
          ),
        ],
      ),
    );
  }
}