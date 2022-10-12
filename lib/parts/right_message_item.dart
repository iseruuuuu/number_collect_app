import 'package:flutter/material.dart';

class RightMessageItem extends StatelessWidget {
  const RightMessageItem({
    Key? key,
    required this.text,
    required this.width,
  }) : super(key: key);

  final String text;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 15),
      child: Row(
        children: [
          Container(
            width: width,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Container(),
        ],
      ),
    );
  }
}
