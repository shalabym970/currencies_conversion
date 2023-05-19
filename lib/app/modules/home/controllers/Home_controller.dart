import 'package:get/get.dart';
import 'package:getx_mvc_templet/app/repositories/currency_repo.dart';

import '../../../../common/strings.dart';
import '../../../../common/widgets/ui.dart';
import '../../../models/currency.dart';
import '../../../models/rate.dart';

class HomeController extends GetxController {
  final baseCurrency = Currency().obs;
  final targetCurrency = Currency().obs;

  final startDate = DateTime.now().subtract(const Duration(days: 30)).obs;
  final endDate = DateTime.now().obs;
  final currencies = <Currency>[].obs;
  final rates = <Rate>[].obs;
  final loading = false.obs;
  final loadingRates = false.obs;

  final currencyRepo = CurrencyRepo();

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
      List<String> symbols = [
       
        targetCurrency.value.code!.toString(),
        baseCurrency.value.code!.toString()
      ];
      rates.assignAll(await currencyRepo.getCurrenciesConversion(
          startDate: startDate.value.toString(),
          endDate: endDate.value.toString(),
          symbols: symbols));
    } catch (e) {
      Get.showSnackbar(Ui.errorSnackBar(message: Strings.somethingWentWrong));
      Get.log('========== Error : ${e.toString()} ==========');
    } finally {
      loadingRates.value = false;
    }
  }

  @override
  void onInit() {
    getCurrencies();
    super.onInit();
  }
}
