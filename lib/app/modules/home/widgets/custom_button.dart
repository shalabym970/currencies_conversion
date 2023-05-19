import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/color_manager.dart';
import '../../../../common/widgets/custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.text,  required this.onPressed}) : super(key: key);
 final String text;
 final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      child: TextButton(

          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(ColorManager.main),
                      foregroundColor: MaterialStateProperty.all<Color>(ColorManager.main),
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered)) {
                  return ColorManager.main.withOpacity(0.04);
                }
                if (states.contains(MaterialState.focused) ||
                    states.contains(MaterialState.pressed)) {
                  return ColorManager.main.withOpacity(0.12);
                }
                return null; // Defer to the widget's default.
              },
            ),
          ),
          onPressed: onPressed,
          child:  Padding(
            padding: EdgeInsets.symmetric( horizontal: 20.w),
            child: CustomText(text: text,color: ColorManager.gold,size: 20.sp,),
          )

      ),
    );
  }
}
