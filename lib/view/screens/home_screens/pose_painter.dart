import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

// Custom class to represent pose landmarks detected using TensorFlow Lite
class PoseLandmark {
  final double x;
  final double y;
  final double confidence;

  PoseLandmark(this.x, this.y, this.confidence);
}

// Custom class to represent a detected pose
class Pose {
  final Map<String, PoseLandmark> landmarks;

  Pose(this.landmarks);
}

// Custom Painter class for rendering the poses
class PosePainter extends CustomPainter {
  final List<Pose> poses;              // List of detected poses
  final Size absoluteImageSize;        // The actual size of the image
  final ui.Image shirtImage;           // The clothing image to overlay

  PosePainter(this.poses, this.absoluteImageSize, this.shirtImage);

  @override
  Future<void> paint(Canvas canvas, Size size) async {
    if (poses.isEmpty) return;

    for (Pose pose in poses) {
      // Access landmarks for positioning
      PoseLandmark? leftShoulder = pose.landmarks["leftShoulder"];
      PoseLandmark? rightShoulder = pose.landmarks["rightShoulder"];
      PoseLandmark? leftHip = pose.landmarks["leftHip"];
      PoseLandmark? rightHip = pose.landmarks["rightHip"];

      if (leftShoulder != null && rightShoulder != null && leftHip != null && rightHip != null) {
        // Translate pose landmarks to canvas coordinates
        final leftShoulderOffset = Offset(
          translateX(leftShoulder.x, absoluteImageSize.width, size.width),
          translateY(leftShoulder.y, absoluteImageSize.height, size.height),
        );
        final rightShoulderOffset = Offset(
          translateX(rightShoulder.x, absoluteImageSize.width, size.width),
          translateY(rightShoulder.y, absoluteImageSize.height, size.height),
        );
        final leftHipOffset = Offset(
          translateX(leftHip.x, absoluteImageSize.width, size.width),
          translateY(leftHip.y, absoluteImageSize.height, size.height),
        );
        final rightHipOffset = Offset(
          translateX(rightHip.x, absoluteImageSize.width, size.width),
          translateY(rightHip.y, absoluteImageSize.height, size.height),
        );

        // Calculate size and position for the clothing
        double width = (rightShoulderOffset.dx - leftShoulderOffset.dx).abs();
        double height = (leftHipOffset.dy - leftShoulderOffset.dy).abs();

        Rect shirtRect = Rect.fromLTRB(
          leftShoulderOffset.dx,
          leftShoulderOffset.dy,
          rightShoulderOffset.dx,
          rightShoulderOffset.dy + height,
        );

        // Draw the t-shirt image over the body
        canvas.drawImageRect(
          shirtImage,
          Rect.fromLTWH(0, 0, shirtImage.width.toDouble(), shirtImage.height.toDouble()),
          shirtRect,
          Paint(),
        );
      }
    }
  }

  // Helper method to translate x-coordinate based on image and canvas dimensions
  double translateX(double x, double imageWidth, double canvasWidth) {
    return x * (canvasWidth / imageWidth);
  }

  // Helper method to translate y-coordinate based on image and canvas dimensions
  double translateY(double y, double imageHeight, double canvasHeight) {
    return y * (canvasHeight / imageHeight);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Repaint every time since it's real-time processing
  }
}
