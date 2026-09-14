import 'package:coinglance/features/rates/coin_card.dart';
import 'package:coinglance/features/rates/rates_providers.dart';
import 'package:coinglance/features/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RatesScreen extends ConsumerWidget {
  const RatesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rates = ref.watch(ratesControllerProvider);
    final quote = ref.watch(quoteCurrencyProvider);

    ref.listen(quoteCurrencyProvider, (prev, next) {
      if (prev != next) {
        ref.invalidate(ratesControllerProvider);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('CoinGlance'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(builder: (_) => const SettingsScreen()),
              );
            },
            child: Text(quote.toUpperCase()),
          ),
        ],
      ),
      body: rates.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => _ErrorState(
          message: e.toString(),
          onRetry: () => ref.read(ratesControllerProvider.notifier).refresh(),
        ),
        data: (items) => RefreshIndicator(
          onRefresh: () => ref.read(ratesControllerProvider.notifier).refresh(),
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (_, i) => CoinCard(rate: items[i]),
          ),
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Could not load rates',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 20),
            FilledButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}
