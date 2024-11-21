import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tailer_app/view/screens/home_screens/all-categories-screen.dart';
import 'package:tailer_app/view/screens/home_screens/all-flash-sale-products.dart';
import 'package:tailer_app/view/screens/home_screens/ar_Measurement_screen.dart';
import 'package:tailer_app/view/screens/home_screens/ar_try_screen.dart';
import 'package:tailer_app/view/screens/home_screens/cart-screen.dart';
import 'package:tailer_app/view/screens/home_screens/categorization_screen.dart';
import 'package:tailer_app/view/screens/home_screens/category_collection.dart';
import 'package:tailer_app/view/screens/home_screens/designer_collection.dart';
import 'package:tailer_app/view/screens/home_screens/pages/cart_page.dart';
import 'package:tailer_app/view/screens/home_screens/pages/library_page.dart';
import 'package:tailer_app/view/screens/home_screens/pages/profile_page.dart';
import 'package:tailer_app/view/screens/home_screens/product_list_screen.dart';
import 'package:tailer_app/view/auth/login_screen.dart';
import 'package:tailer_app/widget/banner-widget.dart';
import 'package:tailer_app/widget/category-widget.dart';
import 'package:tailer_app/widget/flash-sale-widget.dart';
import 'package:tailer_app/widget/heading-widget.dart';

// Define the data lists inside the file
List<String> categories = ['Men', 'Women', 'Kids'];
List<Category> categoriesList = [
  Category(price: "3000", image: "assets/cate1.png", title: "T-Shirt"),
  Category(price: "3000", image: "assets/cate2.png", title: "Kids Suits"),
  Category(price: "3000", image: "assets/cate3.png", title: "Kameez"),
];
List<Discover> discoverList = [
  Discover(image: "assets/disc1.png", title: "Customize Dress"),
  Discover(image: "assets/disc2.png", title: "Designer Collection"),
  Discover(image: "assets/disc3.png", title: "AR TRY"),
  Discover(image: "assets/disc4.png", title: "AR Measurement"),
];

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text("Dashboard"),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () => Get.to(() => CartScreen()),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                Icons.shopping_cart,
              ),
            ),
          ),
        ],
      ),
      drawer: buildDrawer(context),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color:
                Colors.white.withOpacity(0.9), // Light transparent background
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(60),
              topRight: Radius.circular(60),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50), // Increased spacing for better UI
                BannerWidget(),
                SizedBox(height: 20),
                HeadingWidget(
                  headingTitle: "Categories",
                  headingSubTitle: "According to Your Vision",
                  onTap: () => Get.to(() => AllCategoriesScreen()),
                  buttonText: "See More >",
                  child: Text(""),
                ),

                CategoriesWidget(),
                SizedBox(height: 12),
                HeadingWidget(
                  headingTitle: "Flash Sale",
                  headingSubTitle: "According to your budget",
                  onTap: () => Get.to(() => AllFlashSaleProductScreen()),
                  buttonText: "See More >",
                  child: Text(""),
                ),

                FlashSaleWidget(),
                SizedBox(height: 29),
                Text(
                  "Discover",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(height: 30),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: discoverList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 150,
                  ),
                  itemBuilder: (context, index) {
                    final disc = discoverList[index];
                    return GestureDetector(
                      onTap: () {
                        // Navigate based on the discover item clicked
                        switch (index) {
                          case 0:
                            Get.to(() => CustomizationScreen());
                            break;
                          case 1:
                            Get.to(() => CameraScreen());
                            break;
                          case 2:
                            Get.to(() => AddMeasurementScreen(
                                  imageUrl: 'assets/shirt1.png',
                                  price: '50 USD',
                                  title: 'Shirt Measurement',
                                ));
                            break;
                        }
                      },
                      child: discoverTile(
                        image: disc.image,
                        title: disc.title,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
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
            accountName: Text("Khalid"),
            accountEmail: Text("kalidawan@gmail.com"),
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

  Widget discoverTile({
    required String image,
    required String title,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8), // Light transparent background
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: Color(0xff2a87ef),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                image,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Color(0xff8256ea),
            ),
          ),
        ],
      ),
    );
  }

  Widget categoryTile({
    required String title,
    required String image,
    required String price,
  }) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      width: 130,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8), // Light transparent background
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
            height: 100,
            decoration: BoxDecoration(
              color: Color(0xff2a87ef),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "PKR",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    Text(
                      price,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ],
                ),
                Image.asset(image),
              ],
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: Color(0xff8256ea),
            ),
          ),
        ],
      ),
    );
  }
}

// Top-level definitions for Discover and Category classes
class Discover {
  final String title;
  final String image;
  Discover({required this.title, required this.image});
}

class Category {
  final String price;
  final String image;
  final String title;
  Category({required this.price, required this.image, required this.title});
}
