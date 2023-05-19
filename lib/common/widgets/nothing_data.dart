import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../strings.dart';

class NothingData extends StatelessWidget {
  const NothingData({Key? key, required this.fontColor, required this.content})
      : super(key: key);
  final Color fontColor;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(content, style: TextStyle(fontSize: 15.sp, color: fontColor,fontWeight: FontWeight.bold)),
    );
  }
}
