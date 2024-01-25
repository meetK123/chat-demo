import 'package:flutter/material.dart';

class AppNameIcon extends StatelessWidget {
  const AppNameIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// launcher icon
        Image.asset('assets/icons/ic_lunch.png', height: 30),
        const Text(
          ' Cheat Chat',
          style: TextStyle(fontSize: 22),
        ),
      ],
    );
  }
}
