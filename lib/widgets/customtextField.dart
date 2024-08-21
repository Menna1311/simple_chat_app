import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomtextField extends StatelessWidget {
  CustomtextField({super.key, required this.hint, required this.onChange});
  String hint;
  Function(String) onChange;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
      // ignore: body_might_complete_normally_nullable
      validator: (value) {
        if (value!.isEmpty) {
          return 'this field is required';
        }
      },
      onChanged: onChange,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        label: Text(
          hint,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
