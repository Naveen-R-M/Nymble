// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nymble/Screens/Home/game_logic.dart';

void main() {
  Widget createAppForTesting({Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('Sample Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(createAppForTesting(child: GamePage()));
    expect(find.byKey(Key('helpButton')), findsOneWidget);
    expect(find.byKey(Key('spotifyButton')), findsOneWidget);
    expect(find.byKey(Key('Row')), findsOneWidget);
  });
}
