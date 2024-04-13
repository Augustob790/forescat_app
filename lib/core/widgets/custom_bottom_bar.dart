import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 312,
      height: 50,
      child: Stack(
        children: [
          Positioned(
            left: 80,
            top: 0,
            child: Opacity(
              opacity: 0.50,
              child: Container(
                width: 50,
                height: 50,
                decoration: const ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.00, -1.00),
                    end: Alignment(0, 1),
                    colors: [Color(0xFF947CCD), Color(0xFF523D7F)],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(22),
                      topRight: Radius.circular(21),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 15,
            child: Container(
              width: 24,
              height: 24,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
              child: const Stack(children: [
                Icon(
                  Icons.home,
                  color: Colors.white,
                )
              ]),
            ),
          ),
          Positioned(
            left: 92,
            top: 15,
            child: Container(
              width: 24,
              height: 24,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
              child: const Stack(children: [
                Icon(
                  Icons.search,
                  color: Colors.white,
                )
              ]),
            ),
          ),
          Positioned(
            left: 184,
            top: 15,
            child: Container(
              width: 24,
              height: 24,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
              child: const Stack(children: [
                Icon(
                  Icons.person_outline,
                  color: Colors.white,
                )
              ]),
            ),
          ),
          Positioned(
            left: 276,
            top: 15,
            child: Container(
              width: 24,
              height: 24,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
              child: const Stack(children: [
                Icon(
                  Icons.notifications_none_outlined,
                  color: Colors.white,
                )
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
