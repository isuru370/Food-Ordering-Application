import 'package:flutter/material.dart';

class RoundContainerWidget extends StatelessWidget {
  final Function() onTap;
  final double width, height;
  final IconData? icon;
  const RoundContainerWidget(
      {super.key,
      required this.onTap,
      required this.width,
      required this.height,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          alignment: Alignment.center,
          width: width,
          height: height,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2, color: Colors.teal),
            boxShadow: const [
              BoxShadow(
                color: Colors.white,
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: Icon(icon)),
    );
  }
}
