import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('Scavenger Hunt app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(const ScavengerHuntApp());

    // Verify that the welcome screen appears
    expect(find.text('LSU'), findsOneWidget);
    expect(find.text('Patrick F. Taylor Hall'), findsOneWidget);
    expect(find.text('Scavenger Hunt'), findsOneWidget);
    
    // Verify that the Begin Adventure button exists
    expect(find.text('Begin Adventure'), findsOneWidget);
  });
}