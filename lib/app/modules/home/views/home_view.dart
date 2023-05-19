import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common/color_manager.dart';
import '../../../../common/constants.dart';
import '../../../../common/images_paths.dart';
import '../../../../common/strings.dart';
import '../../../../common/widgets/custom_loading.dart';
import '../../../../common/widgets/custom_text.dart';
import '../../../models/currency.dart';
import '../controllers/Home_controller.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_drop_down.dart';
import '../widgets/custom_time_picker.dart';
import '../widgets/rates_list/rates_list.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.main,
        foregroundColor: ColorManager.black,
        elevation: 0.0,
        title: Center(
          child: Text(
            Strings.currencyConvert,
            style: TextStyle(
              color: ColorManager.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SafeArea(
          child: Obx(
        () => controller.loading.isTrue
            ? const CustomLoading()
            : Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 10.h),
                    Image.asset(
                      ImagesPaths.logo,
                      height: 120.h,
                      width: 150.w,
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomText(text: Strings.convert),
                        CustomDropDown(
                          value: controller.baseCurrency.value,
                          onChanged: (currency) {
                            controller.baseCurrency.value = currency!;
                            controller.getCurrenciesConversion();

                          },
                          items: controller.currencies
                              .map<DropdownMenuItem<Currency>>((currency) {
                            return DropdownMenuItem<Currency>(
                                value: currency,
                                child: CustomText(
                                  text: currency.code.toString(),
                                  color: ColorManager.black,
                                  size: 22.sp,
                                ));
                          }).toList(),
                        ),
                        const CustomText(text: Strings.to),
                        CustomDropDown(
                          value: controller.targetCurrency.value,
                          onChanged: (currency) {
                            controller.targetCurrency.value = currency!;
                            controller.getCurrenciesConversion();

                          },
                          items: controller.currencies
                              .map<DropdownMenuItem<Currency>>((value) {
                            return DropdownMenuItem<Currency>(
                                value: value,
                                child: CustomText(
                                  text: value.code.toString(),
                                  color: ColorManager.black,
                                  size: 22.sp,
                                ));
                          }).toList(),
                        ),
                        const CustomText(
                          text: Strings.currency,
                        )
                      ],
                    ),
                    SizedBox(height: 30.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CustomText(text: Strings.from),
                        CustomTimePicker(
                          textDate:
                              controller.startDate.toString().substring(0, 10),
                          onTap: () async {
                            final selectedDate = await showDatePicker(
                              context: context,
                              initialDate: controller.startDate.value,
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now(),
                            );
                            if (selectedDate != null) {
                              controller.startDate.value = selectedDate;
                              controller.getCurrenciesConversion();

                            }
                          },
                        ),
                        const CustomText(text: Strings.to),
                        CustomTimePicker(
                            textDate:
                                controller.endDate.toString().substring(0, 10),
                            onTap: () async {
                              final selectedDate = await showDatePicker(
                                context: context,
                                initialDate: controller.endDate.value,
                                firstDate: DateTime(2000),
                                lastDate: DateTime.now(),
                              );
                              if (selectedDate != null) {
                                controller.endDate.value = selectedDate;
                                controller.getCurrenciesConversion();

                              }
                            }),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    CustomButton(
                      text: Strings.convertNow,
                      onPressed: () async {
                        var connectivityResult =
                            await (Connectivity().checkConnectivity());
                        if (connectivityResult == ConnectivityResult.mobile ||
                            connectivityResult == ConnectivityResult.wifi) {
                          controller.getCurrenciesConversion();
                        } else {
                          await Constants.futureDialogs
                              .noInternetConnectionDialog();
                        }
                      },
                    ),
                    const Expanded(
                      child: RatesList(),
                    ),
                  ],
                ),
              ),
      )),
    );
  }
}
