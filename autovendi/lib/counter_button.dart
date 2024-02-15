import 'package:flutter/material.dart';

class CounterButton extends StatelessWidget {
  const CounterButton({super.key, required this.iconData, required this.onPressed});

  final IconData iconData;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:8, right: 8),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              minimumSize: const Size(50, 50),
              padding: const EdgeInsets.only(left: 8, right:8)

          ),
          onPressed: onPressed, child: Icon(iconData)),
    );
  }
}