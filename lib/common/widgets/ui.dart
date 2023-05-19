
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_mvc_templet/common/color_manager.dart';

class Ui {
  static GetSnackBar successSnackBar(
      {String title = 'Success', String? message}) {
    Get.log("[$title] $message");
    return GetSnackBar(
      titleText: Text(title.tr,
          style: Get.textTheme.headline6
              ?.merge(TextStyle(color: Get.theme.primaryColor))),
      messageText: Text(message!,
          style: Get.textTheme.caption
              ?.merge(TextStyle(color: Get.theme.primaryColor))),
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(30.h),
      backgroundColor: Colors.green,
      icon: Icon(Icons.check_circle_outline,
          size: 32.sp, color: Get.theme.primaryColor),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      borderRadius: 8.h,
      dismissDirection: DismissDirection.horizontal,
      duration: const Duration(seconds: 3),
    );
  }

  static GetSnackBar errorSnackBar({String title = 'Error', String? message}) {
    Get.log("[$title] $message", isError: true);
    return GetSnackBar(
      titleText: Text(title.tr,
          style: Get.textTheme.titleLarge
              ?.merge(TextStyle(color: ColorManager.white))),
      messageText: Text(message!,
          style: Get.textTheme.bodySmall
              ?.merge(TextStyle(color: ColorManager.white))),
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(30.h),
      backgroundColor: Colors.redAccent,
      icon: Icon(Icons.remove_circle_outline,
          size: 32.sp, color: ColorManager.white),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      borderRadius: 8.h,
      duration: const Duration(seconds: 3),
    );
  }
}