import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:login_screen/main.dart';

void main() {
  testWidgets('App inicia na tela de login', (tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.widgetWithText(ElevatedButton, 'Entrar'), findsOneWidget);

  });
}
