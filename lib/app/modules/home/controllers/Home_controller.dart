import 'package:get/get.dart';
import 'package:getx_mvc_templet/app/repositories/currency_repo.dart';
import '../../../../common/strings.dart';
import '../../../../common/widgets/ui.dart';
import '../../../models/currencies_conversion.dart';
import '../../../models/currency.dart';

class HomeController extends GetxController {
  late CurrencyRate baseCurrency;
  late CurrencyRate targetCurrency;
  final startDate = DateTime.now().subtract(const Duration(days: 30)).obs;
  final endDate = DateTime.now().obs;
  final currencies = <CurrencyRate>[].obs;
  final currenciesConversion = <CurrenciesConversion>[].obs;
  final loading = false.obs;

  final currencyRepo = CurrencyRepo();

  Future getCurrencies() async {
    try {
      loading.value = true;
      currencies.assignAll(await currencyRepo.getCurrencies());
      baseCurrency = currencies[1];
      targetCurrency = currencies[1];
    } catch (e) {
      Get.showSnackbar(Ui.errorSnackBar(message: Strings.somethingWentWrong));
      Get.log('========== Error : ${e.toString()} ==========');
    } finally {
      loading.value = false;
    }
  }

  Future getCurrenciesConversion() async {
    try {
      loading.value = true;
      currenciesConversion.assignAll(await currencyRepo.getCurrenciesConversion(
          startDate: startDate.value,
          endDate: endDate.value,
          fromCurrency: baseCurrency.code,
          toCurrency: targetCurrency.code));

    } catch (e) {
      Get.showSnackbar(Ui.errorSnackBar(message: Strings.somethingWentWrong));
      Get.log('========== Error : ${e.toString()} ==========');
    } finally {
      loading.value = false;
    }
  }

  @override
  void onInit() {
    getCurrencies();
    getCurrenciesConversion();
    super.onInit();
  }
}
