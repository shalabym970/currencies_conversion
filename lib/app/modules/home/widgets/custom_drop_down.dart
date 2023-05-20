import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../models/currency.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown(
      {Key? key,
      required this.value,
      required this.onChanged,
      required this.items})
      : super(key: key);
  final Currency value;
  final void Function(Currency?) onChanged;
  final List<DropdownMenuItem<Currency>> items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
      child: DropdownButton<Currency>(
          value: value, onChanged: onChanged, items: items),
    );
  }
}
