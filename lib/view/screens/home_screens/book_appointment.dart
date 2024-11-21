import 'package:flutter/material.dart';

class BookAppointmentScreen extends StatefulWidget {
  BookAppointmentScreen({super.key});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  // Define controllers for text input if needed
  final TextEditingController confirmDateController = TextEditingController();
  final TextEditingController confirmTimeController = TextEditingController();
  final TextEditingController preferredCallAppController = TextEditingController();
  final TextEditingController anyOtherDetailController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {
              // Handle favorite action
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Handle cart action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Section
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/default_profile.png'),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Thayyal Boban',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 20),
                              Icon(Icons.star, color: Colors.amber, size: 20),
                              Icon(Icons.star, color: Colors.amber, size: 20),
                              Icon(Icons.star, color: Colors.amber, size: 20),
                              Icon(Icons.star_half, color: Colors.amber, size: 20),
                              Text(' 4.5', style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text(
                            'kakkanad',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Handle call action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF2a87ef),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text('call'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Action Buttons
             
              SizedBox(height: 20),
              // Date Selection
              Text(
                'Select date you want',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              buildDateSelection(context),
              SizedBox(height: 20),
              // Photos Section
              
              SizedBox(height: 10),
              buildPhotosSection(),
              SizedBox(height: 20),
              // Confirm Button
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle confirm action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2a87ef),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Confirm', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget to build action buttons
  Widget buildActionButton(String text, IconData icon) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          // Handle button action
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Color(0xFF2a87ef), backgroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Color(0xFF2a87ef)),
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: Color(0xFF2a87ef)),
            SizedBox(height: 8),
            Text(text, style: TextStyle(color: Color(0xFF2a87ef))),
          ],
        ),
      ),
    );
  }

  // Widget to build date selection
  Widget buildDateSelection(BuildContext context) {
    return Column(
      children: [
        DropdownButton<String>(
          value: '${selectedDate.month} ${selectedDate.year}',
          items: List.generate(12, (index) {
            DateTime date = DateTime(selectedDate.year, index + 1, 1);
            return DropdownMenuItem(
              value: '${date.month} ${date.year}',
              child: Text('${date.month} ${date.year}'),
            );
          }),
          onChanged: (value) {
            // Handle month change
          },
        ),
        SizedBox(height: 10),
        CalendarDatePicker(
          initialDate: selectedDate,
          firstDate: DateTime.now(),
          lastDate: DateTime(DateTime.now().year + 1),
          onDateChanged: (date) {
            setState(() {
              selectedDate = date;
            });
          },
        ),
      ],
    );
  }

  // Widget to build photos section
  Widget buildPhotosSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildPhotoCard('assets/photo1.png'),
        buildPhotoCard('assets/photo2.png'),
        buildPhotoCard('assets/photo3.png'),
      ],
    );
  }

  // Widget to build individual photo card
  Widget buildPhotoCard(String imagePath) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
