import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:motolanka/main.dart';

void main() {
  testWidgets('Explore button opens the Explore tab', (tester) async {
    await tester.pumpWidget(const MotoLankaApp());

    expect(find.text('MotoLanka'), findsOneWidget);

    final exploreButton = find.widgetWithText(FilledButton, 'Explore now');

    await tester.ensureVisible(exploreButton);
    await tester.tap(exploreButton);
    await tester.pumpAndSettle();

    expect(
      find.text('Bike and spare part listings will be added next.'),
      findsOneWidget,
    );
  });
}
