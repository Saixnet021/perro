// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:probando/main.dart';

void main() {
  testWidgets('Prime Dox app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const PrimeDoxApp());

    // Verify that our app loads with the correct title.
    expect(find.text('PRIME DOX'), findsOneWidget);
    expect(find.text('Servicios Profesionales de Información'), findsOneWidget);
    expect(find.text('SERVICIOS DISPONIBLES'), findsOneWidget);
    expect(find.text('CONTACTOS'), findsOneWidget);

    // Verify that some service items are present.
    expect(find.text('RENIEC'), findsOneWidget);
    expect(find.text('TELEFONIA'), findsOneWidget);
    expect(find.text('DELITOS'), findsOneWidget);

    // Verify that contact names are present.
    expect(find.text('PEDRO DOXING'), findsOneWidget);
    expect(find.text('JOSE'), findsOneWidget);
    expect(find.text('ANÓNIMO DOX'), findsOneWidget);
  });
}
