import 'package:coinglance/data/coingecko_datasource.dart';
import 'package:coinglance/data/database.dart';
import 'package:coinglance/domain/coin_rate.dart';
import 'package:dio/dio.dart';

class RatesRepository {
  RatesRepository(this._db, this._api);

  final AppDatabase _db;
  final CoingeckoDatasource _api;

  Future<List<CoinRate>> loadCached(String quote) async {
    final rows = await _db.ratesForQuote(quote);
    final byId = {for (final r in rows) r.coinId: r};
    return trackedCoins.map((c) {
      final row = byId[c.id];
      if (row == null) {
        return CoinRate(
          coinId: c.id,
          displayName: c.name,
          symbol: c.symbol,
          quote: quote,
          price: 0,
          change24h: null,
          fetchedAt: DateTime.fromMillisecondsSinceEpoch(0),
        );
      }
      return CoinRate(
        coinId: c.id,
        displayName: c.name,
        symbol: c.symbol,
        quote: quote,
        price: row.price,
        change24h: row.change24h,
        fetchedAt: row.fetchedAt,
      );
    }).toList();
  }

  Future<List<CoinRate>> refresh(String quote) async {
    try {
      final json = await _api.fetchSimplePrice(
        coinIds: trackedCoins.map((c) => c.id).toList(),
        quote: quote,
      );
      final parsed = parseSimplePriceResponse(json, quote);
      final now = DateTime.now();
      for (final coin in trackedCoins) {
        final p = parsed[coin.id];
        if (p == null) continue;
        await _db.upsertRate(
          coinId: coin.id,
          quote: quote,
          price: p.price,
          change24h: p.change24h,
          fetchedAt: now,
        );
      }
      return await loadCached(quote);
    } on DioException {
      final cached = await loadCached(quote);
      if (cached.any((r) => r.fetchedAt.millisecondsSinceEpoch > 0)) {
        return cached;
      }
      rethrow;
    }
  }

  Future<List<CoinRate>> loadOrRefresh(String quote) async {
    final cached = await loadCached(quote);
    final hasData = cached.any((r) => r.fetchedAt.millisecondsSinceEpoch > 0);
    final stale = hasData && cached.any((r) => r.isStale);
    if (!hasData || stale) {
      try {
        return await refresh(quote);
      } on DioException {
        if (hasData) return cached;
        rethrow;
      }
    }
    return cached;
  }
}
