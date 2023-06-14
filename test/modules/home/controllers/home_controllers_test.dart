import 'package:currency_converter/app/models/currency.dart';
import 'package:currency_converter/app/models/rate.dart';
import 'package:currency_converter/app/modules/home/controllers/Home_controller.dart';
import 'package:currency_converter/app/providers/api_provider.dart';
import 'package:currency_converter/app/repositories/currency_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../providers/currency_repo_test.dart';

class MockCurrencyRepo extends Mock implements CurrencyRepo {
  @override
  Future<List<Currency>> getCurrencies() =>
      (super.noSuchMethod(Invocation.method(#getPosts, []),
              returnValue: Future<List<Currency>>.value(<Currency>[]))
          as Future<List<Currency>>);

  @override
  Future<List<Rate>> getCurrenciesConversion(
          {required String startDate,
          required String endDate,
          required List<String> symbols}) =>
      (super.noSuchMethod(Invocation.method(#getPosts, []),
              returnValue: Future<List<Rate>>.value(<Rate>[]))
          as Future<List<Rate>>);
}

void main() {
  late HomeController homeController;
  late APIProvider mockApiProvider;
  late CurrencyRepo mockCurrencyRepo;

  setUp(() {
    mockApiProvider = MockAPIProvider();
    mockCurrencyRepo = MockCurrencyRepo();
    homeController = HomeController();
    homeController.apiProvider = mockApiProvider;
    homeController.currencyRepo = mockCurrencyRepo;
  });

  test('getCurrencies loads currencies successfully', () async {
    // arrange
    final expectedCurrencies = [
      Currency(code: 'USD', description: 'United States Dollar'),
      Currency(code: 'EUR', description: 'Euro'),
      Currency(code: 'JPY', description: 'Japanese Yen'),
    ];
    when(mockCurrencyRepo.getCurrencies())
        .thenAnswer((_) => Future.value(expectedCurrencies));

    // act
    await homeController.getCurrencies();

    // assert
    expect(homeController.currencies, expectedCurrencies);
    expect(homeController.baseCurrency.value, expectedCurrencies[1]);
    expect(homeController.targetCurrency.value, expectedCurrencies[1]);
    expect(homeController.loading.value, false);
  });

  test('getCurrenciesConversion loads rates successfully', () async {
    // arrange
    homeController.baseCurrency.value = Currency(code: 'EUR');
    homeController.targetCurrency.value = Currency(code: 'USD');
    homeController.startDate.value = DateTime.parse('2022-01-01');
    homeController.endDate.value = DateTime.parse('2022-01-10');
    final expectedRates = [
      Rate(
        currencyCode: 'USD',
        exchangeRate: 1.0,
        date: DateTime.parse('2022-01-01'),
      ),
      Rate(
        currencyCode: 'EUR',
        exchangeRate: 0.85,
        date: DateTime.parse('2022-01-01'),
      ),
      Rate(
        currencyCode: 'USD',
        exchangeRate: 1.0,
        date: DateTime.parse('2022-01-02'),
      ),
      Rate(
        currencyCode: 'EUR',
        exchangeRate: 0.86,
        date: DateTime.parse('2022-01-02'),
      ),
      Rate(
        currencyCode: 'USD',
        exchangeRate: 1.0,
        date: DateTime.parse('2022-01-03'),
      ),
      Rate(
        currencyCode: 'EUR',
        exchangeRate: 0.87,
        date: DateTime.parse('2022-01-03'),
      ),
    ];
    List<String> symbols = ['USD', 'EUR'];
    when(mockCurrencyRepo.getCurrenciesConversion(
            startDate: homeController.startDate.value.toString(),
            endDate: homeController.endDate.value.toString(),
            symbols: symbols))
        .thenAnswer((_) => Future.value(expectedRates));

    // act
    await homeController.getCurrenciesConversion();

    // assert
    expect(homeController.conversions, expectedRates);
    expect(homeController.loadingRates.value, false);
  });
}
