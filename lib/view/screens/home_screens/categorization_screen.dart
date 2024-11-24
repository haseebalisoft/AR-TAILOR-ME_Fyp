// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:tailer_app/view/screens/home_screens/cart-screen.dart';
// import 'package:tailer_app/view/screens/home_screens/pages/cart_page.dart';
// import 'package:tailer_app/view/screens/home_screens/pages/profile_page.dart';
// import 'package:tailer_app/view/auth/login_screen.dart';
// import 'package:tailer_app/widget/common_button.dart';
// import 'package:tailer_app/widget/common_drop_down.dart';

// import 'package:tailer_app/view/screens/home_screens/customization_screen.dart'; // Import the next screen

// class CustomizationScreen extends StatefulWidget {
//   CustomizationScreen({super.key});

//   @override
//   State<CustomizationScreen> createState() => _CustomizationScreenState();
// }

// class _CustomizationScreenState extends State<CustomizationScreen> {
//   String selectedGender = "Men";
//   String selectedFabric = "Casual";
//   String selectedMaterial = "Fabric 0"; // Default selection

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).primaryColor,
//       appBar: AppBar(
//         leading: Builder(
//           builder: (context) => IconButton(
//             icon: const Icon(Icons.menu),
//             onPressed: () => Scaffold.of(context).openDrawer(),
//           ),
//         ),
//         title: const Text("Customization"),
//       ),
//       drawer: buildDrawer(context), // Integrate the drawer here
//       body: SingleChildScrollView(
//         child: Container(
//           width: MediaQuery.of(context).size.width,
//           decoration: const BoxDecoration(
//             color: Color(0xffd9d9d9),
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(60),
//               topRight: Radius.circular(60),
//             ),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 15),
//                 Text(
//                   "Customize My Dress",
//                   style: TextStyle(
//                     fontSize: 28,
//                     color: Theme.of(context).primaryColor,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Divider(
//                   thickness: 3,
//                   color: Theme.of(context).primaryColor,
//                 ),
//                 Text(
//                   "Gender",
//                   style: TextStyle(
//                     fontSize: 19,
//                     color: Theme.of(context).primaryColor,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     Radio(
//                       value: "Men",
//                       groupValue: selectedGender,
//                       onChanged: (value) {
//                         setState(() {
//                           selectedGender = value!;
//                         });
//                       },
//                     ),
//                     const SizedBox(width: 5),
//                     Text(
//                       "Men",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w400,
//                         color: Theme.of(context).primaryColor,
//                       ),
//                     ),
//                     Radio(
//                       value: "Women",
//                       groupValue: selectedGender,
//                       onChanged: (value) {
//                         setState(() {
//                           selectedGender = value!;
//                         });
//                       },
//                     ),
//                     const SizedBox(width: 5),
//                     Text(
//                       "Women",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w400,
//                         color: Theme.of(context).primaryColor,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   "Choose Dress Type",
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Theme.of(context).primaryColor,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 CommonDropDown(
//                   options: ['Casual', 'Formal', 'Sportswear', 'Traditional'],
//                   labelText: "Select",
//                   onChange: (value) {
//                     setState(() {
//                       selectedFabric = value!;
//                     });
//                   },
//                   initalValue: selectedFabric,
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   "Choose Material From Our Store",
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     color: Theme.of(context).primaryColor,
//                   ),
//                 ),
//                 ListView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: 3,
//                   itemBuilder: (context, index) {
//                     return GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           selectedMaterial = "Fabric $index";
//                         });
//                       },
//                       child: Container(
//                         margin: const EdgeInsets.symmetric(vertical: 5),
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 10,
//                           vertical: 10,
//                         ),
//                         decoration: BoxDecoration(
//                           color: selectedMaterial == "Fabric $index"
//                               ? Colors.blue.shade100
//                               : Colors.grey.shade100,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Column(
//                           children: [
//                             Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Column(
//                                   children: [
//                                     Text(
//                                       "Rs. 999",
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold,
//                                         color: Theme.of(context).primaryColor,
//                                       ),
//                                     ),
//                                     Text(
//                                       "Fabric $index",
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold,
//                                         color: Theme.of(context).primaryColor,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(width: 8),
//                                 Image.asset(
//                                   "assets/cus$index.png",
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 8),
//                             Text(
//                               "Add to Design",
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: Theme.of(context).primaryColor,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//                 const SizedBox(height: 20),
//                 CommonButton(
//                   onClick: () {
//                     Get.to(() => CustomizationScreenTwo(
//                           gender: selectedGender,
//                           fabric: selectedFabric,
//                           material: selectedMaterial,
//                         ));
//                   },
//                   title: "Next",
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildDrawer(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: <Widget>[
//           UserAccountsDrawerHeader(
//             decoration:
//                 const BoxDecoration(color: Color.fromARGB(255, 99, 101, 216)),
//             accountName: const Text("Sher Ali"),
//             accountEmail: const Text("sherali@example.com"),
//             currentAccountPicture: const CircleAvatar(
//               backgroundColor: Colors.white,
//               child: Text(
//                 "SA",
//                 style: TextStyle(fontSize: 40.0),
//               ),
//             ),
//           ),
//           ListTile(
//             leading: const Icon(Icons.shopping_cart),
//             title: const Text('Cart'),
//             onTap: () {
//               Get.to(() => CartScreen()); // Navigate to CartPage
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.person),
//             title: const Text('Profile'),
//             onTap: () {
//               Get.to(() => ProfilePage()); // Navigate to ProfilePage
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.logout),
//             title: const Text('Logout'),
//             onTap: () {
//               // Handle logout functionality
//               Get.offAll(() => SignInScreen()); // Navigate to LoginPage
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
