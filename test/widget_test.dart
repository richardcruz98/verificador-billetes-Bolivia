import 'package:flutter_test/flutter_test.dart';

import 'package:verificador_billetes/main.dart';

void main() {
  testWidgets('Verificador carga correctamente', (WidgetTester tester) async {

    await tester.pumpWidget(MyApp());

    expect(find.text('Verificador de Billetes'), findsOneWidget);

    expect(find.text('Verificar'), findsOneWidget);
  });
}