import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getx_mvc_templet/common/color_manager.dart';

class CustomTimePicker extends StatelessWidget {
  const CustomTimePicker({Key? key, required this.onTap, required this.textDate})
      : super(key: key);
  final void Function() onTap;
  final String textDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Icon(
              Icons.calendar_today,
              size: 22.sp,
              color: ColorManager.main,
            ),
            SizedBox(width: 10.w),
            Text(
              textDate,
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
                color: ColorManager.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
