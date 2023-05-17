import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../common/constants.dart';
import '../../common/widgets/ui.dart';
import '../models/currencies_conversion.dart';
import '../models/currency.dart';

class APIProvider {
  Future<List<CurrencyRate>> getCurrencies() async {
    String url = '${Constants.basicUrl}latest';
    final response = await http.get(Uri.parse(url));
    var decodeResponse =
        await jsonDecode(response.body) as Map<String, dynamic>;
    Get.log('=============== currencies List :  $decodeResponse==========');
    if (response.statusCode == 200) {
      return decodeResponse['symbols']
          .map<CurrencyRate>((obj) => CurrencyRate.fromJson(obj))
          .toList();
    } else {
      Get.showSnackbar(Ui.errorSnackBar(message: decodeResponse['message']));
      throw Exception(decodeResponse['message']);
    }
  }

  Future<List<CurrenciesConversion>> getCurrenciesConversion(
      {required DateTime startDate,
      required DateTime endDate,
      required String fromCurrency,
      required String toCurrency}) async {
    String url =
        '${Constants.basicUrl}timeseries?start_date=${startDate.toString()}&end_date=${endDate.toString()}&symbols=$fromCurrency,$toCurrency';
    final response = await http.get(Uri.parse(url));
    var decodeResponse =
        await jsonDecode(response.body) as Map<String, dynamic>;
    Get.log('=============== Currencies Conversion List :  $decodeResponse==========');
    if (response.statusCode == 200) {
      return decodeResponse['rates']
          .map<CurrenciesConversion>((obj) => CurrenciesConversion.fromJson(obj))
          .toList();
    } else {
      Get.showSnackbar(Ui.errorSnackBar(message: decodeResponse['message']));
      throw Exception(decodeResponse['message']);
    }
  }
}
