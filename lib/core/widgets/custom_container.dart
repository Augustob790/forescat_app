import 'package:flutter/material.dart';
import 'custom_image_view.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key, this.image, this.horario, this.grau});

  final String? image;
  final String? horario;
  final String? grau;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 115,
      height: 155,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: SizedBox(
              width: 115,
              height: 155,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Opacity(
                      opacity: 0.50,
                      child: Container(
                        width: 115,
                        height: 155,
                        decoration: ShapeDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment(0.00, -1.00),
                            end: Alignment(0, 1),
                            colors: [Color(0xFF947CCD), Color(0xFF523D7F)],
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    top: 50,
                    child: CustomImageView(
                      imagePath: image,
                      width: 40.36,
                      height: 46.97,
                    ),
                  ),
                  Positioned(
                    left: 35,
                    top: 30,
                    child: SizedBox(
                      width: 85.26,
                      height: 28.18,
                      child: Text(
                        horario ?? '',
                        style: const TextStyle(
                          color: Color(0xFFDEDDDD),
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          height: 0.12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 45,
            top: 125,
            child: SizedBox(
              width: 21.36,
              height: 28.18,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 10,
                    child: SizedBox(
                      width: 18.85,
                      height: 28.18,
                      child: Text(
                        grau ?? '',
                        style: const TextStyle(
                          color: Color(0xFFDEDDDD),
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          height: 0.12,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 18,
                    top: 1,
                    child: Container(
                      width: 2.51,
                      height: 3.13,
                      decoration: const ShapeDecoration(
                        shape: OvalBorder(
                          side: BorderSide(
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignOutside,
                            color: Color(0xFFDEDDDD),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
