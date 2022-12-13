import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:magdsoft_flutter_structure/presentation/styles/colors.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/default_text.dart';

class TextErrorWidget extends StatelessWidget {
  const TextErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: DefaultText(
        color: AppColor.red,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        text: "No Data Loaded , try again",
      ),
    );
  }
}