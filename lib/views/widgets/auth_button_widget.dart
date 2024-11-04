import 'package:drizzle/views/utils/utils.dart';
import 'package:flutter/material.dart';

class AuthButtonWidget extends StatelessWidget {
  final void Function()? onTap;
  final Color buttonColor;
  final Color textColor;
  final String text;
  final bool isLoading;

  const AuthButtonWidget({
    super.key,
    required this.onTap,
    required this.textColor,
    required this.buttonColor,
    required this.text,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: screenWidth(context),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  text,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Outfit",
                  ),
                ),
        ),
      ),
    );
  }
}
