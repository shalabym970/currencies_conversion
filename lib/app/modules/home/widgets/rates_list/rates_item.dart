import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;
import '../../../../../common/color_manager.dart';
import '../../../../models/rate.dart';

class RateItem extends StatelessWidget {
  const RateItem({Key? key, required List<Rate> rates})
      : _rates = rates,
        super(key: key);

  final List<Rate> _rates;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorManager.main,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "${_rates[0].currencyCode} : ",
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: ColorManager.white),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            _rates[0].exchangeRate.toString(),
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: ColorManager.white),
                            maxLines: 2,
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h,),
                      Row(
                        children: [
                          Text(
                            "${_rates[1].currencyCode} : ",
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: ColorManager.white),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            _rates[1].exchangeRate.toString(),
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: ColorManager.white),
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    intl.DateFormat('d MMM y')
                        .format(_rates[1].date ?? DateTime.now())
                        .toString(),
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: ColorManager.white),
                    maxLines: 2,
                  ),

                ])),
      ),
    );
  }
}
