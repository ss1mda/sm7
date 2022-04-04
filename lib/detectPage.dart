import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

class DetectPage extends StatefulWidget {
  const DetectPage({Key? key}) : super(key: key);

  @override
  _DetectPageState createState() => _DetectPageState();
}

class _DetectPageState extends State<DetectPage> {
  bool isCameraReady = false;
  bool isDetecting = false;
  String result = "";
  var recognitions;
  CameraController? _controller;
  CameraImage? imgCamera;
  Future<void>? _initializeControllerFuture;

  setCamera() async {
    // 이용 가능한 카메라 목록에서 특정 카메라를 가져옴
    final cameras = await availableCameras();
    _controller = CameraController(cameras[0], ResolutionPreset.medium); //후방카메라, 해상도
    //controller를 초기화, 초기화 메서드는 Future를 반환
    //CameraController를 초기화하지 않으면, 프리뷰를 보여주거나 사진 촬영 불가
    _initializeControllerFuture = _controller?.initialize();
    if (!mounted) {
      return;
    }
    setState(() {
      isCameraReady = true;
      _controller?.startImageStream((CameraImage img) => {
        if (!isDetecting) //바쁘지 않다
          {
            isDetecting = true,
            recognitions = Tflite.runModelOnFrame(
              bytesList: img.planes.map((plane) {
                return plane.bytes;
              }).toList(),
              imageHeight: img.height,
              imageWidth: img.width,
              imageMean: 127.5,
              imageStd: 127.5,
              rotation: 90,
              numResults: 3,
              threshold: 0.1,
            ),
            result = "",
            recognitions?.forEach((response) {
              result += response["label"] +
                  "  " +
                  (response["confidence"] as double).toStringAsFixed(2) +
                  "\n\n";
            }),
            setState(() {
              result;
            }),
          }
      });
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_case9.tflite",
      labels: "assets/model.txt",
    );
  }

  @override
  void initState() {
    super.initState();
    setCamera();
    loadModel();
  }

  @override
  void dispose() {
    // 위젯의 생명주기 종료시 컨트롤러 역시 해제시켜줍니다.
    _controller?.dispose();
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //_controller.initialize();
    // _initializeControllerFuture = _controller.initialize();
    return Scaffold(
      appBar: AppBar(title: Text('Camera Play')),
      body: Container(
        child: Column(
            children: [
              Center(
                child:Container(
                  height: 460,
                  width: 1024,
                  child: FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_controller!); // Future가 완료되면, 프리뷰를 보여줌
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
                ),
              ),
              Center(
                child: Text(
                  result,
                  style: TextStyle(
                    backgroundColor: Colors.black,
                    fontSize: 30.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
