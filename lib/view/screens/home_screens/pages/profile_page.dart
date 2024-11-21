import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tailer_app/view/auth/login_screen.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        backgroundColor: Color(0xFF2a87ef),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
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
                          'Sher Ali',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '+03470478282',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit, color: Color(0xFF2a87ef)),
                    onPressed: () {
                      // Handle edit profile action
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildActionButton('Orders', Icons.shopping_bag),
                buildActionButton('Payments', Icons.payment),
                buildActionButton('Favourite', Icons.favorite),
              ],
            ),
            SizedBox(height: 20),
            // Location Section
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
                  Icon(Icons.location_pin, color: Color(0xFF2a87ef)),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'info park kochi',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add, color: Color(0xFF2a87ef)),
                    onPressed: () {
                      // Handle add location action
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Options List
            Expanded(
              child: ListView(
                children: [
                  buildListTile(Icons.update, 'Size Updates', () {}),
                  buildListTile(Icons.bookmark, 'Saved', () {}),
                  buildListTile(Icons.settings, 'Settings', () {}),
                  buildListTile(Icons.language, 'Language', () {}),
                  buildListTile(Icons.help, 'Help & Services', () {}),
                ],
              ),
            ),
            // Logout Button
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle logout action
                  Get.offAll(() => SignInScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2a87ef),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('Logout', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to build each action button
  Widget buildActionButton(String text, IconData icon) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          // Handle button action
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Color(0xFF2a87ef),
          backgroundColor: Colors.white,
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

  // Widget to build each list tile in the options list
  Widget buildListTile(IconData icon, String text, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF2a87ef)),
      title: Text(text),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }
}
