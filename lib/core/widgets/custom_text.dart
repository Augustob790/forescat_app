import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {super.key,
      required this.text,
      required this.fontSize,
      required this.fontWeight,
      this.color = Colors.white,
      required this.height});

  final String text;
  final double fontSize;
  final double height;
  final FontWeight fontWeight;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: 'Poppins',
        fontWeight: fontWeight,
        height: 0.08,
      ),
    );
  }
}
