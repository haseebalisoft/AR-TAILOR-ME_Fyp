import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String title;
  final Function() onClick;
  const CommonButton({super.key, required this.onClick, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 10,
          ),
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          decoration: BoxDecoration(
              color: Color(0xff2a87ef), borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                letterSpacing: 2,
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          )),
    );
  }
}
