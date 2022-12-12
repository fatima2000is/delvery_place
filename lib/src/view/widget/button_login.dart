// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonLynda extends StatelessWidget {
  final double height;
  final Color coloshadow;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double width;
  final double? widthbox;
  final Color colorBackground;
  final Color colotBorder;
  final Color colorText;
  final VoidCallback onPress;
  final String textButton;
  final MainAxisAlignment mainAxisAlignment;

  IconData? icon;
  ButtonLynda({
    Key? key,
    this.height = 45,
    this.coloshadow = Colors.white,
    this.padding,
    this.margin,
    this.width = double.infinity,
    this.widthbox = 0,
    this.colorBackground = Colors.black,
    this.colotBorder = Colors.black,
    this.colorText = Colors.white,
    required this.onPress,
    required this.textButton,
    required this.mainAxisAlignment,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        padding: padding,
        margin: margin,
        height: height,
        width: width,
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: coloshadow, blurRadius: 0.3)],
          color: colorBackground,
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
          border: Border.all(
            color: colotBorder,
            width: 1,
          ),
        ),
        child: Center(
          // padding: padding,
          child: Text(
            textButton,
            style: GoogleFonts.poppins(
              color: colorText,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
