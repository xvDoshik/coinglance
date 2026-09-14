import 'package:coinglance/data/coingecko_datasource.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('parseSimplePriceResponse reads usd fields', () {
    final parsed = parseSimplePriceResponse(
      {
        'bitcoin': {'usd': 65000.5, 'usd_24h_change': 1.25},
        'toncoin': {'usd': 5.2, 'usd_24h_change': -0.4},
      },
      'usd',
    );
    expect(parsed['bitcoin']!.price, 65000.5);
    expect(parsed['bitcoin']!.change24h, 1.25);
    expect(parsed['toncoin']!.price, 5.2);
    expect(parsed['toncoin']!.change24h, -0.4);
  });

  test('parseSimplePriceResponse reads eur fields', () {
    final parsed = parseSimplePriceResponse(
      {
        'bitcoin': {'eur': 60000, 'eur_24h_change': 0.5},
      },
      'eur',
    );
    expect(parsed['bitcoin']!.price, 60000);
    expect(parsed['bitcoin']!.change24h, 0.5);
  });
}
