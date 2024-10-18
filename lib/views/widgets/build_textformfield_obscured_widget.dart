import 'package:drizzle/viewModels/provider/login_provider.dart';
import 'package:drizzle/viewModels/provider/signup_provider.dart';
import 'package:drizzle/views/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuildTextformfieldObscuredWidget extends StatelessWidget {
  final TextEditingController textController;

  const BuildTextformfieldObscuredWidget({
    super.key,
    required this.textController,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpProvider>(
      builder: (context, signUpProvider, child) => Consumer<LoginProvider>(
        builder: (context, loginProvider, child) => TextFormField(
          obscureText: true,
          controller: textController,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.outline),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: primaryBlueColor),
            ),
          ),
        ),
      ),
    );
  }
}
