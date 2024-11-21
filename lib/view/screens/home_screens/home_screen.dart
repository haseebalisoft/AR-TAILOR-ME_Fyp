import 'package:flutter/material.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:tailer_app/view/screens/home_screens/cart-screen.dart';
import 'package:tailer_app/view/screens/home_screens/pages/ar_page.dart';
import 'package:tailer_app/view/screens/home_screens/pages/cart_page.dart';
import 'package:tailer_app/view/screens/home_screens/pages/home_page.dart';
import 'package:tailer_app/view/screens/home_screens/pages/library_page.dart';
import 'package:tailer_app/view/screens/home_screens/pages/search_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Pages for the navigation tabs
  final List<Widget> pages = [
    HomePage(),
    // Functional Search Page
    ArScreen(),
    CartScreen(),
    // LibraryPage(),
  ];

  CircularBottomNavigationController? _navigationController;

  @override
  void initState() {
    super.initState();
    // Initialize the controller with the selected index
    _navigationController = CircularBottomNavigationController(_selectedIndex);
  }

  @override
  void dispose() {
    // Dispose the navigation controller to prevent memory leaks
    _navigationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      // Display the selected page based on _selectedIndex
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: CircularBottomNavigation(
        [
          TabItem(Icons.home, "Home", Colors.blue,
              labelStyle: const TextStyle(color: Colors.white)),
          TabItem(Icons.archive, "AR", Colors.blue,
              labelStyle: const TextStyle(color: Colors.white)),
          TabItem(Icons.shopping_cart, "Cart", Colors.blue,
              labelStyle: const TextStyle(color: Colors.white)),
        ],
        controller: _navigationController,
        barBackgroundColor: Theme.of(context).primaryColor,
        selectedCallback: (int? selectedIndex) {
          // Update the selected index when a tab is selected
          setState(() {
            _selectedIndex = selectedIndex!;
          });
        },
      ),
    );
  }
}
