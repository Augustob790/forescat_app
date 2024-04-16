import 'package:flutter/material.dart';
import 'package:forecast_app/core/widgets/custom_text.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.info,
    required this.text,
  });

  final String info;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 120,
      decoration: ShapeDecoration(
        gradient: const LinearGradient(
          begin: Alignment(0.00, -1.00),
          end: Alignment(0, 1),
          colors: [Color(0xFF947CCD), Color(0xFF523D7F)],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: text,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                height: 0.08,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: info,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                height: 0.08,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
