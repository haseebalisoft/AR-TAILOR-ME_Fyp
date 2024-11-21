// lib/controller/customization_controller.dart
import 'package:get/get.dart';

class CustomizationController extends GetxController {
  var selectedOption = 0.obs; // Track the selected main option index
  var selectedSubOption = 0.obs; // Track the selected sub-option index
  var selectedColor = "blue".obs; // Track the selected color

  // List of main options representing different customization categories
  final List<String> options = [
    "assets/blue.png", // Placeholder for your fabric icon
    "assets/a1.png", // Placeholder for your sleeve icon
    "assets/a3.png", // Placeholder for your collar icon
    "assets/a1.png", // Placeholder for your cuff icon
    "assets/a5.png", // Placeholder for your placket icon
  ];

  // List of sub-options for each main option, for example collar designs
  final Map<int, List<String>> subOptions = {
    0: [
      "Crowley, White",
      "Crosstown, White",
      "Crosstown, Light Blue",
      "Gondomar, White"
    ],
    1: ["assets/a5.png", "assets/a6.png"], // Placeholder for sleeves
    2: [
      "assets/pattern1.png",
      "assets/pattern2.png"
    ], // Placeholder for collars
    // Add more sub-options as needed
  };

  // Map to hold preview images for different selections
  final Map<String, String> previewImages = {
    "fabric": "assets/default_shirt.png",
    "sleeve": "assets/long_sleeve.png",
    "collar": "assets/collar_style1.png",
    // Add other preview images as needed
  };

  // Function to update the selected main option
  void selectOption(int index) {
    selectedOption.value = index;
    selectedSubOption.value =
        0; // Reset sub-option to the first one when main option changes
  }

  // Function to update the selected sub-option
  void selectSubOption(int index) {
    selectedSubOption.value = index;
  }

  // Function to update the selected color
  void selectColor(String color) {
    selectedColor.value = color;
  }

  // Function to get the preview image based on selections
  String getPreviewImage() {
    // Logic to determine the correct preview image based on selected options and color
    String baseImage = 'assets/shirt';
    // For this example, assume images follow a naming convention like 'shirt1_blue.png'
    return '$baseImage${selectedOption.value + 1}_${selectedColor.value}.png';
  }
}
