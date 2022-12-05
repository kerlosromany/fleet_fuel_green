import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DefaultContainer extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Widget widget;
  final double borderRadius;
  const DefaultContainer(
      {Key? key,
      required this.color,
      required this.width,
      required this.height,
      required this.widget,
      required this.borderRadius,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: color,
      ),
      child: widget,
    );
  }
}
