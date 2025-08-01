import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty/app_imports.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget rootWidget(Widget body) {
    return MainPageInit(
      child: MaterialApp(
        home: Scaffold(body: Center(child: body)),
      ),
    );
  }

  testWidgets('Text 1 - Default CustomText', (WidgetTester tester) async {
    final Key key = UniqueKey();
    await tester.pumpWidget(
      rootWidget(
        CustomText(
          'Texto Padrão',
          color: AppColors.label,
          fontWeight: FontWeight.bold,
          key: key,
        ),
      ),
    );

    await tester.pumpAndSettle();

    await expectLater(
      find.byKey(key),
      matchesGoldenFile('../../../goldens/text/text_default.png'),
    );
  });

  testWidgets('Text 2 - Custom Font Size and Color', (
    WidgetTester tester,
  ) async {
    final Key key = UniqueKey();
    await tester.pumpWidget(
      rootWidget(
        CustomText(
          'Texto Personalizado',
          key: key,
          size: 24,
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    await tester.pumpAndSettle();

    await expectLater(
      find.byKey(key),
      matchesGoldenFile('../../../goldens/text/text_custom.png'),
    );
  });

  testWidgets('Text 3 - Gradient Text', (WidgetTester tester) async {
    final Key key = UniqueKey();
    await tester.pumpWidget(
      rootWidget(
        CustomText(
          'Texto com Gradiente',
          key: key,
          gradient: const LinearGradient(colors: [Colors.blue, Colors.red]),
          size: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    await tester.pumpAndSettle();

    await expectLater(
      find.byKey(key),
      matchesGoldenFile('../../../goldens/text/text_gradient.png'),
    );
  });

  testWidgets('Text 4 - No autosized Text', (WidgetTester tester) async {
    final Key key = UniqueKey();
    await tester.pumpWidget(
      rootWidget(
        CustomText(
          'Texto AutoSize',
          key: key,
          autosize: true,
          minSize: 10,
          size: 30,
        ),
      ),
    );

    await tester.pumpAndSettle();

    await expectLater(
      find.byKey(key),
      matchesGoldenFile('../../../goldens/text/text_no_autosize.png'),
    );
  });
}
