import 'package:flutter/material.dart';

class ButtonHome extends StatelessWidget {
  final Color bagroudcolor;
  final String assetsicons;
  final String title;
  final String? index;
  const ButtonHome({
    Key? key,
    required this.bagroudcolor,
    required this.assetsicons,
    required this.title,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(bottom: 12, top: 16, left: 12, right: 12),
      decoration: BoxDecoration(
          color: bagroudcolor,
          borderRadius: const BorderRadius.all(Radius.circular(12))),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            //crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 22,
              ),
              CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white,
                  child: Image.asset(
                    assetsicons,
                    height: 25,
                    color: bagroudcolor,
                  ))
            ],
          ),
          const Text(
            "1",
          )
        ],
      ),
    );
  }
}
