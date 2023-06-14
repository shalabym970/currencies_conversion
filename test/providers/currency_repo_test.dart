import 'package:currency_converter/app/models/currency.dart';
import 'package:currency_converter/app/models/rate.dart';
import 'package:currency_converter/app/providers/api_provider.dart';
import 'package:currency_converter/app/repositories/currency_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAPIProvider extends Mock implements APIProvider {
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
  late CurrencyRepo currencyRepo;
  late APIProvider mockApiProvider;

  setUp(() {
    mockApiProvider = MockAPIProvider();
    currencyRepo = CurrencyRepo(apiProvider: mockApiProvider);
  });

  test('getCurrencies returns a list of currencies', () async {
    // arrange
    final expectedCurrencies = [
      Currency(code: 'USD', description: 'United States Dollar'),
      Currency(code: 'EUR', description: 'Euro'),
      Currency(code: 'JPY', description: 'Japanese Yen'),
    ];

    //act
    when(mockApiProvider.getCurrencies())
        .thenAnswer((_) => Future.value(expectedCurrencies));
    final currencies = await currencyRepo.getCurrencies();

    // Assert
    expect(currencies, expectedCurrencies,
        reason: 'getCurrencies returned null or an unexpected value');
  });

  test('getCurrenciesConversion returns a list of rates', () async {
    // arrange
    const startDate = '2023-01-01';
    const endDate = '2023-01-10';
    final symbols = ['USD', 'EUR'];

    final expectedRates = [
      Rate(
        currencyCode: 'USD',
        exchangeRate: 1.0,
        date: DateTime.parse('2023-01-01'),
      ),
      Rate(
        currencyCode: 'EUR',
        exchangeRate: 0.85,
        date: DateTime.parse('2023-01-01'),
      ),
      Rate(
        currencyCode: 'USD',
        exchangeRate: 1.0,
        date: DateTime.parse('2023-01-02'),
      ),
      Rate(
        currencyCode: 'EUR',
        exchangeRate: 0.86,
        date: DateTime.parse('2023-01-02'),
      ),
      Rate(
        currencyCode: 'USD',
        exchangeRate: 1.0,
        date: DateTime.parse('2023-01-03'),
      ),
      Rate(
        currencyCode: 'EUR',
        exchangeRate: 0.87,
        date: DateTime.parse('2023-01-03'),
      ),
    ];

    //act
    when(mockApiProvider.getCurrenciesConversion(
            startDate: startDate, endDate: endDate, symbols: symbols))
        .thenAnswer((_) => Future.value(expectedRates));

    final rates = await currencyRepo.getCurrenciesConversion(
        startDate: startDate, endDate: endDate, symbols: symbols);

    // Assert
    expect(rates, expectedRates);
  });
}
