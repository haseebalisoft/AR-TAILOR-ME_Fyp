import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddMeasurementScreen extends StatefulWidget {
  @override
  _AddMeasurementScreenState createState() => _AddMeasurementScreenState();
}

class _AddMeasurementScreenState extends State<AddMeasurementScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List<String> bodyParts = [
    "Neck",
    "Bust",
    "Waist",
    "Hips",
    "Shoulder",
    "Arm Length",
    "Leg Length",
    "Inseam",
    "Thigh"
  ];

  List<TextEditingController> controllers = [];

  @override
  void initState() {
    super.initState();
    controllers =
        List.generate(bodyParts.length, (_) => TextEditingController());
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Measurements"),
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: bodyParts.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextFormField(
                          controller: controllers[index],
                          decoration: InputDecoration(
                            labelText: bodyParts[index],
                            filled: true,
                            fillColor: Colors.blue.shade50,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.blueAccent),
                            ),
                            suffixIcon:
                                Icon(Icons.edit, color: Colors.blueAccent),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter ${bodyParts[index]} measurement";
                            }
                            return null;
                          },
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _showReviewDialog(context);
                    }
                  },
                  child: Text("Review Measurements"),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showReviewDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            title: Text("Review Measurements",
                style: TextStyle(fontWeight: FontWeight.bold)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(bodyParts.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              bodyParts[index],
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "${controllers[index].text} cm",
                              style: TextStyle(color: Colors.blueAccent),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Modify"),
              ),
              ElevatedButton(
                onPressed: () async {
                  await _saveMeasurements();
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Measurements saved successfully!")),
                  );
                },
                child: Text("Confirm & Save"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          );
        });
      },
    );
  }

  Future<void> _saveMeasurements() async {
    final user = _auth.currentUser;
    if (user == null) return;

    Map<String, dynamic> measurements = {
      'userId': user.uid,
      'measurements': {
        for (int i = 0; i < bodyParts.length; i++)
          bodyParts[i]: controllers[i].text
      },
      'timestamp': FieldValue.serverTimestamp(),
    };

    await _firestore.collection('measurements').add(measurements);
  }
}
