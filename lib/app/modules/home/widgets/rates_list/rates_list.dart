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
          return Column(
            children: [
              Expanded(
                  child: RefreshIndicator(
                      onRefresh: controller.refreshRates,
                      child: ListView.builder(
                        padding: EdgeInsets.only(bottom: 5.h, top: 5.h),
                        primary: false,
                        controller: controller.scrollController,
                        shrinkWrap: true,
                        itemCount: controller.rates.length,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: ((_, index) {
                          List<Rate> rate = controller.rates.elementAt(index);
                          return RateItem(rates: rate);
                        }),
                      ))),
              if (controller.loadingMoreRates.isTrue)
                Padding(
                  padding: EdgeInsets.only(bottom: 5.h, top: 5.h),
                  child: Center(
                    child: Center(
                      child:
                          CircularProgressIndicator(color: ColorManager.main),
                    ),
                  ),
                ),
              if (controller.hasMore.isFalse)
                Container(
                  padding: EdgeInsets.only(bottom: 5.h, top: 5.h),
                  child: Center(
                    child: Center(
                      child: Text(
                        "You have fetched all of the content",
                        style: TextStyle(fontSize: 16.sp, color: Colors.black),
                      ),
                    ),
                  ),
                )
            ],
          );
        }
      }
    });
  }
}
