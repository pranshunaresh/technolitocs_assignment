import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final double fontSize;

  const GradientText({
    Key? key,
    required this.text,
    this.style = const TextStyle(fontSize: 16),
    this.fontSize = 16.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [Color(0xff2BC0E4), Color(0xffEAECC6)],  // Gradient colors
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds),
      child: Text(
        text,
        style: style.copyWith(
          color: Colors.white,
          fontFamily: 'Movatif',
          fontSize: fontSize,
        ),
      ),
    );
  }
}

