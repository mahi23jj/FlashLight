import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:camera/camera.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
     
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'FlashLight'),
    );
  }
}



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isFlashOn = false;
  CameraController? cameraController;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    // Get a list of available cameras
    final cameras = await availableCameras();
    // Get the first camera (usually the back camera)
    cameraController = CameraController(cameras[0], ResolutionPreset.low);
    await cameraController?.initialize();
  }

  Future<void> toggleFlashlight() async {
    if (cameraController != null) {
      try {
        if (isFlashOn) {
          await cameraController?.setFlashMode(FlashMode.off);
        } else {
          await cameraController?.setFlashMode(FlashMode.torch);
        }
        setState(() {
          isFlashOn = !isFlashOn;
        });
      } catch (e) {
        print('Error toggling flashlight: $e');
      }
    }
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Text(
            isFlashOn ? "FlashLight is ON" : "FlashLight is OFF",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.3),
          Center(
            child: GestureDetector(
              onTap: (){

              } ,// Call toggleFlashlight on tap
              child: CircleAvatar(
                backgroundImage: AssetImage(isFlashOn ? 'asset/g.png' : 'asset/f.png'),
                radius: 50,
              ),
            ),
          )
        ],
      ),
    );
  }
}
