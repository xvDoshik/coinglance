import 'package:coinglance/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('app loads rates shell', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: CoinGlanceApp()),
    );
    expect(find.text('CoinGlance'), findsOneWidget);
  });
}
