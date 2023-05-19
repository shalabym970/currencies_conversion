import 'package:currency_converter/app/modules/home/widgets/rates_list/rates_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../common/color_manager.dart';
import '../../../../../common/strings.dart';
import '../../../../../common/widgets/custom_loading.dart';
import '../../../../../common/widgets/nothing_data.dart';
import '../../../../models/rate.dart';
import '../../controllers/Home_controller.dart';

class RatesList extends GetView<HomeController> {
  const RatesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.loadingRates.isTrue) {
        return const CustomLoading();
      } else {
        if (controller.rates.isEmpty) {
          return NothingData(
            fontColor: ColorManager.black,
            content: Strings.nothingData,
          );
        } else {
          return ListView.builder(
            padding: EdgeInsets.only(bottom: 5.h, top: 5.h),
            primary: false,
            shrinkWrap: true,
            itemCount: controller.rates.length,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: ((_, index) {
              List<Rate> rate = controller.rates.elementAt(index);
              return RateItem(rates: rate);
            }),
          );
        }
      }
    });
  }
}
