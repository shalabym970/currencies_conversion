import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../color_manager.dart';
import '../images_paths.dart';
import '../strings.dart';
class FutureDialogs {
  Future noInternetConnectionDialog() {
    return Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticOut,
      backgroundColor: Colors.white,
      boxShadows: [
        BoxShadow(
            color: ColorManager.main,
            offset: const Offset(1, 2.0),
            blurRadius: 3.0)
      ],
      isDismissible: false,
      duration: const Duration(seconds: 4),
      icon: ImageIcon(
         AssetImage(ImagesPaths.noInternetPng),
        size: 40.sp,
        color: ColorManager.red,
      ),
      showProgressIndicator: true,
      progressIndicatorBackgroundColor: ColorManager.main,
      titleText: Directionality(
        textDirection: TextDirection.rtl,
        child: Text(
          "Oops..!!",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
              color: ColorManager.red,
              fontFamily: "ShadowsIntoLightTwo"),
        ),
      ),
      messageText: Directionality(
        textDirection: TextDirection.rtl,
        child: Text(
          Strings.notConnectedWithInternet,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.sp,
              color: ColorManager.black,
              fontFamily: "ShadowsIntoLightTwo"),
        ),
      ),
    ).show(Get.context!);
  }
}