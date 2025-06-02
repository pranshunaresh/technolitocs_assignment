import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final double elevation;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.backgroundColor = Colors.black,
    this.textColor = const Color(0xffF5F5F5),
    this.fontSize = 16.0,
    this.elevation = 0.0,
    required Null Function() Function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        padding: const EdgeInsets.symmetric(vertical: 12),
        elevation: elevation,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 15),
          Image.asset(
            'assets/images/forward_arrow.png',
            width: 25,
            height: 25,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
