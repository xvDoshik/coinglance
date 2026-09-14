import 'package:coinglance/domain/coin_rate.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CoinCard extends StatelessWidget {
  const CoinCard({super.key, required this.rate});

  final CoinRate rate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasPrice = rate.fetchedAt.millisecondsSinceEpoch > 0;
    final quote = rate.quote.toUpperCase();
    final priceText = hasPrice
        ? NumberFormat.currency(name: quote, symbol: _symbol(quote)).format(rate.price)
        : '—';
    final change = rate.change24h;
    final changeColor = change == null
        ? theme.colorScheme.onSurfaceVariant
        : change >= 0
            ? const Color(0xFF34D399)
            : const Color(0xFFF87171);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                rate.symbol,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  letterSpacing: 1.2,
                ),
              ),
              const Spacer(),
              if (rate.isStale && hasPrice)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    'Stale',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSecondaryContainer,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            rate.displayName,
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          Text(
            priceText,
            style: theme.textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w700,
              height: 1.05,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              if (change != null)
                Text(
                  '${change >= 0 ? '+' : ''}${change.toStringAsFixed(2)}% 24h',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: changeColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              const Spacer(),
              if (hasPrice)
                Text(
                  'Updated ${_relative(rate.fetchedAt)}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  String _symbol(String quote) {
    switch (quote) {
      case 'USD':
        return r'$';
      case 'EUR':
        return '€';
      default:
        return quote;
    }
  }

  String _relative(DateTime time) {
    final diff = DateTime.now().difference(time);
    if (diff.inMinutes < 1) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}
