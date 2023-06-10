import 'package:currency_converter/app/models/currency.dart';
import 'package:currency_converter/app/models/rate.dart';
import 'package:currency_converter/app/providers/api_provider.dart';
import 'package:currency_converter/app/repositories/currency_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAPIProvider extends Mock implements APIProvider {}

void main() {
  late CurrencyRepo currencyRepo;
  late MockAPIProvider mockApiProvider;

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

    // Define the behavior of the mock APIProvider instance using `when` and `thenAnswer`
    when(mockApiProvider.getCurrencies())
        .thenAnswer((_) => Future.value(expectedCurrencies));

    // Call the method under test
    final currencies = await currencyRepo.getCurrencies();

    // Assert that the actual result is equal to the expected result
    expect(currencies, expectedCurrencies);
  });

////////////////////////


  test('getCurrenciesConversion returns a list of rates', () async {
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
      // more rates...
    ];

    // Define the behavior of the mock APIProvider instance using `when` and `thenAnswer`
    when(mockApiProvider.getCurrenciesConversion(
        startDate: startDate, endDate: endDate, symbols: symbols))
        .thenAnswer((_) => Future.value(expectedRates));

    // Call the method under test
    final rates = await currencyRepo.getCurrenciesConversion(
        startDate: startDate, endDate: endDate, symbols: symbols);

    // Assert
    expect(rates, expectedRates);
  });
}