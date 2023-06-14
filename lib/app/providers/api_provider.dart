import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../common/constants.dart';
import '../../common/widgets/ui.dart';
import '../models/currency.dart';
import '../models/rate.dart';

class APIProvider {

  Future<List<Currency>> getCurrencies() async {
    String url = '${Constants.basicUrl}symbols?base=USD';
    Get.log('=============== currencies List url :  $url ==========');
    final response = await http.get(Uri.parse(url));
    var decodeResponse =
    await jsonDecode(response.body)['symbols'] as Map<String, dynamic>;
    Get.log('=============== currencies List :  $decodeResponse==========');
    if (response.statusCode == 200) {
      return decodeResponse.entries
          .map(
              (entry) => Currency.fromJson(entry.value as Map<String, dynamic>))
          .toList();
    } else {
      Get.showSnackbar(Ui.errorSnackBar(message: decodeResponse['message']));
      throw Exception(decodeResponse['message']);
    }
  }

  Future<List<Rate>> getCurrenciesConversion({required String startDate,
    required String endDate,
    required List<String> symbols}) async {
    String url = '${Constants.basicUrl}timeseries';
    String symbolsStr = symbols.join(',');

    String apiUrl =
        '$url?start_date=$startDate&end_date=$endDate&symbols=$symbolsStr';
    Get.log('=============== rates url :  $apiUrl ==========');
    http.Response response = await http.get(Uri.parse(apiUrl));
    Map<String, dynamic> decodeResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      ExchangeRateResponse exchangeRateResponse =
      ExchangeRateResponse.fromJson(decodeResponse);
      Get.log('=============== rates List :  $decodeResponse==========');

      List<Rate> ratesList = [];
      exchangeRateResponse.rates?.forEach((date, currencies) {
        currencies.forEach((currencyCode, exchangeRate) {
          Rate rate = Rate(
            currencyCode: currencyCode,
            exchangeRate: exchangeRate.toDouble(),
            date: DateTime.parse(date),
          );
          ratesList.add(rate);
        });
      });
      return ratesList;
    } else {
      Get.showSnackbar(Ui.errorSnackBar(message: decodeResponse['message']));
      throw Exception(decodeResponse['message']);
    }
  }
}
