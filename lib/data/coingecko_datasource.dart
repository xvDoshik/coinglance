import 'package:dio/dio.dart';

class CoingeckoDatasource {
  CoingeckoDatasource(this._dio);

  final Dio _dio;

  Future<Map<String, dynamic>> fetchSimplePrice({
    required List<String> coinIds,
    required String quote,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/simple/price',
      queryParameters: {
        'ids': coinIds.join(','),
        'vs_currencies': quote,
        'include_24hr_change': 'true',
      },
    );
    final data = response.data;
    if (data == null) {
      throw DioException(
        requestOptions: response.requestOptions,
        message: 'Empty response',
      );
    }
    return data;
  }
}

Map<String, ({double price, double? change24h})> parseSimplePriceResponse(
  Map<String, dynamic> json,
  String quote,
) {
  final changeKey = '${quote}_24h_change';
  final priceKey = quote;
  final out = <String, ({double price, double? change24h})>{};

  for (final entry in json.entries) {
    final coinId = entry.key;
    final value = entry.value;
    if (value is! Map) continue;
    final map = Map<String, dynamic>.from(value);
    final priceRaw = map[priceKey];
    if (priceRaw is! num) continue;
    final changeRaw = map[changeKey];
    final change = changeRaw is num ? changeRaw.toDouble() : null;
    out[coinId] = (price: priceRaw.toDouble(), change24h: change);
  }
  return out;
}
