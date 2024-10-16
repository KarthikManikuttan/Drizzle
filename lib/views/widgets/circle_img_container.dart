import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CircleImgContainer extends StatelessWidget {
  final String img;
  final Color? color;
  final VoidCallback onTap;
  const CircleImgContainer({
    super.key,
    required this.img,
    this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: color ?? Theme.of(context).colorScheme.primary,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SvgPicture.asset(
            img,
          ),
        ),
      ),
    );
  }
}
