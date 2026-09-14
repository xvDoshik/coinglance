import 'package:coinglance/features/rates/rates_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quote = ref.watch(quoteCurrencyProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Quote currency',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'CoinGecko vs_currencies',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 20),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'usd', label: Text('USD')),
              ButtonSegment(value: 'eur', label: Text('EUR')),
            ],
            selected: {quote},
            onSelectionChanged: (values) {
              final next = values.first;
              ref.read(quoteCurrencyProvider.notifier).setQuote(next);
            },
          ),
        ],
      ),
    );
  }
}
