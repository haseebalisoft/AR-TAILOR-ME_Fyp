import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tailer_app/controller/customization_controller.dart';
import 'package:tailer_app/controller/cart_controller.dart';
import 'package:tailer_app/view/screens/home_screens/book_appointment.dart';
import 'package:tailer_app/view/screens/home_screens/cart-screen.dart';
import 'package:tailer_app/view/screens/home_screens/pages/cart_page.dart';
import 'package:tailer_app/view/screens/home_screens/pages/profile_page.dart';
import 'package:tailer_app/view/auth/login_screen.dart';

class CartItem {
  final int id;
  final String name;
  final String image;
  final double price;

  CartItem({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });
}

class CustomizationScreenTwo extends StatelessWidget {
  final String gender;
  final String fabric;
  final String material;

  CustomizationScreenTwo({
    super.key,
    required this.gender,
    required this.fabric,
    required this.material,
  });

  final CustomizationController controller = Get.put(CustomizationController());
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0f0f0),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text("Customization"),
      ),
      drawer: buildDrawer(context),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isWideScreen = constraints.maxWidth > 800;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: isWideScreen
                    ? constraints.maxWidth * 0.2
                    : 0.2 * constraints.maxWidth,
                color: Color(0xff2a87ef),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    ...List.generate(controller.options.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          controller.selectOption(index);
                        },
                        child: Obx(() => Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 10),
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: controller.selectedOption.value == index
                                    ? Colors.white
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color:
                                      controller.selectedOption.value == index
                                          ? Color(0xFF6E2594)
                                          : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Image.asset(controller.options[index],
                                      height: 50),
                                  SizedBox(height: 5),
                                  Text(
                                    [
                                      "Fit",
                                      "Body",
                                      "Collar",
                                      "Pocket",
                                      "Back Loop"
                                    ][index],
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      );
                    }),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: isWideScreen ? 400 : 250,
                                height: isWideScreen ? 600 : 400,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Color(0xff2a87ef),
                                    width: 2,
                                  ),
                                ),
                                child: Obx(() {
                                  String imagePath =
                                      controller.getPreviewImage();
                                  return Image.asset(imagePath,
                                      fit: BoxFit.cover, errorBuilder:
                                          (context, error, stackTrace) {
                                    // Handle error if the image path is incorrect
                                    return Center(
                                        child: Text('Image not found'));
                                  });
                                }),
                              ),
                              Positioned(
                                right: 10,
                                bottom: 10,
                                child: IconButton(
                                  icon: Icon(Icons.threed_rotation,
                                      color: Color(0xFF6E2594)),
                                  onPressed: () {
                                    // Handle 3D rotation view
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Select Color",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff2a87ef),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            ...['black', 'red', 'blue', 'yellow', 'green']
                                .map((color) {
                              return GestureDetector(
                                onTap: () {
                                  controller.selectColor(color);
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    color: getColorFromName(color),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: controller.selectedColor.value ==
                                              color
                                          ? Colors.black
                                          : Colors.transparent,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "Note: Once the design is confirmed, alterations can't be done after 15 days of order.",
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Get.to(() => BookAppointmentScreen());
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 173, 166, 176),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 15),
                              ),
                              child: Text("Book Appointment"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                int selectedMainOption =
                                    controller.selectedOption.value;
                                String selectedColor =
                                    controller.selectedColor.value;
                                String selectedDesign = 'assets/shirt1.png';

                                cartController.addItem(CartItem(
                                  id: selectedMainOption,
                                  name:
                                      'Shirt Design ${selectedMainOption + 1} - $selectedColor',
                                  image: selectedDesign,
                                  price: 50.0,
                                ) as String);

                                // Print statement for debugging
                                print("Navigating to CartScreen");
                                Get.to(() => CartScreen());
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 213, 211, 204),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 15),
                              ),
                              child: Text("Add to Cart"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Color(0xff2a87ef)),
            accountName: Text("Sher Ali"),
            accountEmail: Text("sherali@example.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                "SA",
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Cart'),
            onTap: () {
              // Debug print to confirm tap
              print("Cart button tapped");
              Get.to(() => CartScreen());
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              Get.to(() => ProfilePage());
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              Get.offAll(() => SignInScreen());
            },
          ),
        ],
      ),
    );
  }

  Color getColorFromName(String colorName) {
    switch (colorName) {
      case 'black':
        return Colors.black;
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      case 'yellow':
        return Colors.yellow;
      case 'green':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
