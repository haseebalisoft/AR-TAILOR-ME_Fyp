import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:developer';
import 'formal_men_tshirt_screen.dart';
import 'sports_men_tshirt_screen.dart';
import 'traditional_men_kameez_screen.dart';

class CustomizationStart extends StatefulWidget {
  const CustomizationStart({super.key});

  @override
  State<CustomizationStart> createState() => _CustomizationStartState();
}

class _CustomizationStartState extends State<CustomizationStart> {
  String selectedDressStyle = '';

  final List<Map<String, String>> dressStyles = [
    {'name': 'Formal Shirt', 'image': 'assets/images/FormalShirt.png'},
    {'name': 'Sports Shirt', 'image': 'assets/images/sports_shirt.png'},
    {
      'name': 'Traditional Kameez',
      'image': 'assets/images/TraditionalShirt.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Customization',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(color: Colors.blue),
          child: Column(
            children: [
              // Lottie Animation Section
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(65),
                    topRight: Radius.circular(65),
                  ),
                ),
                child: Lottie.asset(
                  'assets/lottie/CustomizationStart.json',
                  fit: BoxFit.contain,
                  repeat: true,
                  animate: true,
                ),
              ),

              // Content Section
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Customize Dress',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(color: Colors.blue),

                      // Dress Style Selection
                      _buildDressTypeSelection(),

                      // Next Button
                      if (selectedDressStyle.isNotEmpty)
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 10,
                              ),
                            ),
                            onPressed: () {
                              log("Dress Style: $selectedDressStyle");

                              // Navigate to appropriate screen
                              if (selectedDressStyle == 'Formal Shirt') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const FormalMenTShirtScreen(),
                                  ),
                                );
                              } else if (selectedDressStyle == 'Sports Shirt') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const SportsMenTShirtScreen(),
                                  ),
                                );
                              } else if (selectedDressStyle ==
                                  'Traditional Kameez') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const TraditionalKameezScreen(),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        "No screen implemented for $selectedDressStyle."),
                                  ),
                                );
                              }
                            },
                            child: const Text(
                              'Next',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDressTypeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Choose Dress Style',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        ...dressStyles.map((type) {
          return _buildStyleOption(type['name']!, type['image']!);
        }),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildStyleOption(String title, String imageUrl) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDressStyle = title;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: selectedDressStyle == title
              ? const Color.fromARGB(255, 31, 116, 196)
              : const Color.fromARGB(255, 36, 149, 255),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blue),
        ),
        child: Row(
          children: [
            Radio<String>(
              value: title,
              groupValue: selectedDressStyle,
              onChanged: (value) {
                setState(() {
                  selectedDressStyle = value!;
                });
              },
            ),
            Text(
              title,
              style: TextStyle(
                color: selectedDressStyle == title
                    ? const Color.fromARGB(255, 250, 246, 246)
                    : const Color.fromARGB(255, 252, 254, 255),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Image.asset(
              imageUrl,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.broken_image,
                size: 50,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
