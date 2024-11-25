import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // To load asset files
import 'package:http/http.dart' as http;
import 'package:tailer_app/view/screens/home_screens/ar_try_screen.dart';

class CreateLookScreen extends StatefulWidget {
  @override
  _CreateLookScreenState createState() => _CreateLookScreenState();
}

class _CreateLookScreenState extends State<CreateLookScreen> {
  final List<String> shirtImages = [
    'assets/t1.png',
    'assets/t1.png',
    'assets/t1.png',
  ];

  Future<void> _uploadShirt(String shirtPath) async {
    final url = Uri.parse('http://172.16.231.73:5000/upload_shirt');

    try {
      final ByteData imageData = await rootBundle.load(shirtPath);
      final List<int> imageBytes = imageData.buffer.asUint8List();

      final request = http.MultipartRequest('POST', url)
        ..files.add(http.MultipartFile.fromBytes(
          'shirt',
          imageBytes,
          filename: shirtPath.split('/').last,
        ));

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final data = json.decode(responseData);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Shirt uploaded successfully: ${data["message"]}')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload shirt.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading shirt: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          'Create a Look',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: Icon(Icons.arrow_back, color: Colors.black),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: Column(
                children: [
                  // Mannequin Section
                  Expanded(
                    child: Image.asset(
                      'assets/t1.png', // Replace with your mannequin image
                      fit: BoxFit.contain,
                    ),
                  ),
                  // "My Look" Section
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Shirts',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: shirtImages.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          _uploadShirt(shirtImages[index]);
                          // You can navigate to the next screen after uploading
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyHomePage(),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              Image.asset(
                                shirtImages[index], // Shirt image
                                width: 80,
                                height: 80,
                              ),
                              SizedBox(height: 4),
                              Text('Shirt ${index + 1}'),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          'Next Screen',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: Icon(Icons.arrow_back, color: Colors.black),
      ),
      body: Center(
        child: Text('Shirt Uploaded Successfully'),
      ),
    );
  }
}
