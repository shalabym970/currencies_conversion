import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common/strings.dart';
import '../../../models/currency.dart';
import '../controllers/Home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.0,
        title: const Text(
          Strings.currencyConvert,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
          child: Obx(
        () => controller.loading.isTrue
            ? CircularProgressIndicator()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Text(
                          'Convert',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 10),
                        DropdownButton<CurrencyRate>(
                          value: controller.targetCurrency,
                          onChanged: (value) {
                            controller.targetCurrency = value!;

                            controller.getCurrencies();
                          },
                          items: controller.currencies
                              .map<DropdownMenuItem<CurrencyRate>>((value) {
                            return DropdownMenuItem<CurrencyRate>(
                              value: value,
                              child: Text(
                                value.code,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'to',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 10),
                        DropdownButton<CurrencyRate>(
                          value: controller.targetCurrency,
                          onChanged: (value) {
                            controller.targetCurrency = value!;

                            controller.getCurrencies();
                          },
                          items: controller.currencies
                              .map<DropdownMenuItem<CurrencyRate>>((value) {
                            return DropdownMenuItem<CurrencyRate>(
                              value: value,
                              child: Text(
                                value.code,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'currency',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final selectedDate = await showDatePicker(
                              context: context,
                              initialDate: controller.startDate.value,
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now(),
                            );
                            if (selectedDate != null) {
                              controller.startDate.value = selectedDate;

                              controller.getCurrencies();
                            }
                          },
                          child: Row(
                            children: [
                              Icon(Icons.calendar_today),
                              SizedBox(width: 10),
                              Text(
                                controller.startDate
                                    .toString()
                                    .substring(0, 10),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            final selectedDate = await showDatePicker(
                              context: context,
                              initialDate: controller.endDate.value,
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now(),
                            );
                            if (selectedDate != null) {
                              controller.endDate.value = selectedDate;

                              controller.getCurrencies();
                            }
                          },
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_today),
                              const SizedBox(width: 10),
                              Text(
                                controller.endDate.toString().substring(0, 10),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Expanded(
                      child: controller.loading.value
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Container()
                      // : ListView.builder(
                      //     itemCount: controller.data.length,
                      //     itemBuilder: (context, index) {
                      //       final date = controller.data[index].key;
                      //       final rate = controller
                      //           .data[index].value[controller.targetCurrency];
                      //       final maxRate =
                      //           rate != null ? rate['max'] as double : 0.0;
                      //       return Container(
                      //         margin: const EdgeInsets.symmetric(
                      //             vertical: 10, horizontal: 20),
                      //         padding: const EdgeInsets.symmetric(
                      //             vertical: 10, horizontal: 20),
                      //         decoration: BoxDecoration(
                      //           color: Colors.white,
                      //           borderRadius: BorderRadius.circular(20),
                      //           boxShadow: [
                      //             BoxShadow(
                      //               color: Colors.grey.withOpacity(0.5),
                      //               spreadRadius: 1,
                      //               blurRadius: 5,
                      //               offset: const Offset(0, 3),
                      //             ),
                      //           ],
                      //         ),
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             Text(
                      //               date,
                      //               style: const TextStyle(
                      //                 fontSize: 18,
                      //                 fontWeight: FontWeight.bold,
                      //                 color: Colors.black,
                      //               ),
                      //             ),
                      //             Text(
                      //               maxRate.toStringAsFixed(2),
                      //               style: const TextStyle(
                      //                 fontSize: 18,
                      //                 fontWeight: FontWeight.bold,
                      //                 color: Colors.black,
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       );
                      //     },
                      //   ),
                      ),
                ],
              ),
      )),
    );
  }
}
