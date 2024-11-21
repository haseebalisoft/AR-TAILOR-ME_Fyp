import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DesignerCollection extends StatelessWidget {
  DesignerCollection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
        ),
        title: Text("Designer Collection"),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Color(0xffd9d9d9),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(60),
              topRight: Radius.circular(60),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 120,
                          height: 200,
                          child: Image.asset("assets/des1.png"),
                        ),
                        Positioned(
                          bottom: 10,
                          child: Container(
                            width: 120,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text("Winter Specials"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Container(
                          width: 120,
                          height: 200,
                          child: Image.asset("assets/des2.png"),
                        ),
                        Positioned(
                          bottom: 10,
                          child: Container(
                            width: 120,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white.withOpacity(0.7),
                            ),
                            child: Center(
                              child: Text("Pents"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 13),
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).primaryColor,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Text(
                                      "Men",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Text(
                                      "Explore Now",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Image.asset("assets/exp${index + 1}.png"),
                          )
                        ],
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
