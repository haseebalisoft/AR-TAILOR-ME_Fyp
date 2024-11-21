import 'package:flutter/material.dart';

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
                      "Measurement ${index + 1}: ${measurementList[index].text} inches",
                      style: TextStyle(fontSize: 18),
                    ),
                    subtitle: Text("Body Part: Measurement ${index + 1}"),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Back"),
            ),
          ],
        ),
      ),
    );
  }
}
