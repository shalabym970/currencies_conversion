import 'package:flutter/material.dart';

import '../color_manager.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: ColorManager.main));
  }
}
