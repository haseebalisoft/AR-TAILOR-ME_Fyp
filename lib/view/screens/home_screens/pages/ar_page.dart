import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class ArScreen extends StatefulWidget {
  const ArScreen({super.key});

  @override
  _ArScreenState createState() => _ArScreenState();
}

class _ArScreenState extends State<ArScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  List<CameraDescription>? _cameras;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    // Fetch the available cameras before initializing the controller
    _cameras = await availableCameras();
    if (_cameras != null && _cameras!.isNotEmpty) {
      _controller = CameraController(
        // Use the first available camera
        _cameras!.first,
        ResolutionPreset.medium,
      );

      // Initialize the controller and store the Future for later use
      _initializeControllerFuture = _controller.initialize();
      setState(() {}); // Refresh the UI after initializing the camera
    }
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AR Screen'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _cameras == null
                ? Center(child: CircularProgressIndicator())
                : FutureBuilder<void>(
                    future: _initializeControllerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        // If the Future is complete, display the preview
                        return CameraPreview(_controller);
                      } else {
                        // Otherwise, display a loading indicator
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () {
                // Implement additional functionality or navigation if needed
              },
              child: Text("Perform AR Measurement"),
            ),
          ),
        ],
      ),
    );
  }
}
