import 'package:flutter/material.dart';
import '../helpers/helpers.dart';
import 'custom_image_view.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({
    super.key,
    required this.image,
    required this.estado,
    required this.graus,
  });

  final String image;
  final String estado;
  final String graus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        height: 100,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            SizedBox(
              width: 210,
              height: 60,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Opacity(
                      opacity: 0.50,
                      child: Container(
                        width: 210,
                        height: 50,
                        decoration: ShapeDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment(0.00, -1.00),
                            end: Alignment(0, 1),
                            colors: [Color(0xFF947CCD), Color(0xFF523D7F)],
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    top: 10,
                    child: CustomImageView(
                      imagePath: Helpers.imageClima(
                        image,
                      ),
                      width: 37,
                      height: 30,
                    ),
                  ),
                  Positioned(
                    left: 70,
                    top: 20,
                    child: Text(
                      estado,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 0.08,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 170,
                    top: 30,
                    child: Text(
                      graus,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 0.06,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 192,
                    top: 17,
                    child: Container(
                      width: 4,
                      height: 4,
                      decoration: const ShapeDecoration(
                        shape: OvalBorder(
                          side: BorderSide(width: 1, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
