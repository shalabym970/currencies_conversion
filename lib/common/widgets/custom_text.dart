import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../color_manager.dart';

class CustomText extends StatelessWidget {
  const CustomText({Key? key, required this.text, this.size, this.color})
      : super(key: key);
  final String text;
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size ?? 20.sp,
        fontWeight: FontWeight.bold,
        color: color ?? ColorManager.main,
      ),
    );
  }
}
