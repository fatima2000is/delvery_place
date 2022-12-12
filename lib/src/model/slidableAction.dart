import 'package:flutter/material.dart';

class SlidableActionModel extends StatelessWidget {
  final String title;
  final String image;
  final Color color;
  final double border;

  const SlidableActionModel(
      {super.key,
      required this.title,
      required this.image,
      required this.color, required this.border});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(
            color: color, 
            borderRadius: 
             BorderRadius.only(
              topLeft: Radius.circular(border),
              topRight: Radius.circular(border),
              bottomLeft: Radius.circular(border),
              bottomRight: Radius.circular(border)

            
            )),
      //   decoration: const BoxDecoration(
      //       borderRadius: BorderRadius.only(
      //           topRight: Radius.circular(3), bottomRight: Radius.circular(3))),

      height: 150,
      width: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 50,
            color: Colors.white,
          ),
          Text(title)
        ],
      ),
    );
  }
}
