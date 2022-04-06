import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetectPage extends StatefulWidget {
  const DetectPage({Key? key}) : super(key: key);

  @override
  State<DetectPage> createState() => _DetectPageState();
}

class _DetectPageState extends State<DetectPage>{
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;

  setCamera() async {
    final cameras = await availableCameras();
    _controller = CameraController(
      cameras[0],
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller?.initialize();
    if (!mounted) {
      return;
    }setState((){});
  }
  @override
  void initState() {
    super.initState();
    setCamera();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Video Play')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.done){
            return CameraPreview(_controller!);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }
      )
    );
  }
}
