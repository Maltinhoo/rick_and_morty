import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty/app_imports.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget rootWidget(Widget body) {
    return MainPageInit(
      child: MaterialApp(
        home: Scaffold(
          body: Padding(padding: const EdgeInsets.all(16.0), child: body),
        ),
      ),
    );
  }

  testWidgets('TextField 1 - Default', (WidgetTester tester) async {
    final Key key = UniqueKey();
    await tester.pumpWidget(
      rootWidget(CustomTextField(key: key, hint: 'Digite algo...')),
    );

    await tester.pumpAndSettle();

    await expectLater(
      find.byKey(key),
      matchesGoldenFile('../../../goldens/text_field/default.png'),
    );
  });

  testWidgets('TextField 2 - Com Validação', (WidgetTester tester) async {
    final Key key = UniqueKey();
    await tester.pumpWidget(
      rootWidget(
        CustomTextField(
          key: key,
          hint: 'Digite um email',
          validator: (value) {
            if (value == null || value.isEmpty || !value.contains('@')) {
              return 'E-mail inválido';
            }
            return null;
          },
        ),
      ),
    );

    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(key), 'teste');
    await tester.pumpAndSettle();

    await expectLater(
      find.byKey(key),
      matchesGoldenFile('../../../goldens/text_field/validation.png'),
    );
  });

  testWidgets('TextField 3 - Apenas Números', (WidgetTester tester) async {
    final Key key = UniqueKey();
    await tester.pumpWidget(
      rootWidget(
        CustomTextField(
          key: key,
          hint: 'Digite um número',
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
      ),
    );

    await tester.pumpAndSettle();

    await expectLater(
      find.byKey(key),
      matchesGoldenFile('../../../goldens/text_field/numeric.png'),
    );
  });
}
