import 'package:flutter/material.dart';

class TextFieldeLynda extends StatelessWidget {
  final String hintText;
  final String? Function(String?)? validator;
  final Widget icon;
  final bool obscureText;
  final Widget? prefexicon;
  final TextEditingController controller;
  final TextInputType type;
  const TextFieldeLynda({
    Key? key,
    required this.hintText,
    this.prefexicon,
    this.obscureText = false,
    required this.validator,
    required this.icon,
    required this.controller,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      keyboardType: type,
      decoration: InputDecoration(
          prefix: prefexicon,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.0,
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.0,
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.0,
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.0,
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.0,
              color: Colors.red.withOpacity(0.5),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.0,
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          prefixIconColor: Colors.black,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          hintText: hintText,
          hintStyle:
              TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.4)),
          suffixIcon: Container(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: icon,
          )),
    );
  }
}
