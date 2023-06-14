import 'package:currency_converter/app/providers/api_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../common/strings.dart';
import '../../../../common/widgets/ui.dart';
import '../../../models/currency.dart';
import '../../../models/rate.dart';
import '../../../repositories/currency_repo.dart';

class HomeController extends GetxController {
  final baseCurrency = Currency().obs;
  final targetCurrency = Currency().obs;
  final startDate = DateTime.now().subtract(const Duration(days: 30)).obs;
  final endDate = DateTime.now().obs;
  final currencies = <Currency>[].obs;
  final conversions = <Rate>[].obs;
  final rates = <List<Rate>>[].obs;
  final loading = false.obs;
  final loadingRates = false.obs;
  final loadingMoreRates = false.obs;
  final hasMore = true.obs;
  var scrollController = ScrollController();
  APIProvider apiProvider = APIProvider();
  late CurrencyRepo currencyRepo = CurrencyRepo(apiProvider: apiProvider);
  final curenncyIsEqual = false.obs;

  @override
  void onInit() {
    currencyRepo = CurrencyRepo(apiProvider: apiProvider);
    //   scrollController..addListener(() { });
    getCurrencies();
    super.onInit();
  }

  Future getCurrencies() async {
    try {
      loading.value = true;
      currencies.assignAll(await currencyRepo.getCurrencies());
      baseCurrency.value = currencies[1];
      targetCurrency.value = currencies[1];
    } catch (e) {
      Get.showSnackbar(Ui.errorSnackBar(message: Strings.somethingWentWrong));
      Get.log('========== Error : ${e.toString()} ==========');
    } finally {
      loading.value = false;
    }
  }

  Future getCurrenciesConversion() async {
    try {
      loadingRates.value = true;
      curenncyIsEqual.value = false;
      rates.clear();
      conversions.clear();
      List<String> symbols = [
        targetCurrency.value.code!.toString(),
        baseCurrency.value.code!.toString()
      ];
      if (symbols[0] == symbols[1]) {
        curenncyIsEqual.value = true;
      }
      conversions.assignAll(await currencyRepo.getCurrenciesConversion(
          startDate: startDate.value.toString(),
          endDate: endDate.value.toString(),
          symbols: symbols));
      if (curenncyIsEqual.isFalse) {
        for (var i = 0; i < conversions.length; i += 2) {
          List<Rate> rate = [conversions[i], conversions[i + 1]];
          rates.add(rate);
        }
      } else {
        for (var i = 0; i < conversions.length; i++) {
          List<Rate> rate = [conversions[i]];
          rates.add(rate);
        }
      }
    } catch (e) {
      Get.showSnackbar(Ui.errorSnackBar(message: Strings.somethingWentWrong));
      Get.log('========== Error : ${e.toString()} ==========');
    } finally {
      loadingRates.value = false;
    }
  }

  Future<void> refreshRates() async {
    await getCurrenciesConversion();
  }
}
