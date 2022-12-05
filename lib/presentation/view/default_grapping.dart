import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widget/default_container.dart';

class DefaultGrabbing extends StatelessWidget {
  DefaultGrabbing({Key? key, required this.color, required this.reverse})
      : super(key: key);
  final Color color;
  final bool reverse;
  BorderRadius _getBorderRadius() {
    var radius = const Radius.circular(20);
    return BorderRadius.only(
      bottomLeft: reverse ? Radius.zero : radius,
      bottomRight: reverse ? Radius.zero : radius,
      topLeft: reverse ? radius : Radius.zero,
      topRight: reverse ? radius : Radius.zero,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: _getBorderRadius(),
        color: color,
      ),
      child: const DefaultContainer(
          borderRadius: 10.0,
          color: Colors.grey,
          width: 40.0,
          height: 5.0,
          widget: SizedBox(),
        ),
    );
  }
}
