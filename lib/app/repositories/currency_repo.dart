
import '../models/currency.dart';
import '../models/rate.dart';
import '../providers/api_provider.dart';

class CurrencyRepo {
  final APIProvider apiProvider ;
  CurrencyRepo({required this.apiProvider});


  Future<List<Currency>> getCurrencies() {
    return apiProvider.getCurrencies();
  }

  Future<List<Rate>> getCurrenciesConversion(
      {required String startDate,
      required String endDate,
      required List<String> symbols}) async {
    return apiProvider.getCurrenciesConversion(
        startDate: startDate, endDate: endDate, symbols: symbols);
  }
}
