import 'dart:async';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img; // Add image package to resize image

List<CameraDescription>? cameras;

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? controller;
  Uint8List? overlayedFrame;
  bool isProcessing = false;
  bool isFrontCamera = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  // Initialize the camera and set it up based on front/rear camera
  void _initializeCamera() async {
    cameras = await availableCameras();

    if (cameras != null && cameras!.isNotEmpty) {
      _initializeController(cameras![isFrontCamera ? 1 : 0]);
    }
  }

  // Initialize the camera controller
  void _initializeController(CameraDescription camera) {
    controller = CameraController(
      camera, // Front or rear camera
      ResolutionPreset.medium,
    );

    controller!.initialize().then((_) {
      if (!mounted) return;
      setState(() {});
      startStreaming();
    }).catchError((e) {
      print('Error initializing camera: $e');
    });
  }

  // Start capturing frames continuously
  void startStreaming() {
    Timer.periodic(Duration(milliseconds: 1000), (Timer t) {
      if (!isProcessing) captureAndSendFrame();
    });
  }

  // Capture a frame and send it to the server for processing
  Future<void> captureAndSendFrame() async {
    if (!controller!.value.isInitialized) return;

    isProcessing = true;
    final XFile frame = await controller!.takePicture();
    final bytes = await frame.readAsBytes();

    // Resize the image to reduce size (optional)
    final resizedImage = await _resizeImage(bytes);

    // Send the resized frame to the server and get the processed image
    final processedImageBytes = await sendFrameToServer(resizedImage);

    setState(() {
      overlayedFrame = processedImageBytes;
    });

    isProcessing = false;
  }

  // Resize the image before sending it (optional for optimization)
  Future<Uint8List> _resizeImage(Uint8List bytes) async {
    img.Image? image = img.decodeImage(Uint8List.fromList(bytes));
    if (image != null) {
      img.Image resizedImage =
          img.copyResize(image, width: 640); // Resize image to 640px width
      return Uint8List.fromList(
          img.encodeJpg(resizedImage)); // Encode back to jpg
    }
    return bytes;
  }

  // Send frame to the server for processing
  Future<Uint8List?> sendFrameToServer(Uint8List bytes) async {
    final uri = Uri.parse('http://172.16.235.220:5000/process_frame');
    try {
      // Add a timeout to avoid waiting indefinitely
      final response = await http.post(uri, body: bytes, headers: {
        'Content-Type': 'application/octet-stream',
      }).timeout(Duration(seconds: 10)); // Set timeout of 10 seconds

      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        print('Failed to process frame: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  // Switch between front and rear cameras
  void _toggleCamera() {
    setState(() {
      isFrontCamera = !isFrontCamera;
    });

    _initializeCamera(); // Reinitialize the camera with the new setting
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Stream with Shirt Overlay'),
        actions: [
          IconButton(
            icon: Icon(Icons.switch_camera),
            onPressed: _toggleCamera, // Switch camera on button press
          ),
        ],
      ),
      body: Stack(
        children: [
          if (controller!.value.isInitialized)
            CameraPreview(controller!), // Show live camera preview
          if (overlayedFrame != null)
            Center(
              child:
                  Image.memory(overlayedFrame!), // Display the processed frame
            ),
        ],
      ),
    );
  }
}
