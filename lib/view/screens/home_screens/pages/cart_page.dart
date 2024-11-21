// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tailer_app/view/screens/home_screens/pages/CheckoutScreen.dart';
// import 'package:tailer_app/view/screens/home_screens/pages/home_page.dart';
// import 'package:tailer_app/view/screens/home_screens/pages/profile_page.dart';
// import 'package:tailer_app/view/screens/home_screens/home_screen.dart'; // Assuming you have a HomeScreen
// import 'package:tailer_app/view/auth/login_screen.dart'; // Assuming you have a LoginScreen

// class CartScreen extends StatefulWidget {
//   @override
//   _CartScreenState createState() => _CartScreenState();
// }

// class _CartScreenState extends State<CartScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Colors.grey.shade100,
//       appBar: AppBar(
//         title: Text("Shopping Cart"),
//         centerTitle: true,
//         backgroundColor: Color(0xff2a87ef),
//       ),
//       drawer: buildDrawer(context),
//       body: Builder(
//         builder: (context) {
//           return ListView(
//             padding: EdgeInsets.all(16.0),
//             children: <Widget>[
//               createHeader(),
//               createSubTitle(),
//               createCartList(),
//               footer(context),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   Widget createHeader() {
//     return Container(
//       alignment: Alignment.topLeft,
//       margin: EdgeInsets.only(bottom: 12),
//       child: Text(
//         "SHOPPING CART",
//         style: TextStyle(
//           fontSize: 16,
//           fontWeight: FontWeight.bold,
//           color: Colors.black,
//         ),
//       ),
//     );
//   }

//   Widget createSubTitle() {
//     return Container(
//       alignment: Alignment.topLeft,
//       margin: EdgeInsets.only(bottom: 8),
//       child: Text(
//         "Total(3) Items", // Update dynamically with the number of items
//         style: TextStyle(
//           fontSize: 12,
//           fontWeight: FontWeight.bold,
//           color: Colors.grey,
//         ),
//       ),
//     );
//   }

//   Widget createCartList() {
//     return ListView.builder(
//       shrinkWrap: true,
//       primary: false,
//       itemBuilder: (context, position) {
//         return createCartListItem();
//       },
//       itemCount: 5, // Replace with the actual number of items in the cart
//     );
//   }

//   Widget createCartListItem() {
//     return Stack(
//       children: <Widget>[
//         Container(
//           margin: EdgeInsets.only(bottom: 16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.all(Radius.circular(16)),
//           ),
//           child: Row(
//             children: <Widget>[
//               Container(
//                 margin: EdgeInsets.all(8),
//                 width: 80,
//                 height: 80,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(14)),
//                   color: Colors.blue.shade200,
//                   image: DecorationImage(
//                     image: AssetImage(
//                         "assets/images/shoes_1.png"), // Replace with dynamic image path
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.max,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Container(
//                         padding: EdgeInsets.only(right: 8, top: 4),
//                         child: Text(
//                           "NIKE XTM Basketball Shoes", // Replace with dynamic item name
//                           maxLines: 2,
//                           softWrap: true,
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 6),
//                       Text(
//                         "Green M", // Replace with dynamic item details
//                         style: TextStyle(color: Colors.grey, fontSize: 14),
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(top: 8),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             Text(
//                               "\$299.00", // Replace with dynamic item price
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.green,
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: <Widget>[
//                                   GestureDetector(
//                                     onTap: () {
//                                       // Handle decrease quantity
//                                     },
//                                     child: Icon(
//                                       Icons.remove,
//                                       size: 24,
//                                       color: Colors.grey.shade700,
//                                     ),
//                                   ),
//                                   Container(
//                                     color: Colors.grey.shade200,
//                                     padding: const EdgeInsets.only(
//                                       bottom: 2,
//                                       right: 12,
//                                       left: 12,
//                                     ),
//                                     child: Text(
//                                       "1", // Replace with dynamic quantity
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                   GestureDetector(
//                                     onTap: () {
//                                       // Handle increase quantity
//                                     },
//                                     child: Icon(
//                                       Icons.add,
//                                       size: 24,
//                                       color: Colors.grey.shade700,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//         Positioned(
//           right: 0,
//           bottom: 0,
//           child: GestureDetector(
//             onTap: () {
//               // Handle remove item
//             },
//             child: Container(
//               width: 24,
//               height: 24,
//               alignment: Alignment.center,
//               margin: EdgeInsets.all(4),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.all(Radius.circular(4)),
//                 color: Colors.green,
//               ),
//               child: Icon(
//                 Icons.delete,
//                 color: Colors.white,
//                 size: 16,
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }

//   Widget footer(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(8.0),
//       child: Column(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.all(Radius.circular(4)),
//               color: Colors.white,
//             ),
//             margin: EdgeInsets.symmetric(vertical: 8.0),
//             padding: EdgeInsets.all(12.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "Total",
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                 ),
//                 Text(
//                   "\$1299.00", // Replace with dynamic total price
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                 ),
//               ],
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               // Handle checkout action
//               Get.to(() => CheckoutScreen()); // Navigate to CheckoutScreen
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Color(0xff2a87ef), // Use blue color
//               padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//             ),
//             child: Text(
//               "Checkout",
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Drawer function with consistent design
//   Widget buildDrawer(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: <Widget>[
//           UserAccountsDrawerHeader(
//             decoration: BoxDecoration(
//                 color: Color(0xff2a87ef)), // Blue background color
//             accountName: Text("Sher Ali"),
//             accountEmail: Text("sherali@example.com"),
//             currentAccountPicture: CircleAvatar(
//               backgroundColor: Colors.white,
//               child: Text(
//                 "SA",
//                 style: TextStyle(fontSize: 40.0),
//               ),
//             ),
//           ),
//           ListTile(
//             leading: Icon(Icons.home, color: Color(0xff2a87ef)),
//             title: Text('Home'),
//             onTap: () {
//               //  Get.offAll(() => HomePage()); // Navigate to HomeScreen
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.shopping_cart, color: Color(0xff2a87ef)),
//             title: Text('Cart'),
//             onTap: () {
//               Navigator.pop(
//                   context); // Close the drawer and remain on the Cart screen
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.person, color: Color(0xff2a87ef)),
//             title: Text('Profile'),
//             onTap: () {
//               Get.to(() => ProfilePage()); // Navigate to ProfilePage
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.logout, color: Color(0xff2a87ef)),
//             title: Text('Logout'),
//             onTap: () {
//               Get.offAll(() => SignInScreen()); // Navigate to LoginScreen
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
