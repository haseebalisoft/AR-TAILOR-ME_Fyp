// lib/view/screens/home_screens/initial_design_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tailer_app/view/screens/home_screens/customization_screen.dart';

class InitialDesignScreen extends StatelessWidget {
  InitialDesignScreen({super.key});

  final _gender = 'Male'.obs; // Rx to observe the gender selection
  final _selectedMaterial = ''.obs; // Rx to observe the material selection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0f0f0),
      appBar: AppBar(
        title: Text("Design My Dress"),
        backgroundColor: Color(0xff6a1b9a),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gender Selection
              Text(
                "Gender",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Expanded(
                    child: Obx(() => RadioListTile<String>(
                          title: Text("Male"),
                          value: 'Male',
                          groupValue: _gender.value,
                          onChanged: (value) {
                            _gender.value = value!;
                          },
                        )),
                  ),
                  Expanded(
                    child: Obx(() => RadioListTile<String>(
                          title: Text("Female"),
                          value: 'Female',
                          groupValue: _gender.value,
                          onChanged: (value) {
                            _gender.value = value!;
                          },
                        )),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Material Upload and Take Photo Buttons
              Text(
                "Your Materials",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Implement the upload functionality
                      },
                      icon: Icon(Icons.upload_file),
                      label: Text("Upload"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff6a1b9a),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Implement the take photo functionality
                      },
                      icon: Icon(Icons.camera_alt),
                      label: Text("Take Photo"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff6a1b9a),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: Text("or", style: TextStyle(fontSize: 16)),
              ),
              SizedBox(height: 20),
              // Material Selection from Store
              Text(
                "Choose Material From Store",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 4, // Number of materials, update as needed
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _selectedMaterial.value = "Material $index";
                    },
                    child: Obx(() => Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:
                                  _selectedMaterial.value == "Material $index"
                                      ? Colors.blue
                                      : Colors.transparent,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              // Replace with your material images
                              Image.asset('assets/material${index + 1}.png',
                                  height: 80, fit: BoxFit.cover),
                              SizedBox(height: 5),
                              Text(
                                "Raymond ${index + 1}",
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                "899/-",
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            ],
                          ),
                        )),
                  );
                },
              ),
              SizedBox(height: 20),
              // Create Design Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the CustomizationScreenTwo when the user clicks 'Create Design'
                    Get.to(() => CustomizationScreenTwo(gender: '', fabric: '', material: '',));
                  },
                  child: Text("Create Design"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff6a1b9a),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
