import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddMeasurementScreen extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String price;

  AddMeasurementScreen({
    required this.imageUrl,
    required this.price,
    required this.title,
  });

  @override
  _AddMeasurementScreenState createState() => _AddMeasurementScreenState();
}

class _AddMeasurementScreenState extends State<AddMeasurementScreen> {
  final GlobalKey<FormState> _form = GlobalKey();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<TextEditingController> controllers = [];

  final List<String> bodyParts = [
    "Chest",
    "Waist",
    "Hip",
    "Arm Length",
    "Shoulder Width",
    "Neck",
    "Thigh",
    "Inseam",
    "Leg Length"
  ];

  @override
  void initState() {
    for (int i = 0; i < bodyParts.length; i++) {
      controllers.add(TextEditingController());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(Icons.arrow_forward_ios, color: Colors.amber),
          onPressed: () {
            if (_form.currentState!.validate()) {
              _saveMeasurements();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Measurements saved successfully!")),
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReviewSummaryScreen(
                    measurementList: controllers,
                    title: widget.title,
                    price: widget.price,
                    imageUrl: widget.imageUrl,
                  ),
                ),
              );
            }
          },
        ),
        body: Container(
          color: Colors.blue,
          height: mediaQuerySize.height,
          width: mediaQuerySize.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _form,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildHeader(),
                    SizedBox(height: 20),
                    Text(
                      "Measurements in Inches",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    _buildMeasurementFields(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: _buildBackButton()),
        Expanded(
          flex: 6,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 40),
              child: Text(
                "Add Measurement",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBackButton() {
    return IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () => Navigator.pop(context),
    );
  }

  Widget _buildMeasurementFields(BuildContext context) {
    return Column(
      children: List.generate(bodyParts.length, (index) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () =>
                    _showMeasurementGuide(index), // Show the measurement guide
                child: Text(
                  "${bodyParts[index]} Measurement Guide",
                  style: TextStyle(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      fontSize: 16),
                ),
              ),
              _buildMeasurementField(index),
              SizedBox(height: 8),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildMeasurementField(int index) {
    return TextFormField(
      controller: controllers[index],
      decoration: InputDecoration(
        hintText: bodyParts[index],
        hintStyle: TextStyle(color: Colors.blue[700]),
        filled: true,
        fillColor: Colors.lightBlue[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      style: TextStyle(color: Colors.black),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Field can't be empty";
        }
        return null;
      },
    );
  }

  void _showMeasurementGuide(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("How to Measure ${bodyParts[index]}"),
        content: SizedBox(
          width: 200,
          height: 200,
          child: Image.asset(
            "assets/gifs/${bodyParts[index].toLowerCase()}.gif",
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Text("Image not found or failed to load.");
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  void _saveMeasurements() async {
    final user = _auth.currentUser;
    if (user == null) return;

    Map<String, dynamic> measurements = {
      'username': user.displayName ?? 'Anonymous',
      'title': widget.title,
      'price': widget.price,
      'imageUrl': widget.imageUrl,
      'measurements': {
        for (int i = 0; i < bodyParts.length; i++)
          bodyParts[i]: controllers[i].text
      }
    };

    await _firestore.collection('measurements').add(measurements);
  }
}

class ReviewSummaryScreen extends StatelessWidget {
  final List<TextEditingController> measurementList;
  final String title;
  final String price;
  final String imageUrl;

  ReviewSummaryScreen({
    required this.measurementList,
    required this.title,
    required this.price,
    required this.imageUrl,
  });

  get bodyParts => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Review Summary")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Image.network(imageUrl),
            SizedBox(height: 20),
            Text(
              "Price: $price",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: measurementList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      "${bodyParts[index]}: ${measurementList[index].text} inches",
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Added to Cart!")),
                );
              },
              child: Text("Add to Cart"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Modify Measurements"),
            ),
          ],
        ),
      ),
    );
  }
}
