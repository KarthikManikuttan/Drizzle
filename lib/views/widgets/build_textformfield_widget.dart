import 'package:drizzle/views/theme/theme.dart';
import 'package:flutter/material.dart';

class BuildTextformfieldWidget extends StatelessWidget {
  final TextEditingController textController;
  const BuildTextformfieldWidget({
    super.key,
    required this.textController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.outline),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: primaryBlueColor),
        ),
      ),
    );
  }
}
