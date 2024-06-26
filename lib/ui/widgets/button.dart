import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;

  const CustomElevatedButton({
    super.key, // Add the key parameter
    required this.text,
    required this.onPressed,
    this.backgroundColor = const Color(0xFFAC2324),
    this.textColor = Colors.white,
  }); // Assign the key parameter to the super constructor

  @override
  Widget build(BuildContext context) {
    return Container(
      // Wrap the ElevatedButton with a Container
      margin:
          const EdgeInsets.symmetric(horizontal: 50), // Set the margin to 50
      height: 50,
      width: 350, // Set the height to 50
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
          foregroundColor: textColor,
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 1,
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
