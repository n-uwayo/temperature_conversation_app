import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing/main.dart';

void main() {
  testWidgets('Initial state has 0 as converted value', (WidgetTester tester) async {
    await tester.pumpWidget(TemperatureConversionApp());

    expect(find.byKey(Key('convertedValue')), findsOneWidget);
    expect(find.text('0'), findsOneWidget);
  });

  testWidgets('Convert 32 F to C', (WidgetTester tester) async {
    await tester.pumpWidget(TemperatureConversionApp());

    // Select F to C conversion
    await tester.tap(find.text('Fahrenheit to Celsius'));
    await tester.pump();

    // Enter 32 in the text field
    await tester.enterText(find.byType(TextField), '32');
    await tester.tap(find.text('Convert'));
    await tester.pump();

    // Check the converted value
    expect(find.text('0.00'), findsOneWidget);
  });

  testWidgets('Convert 0 C to F', (WidgetTester tester) async {
    await tester.pumpWidget(TemperatureConversionApp());

    // Select C to F conversion
    await tester.tap(find.text('Celsius to Fahrenheit'));
    await tester.pump();

    // Enter 0 in the text field
    await tester.enterText(find.byType(TextField), '0');
    await tester.tap(find.text('Convert'));
    await tester.pump();

    // Check the converted value
    expect(find.text('32.00'), findsOneWidget);
  });
}
