import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty/app_imports.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget rootWidget(Widget body) {
    return MainPageInit(
      child: MaterialApp(home: Scaffold(body: body)),
    );
  }

  testWidgets('Button 1 - CustomButton enabled with vector and label', (
    WidgetTester tester,
  ) async {
    final Key buttonKey = UniqueKey();
    await tester.pumpWidget(
      rootWidget(
        CustomButton(
          key: buttonKey,
          onTap: () {
            debugPrint('Botão pressionado!');
          },
          label: "CONTINUAR",
          icon: const Icon(Icons.flag, color: Colors.white, size: 30),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await expectLater(
      find.byKey(buttonKey),
      matchesGoldenFile(
        '../../../goldens/button/button_enable_with_vector_and_label.png',
      ),
    );
  });

  testWidgets('Button 2 - CustomButton disabled with vector and label', (
    WidgetTester tester,
  ) async {
    final Key buttonKey = UniqueKey();
    await tester.pumpWidget(
      rootWidget(
        CustomButton(
          key: buttonKey,
          onTap: () {
            debugPrint('Botão pressionado!');
          },
          label: "CONTINUAR",
          icon: const Icon(Icons.flag, color: Colors.white, size: 30),
          enabled: false,
        ),
      ),
    );

    await tester.pumpAndSettle();

    await expectLater(
      find.byKey(buttonKey),
      matchesGoldenFile(
        '../../../goldens/button/button_disabled_with_vector_and_label.png',
      ),
    );
  });

  testWidgets('Button 3 - CustomButton enabled with label', (
    WidgetTester tester,
  ) async {
    final Key buttonKey = UniqueKey();
    await tester.pumpWidget(
      rootWidget(
        CustomButton(
          key: buttonKey,
          onTap: () {
            debugPrint('Botão pressionado!');
          },
          label: "CONTINUAR",
        ),
      ),
    );

    await tester.pumpAndSettle();

    await expectLater(
      find.byKey(buttonKey),
      matchesGoldenFile(
        '../../../goldens/button/button_enabled_with_label.png',
      ),
    );
  });

  testWidgets('Button 4 - CustomButton outlined with label', (
    WidgetTester tester,
  ) async {
    final Key buttonKey = UniqueKey();
    await tester.pumpWidget(
      rootWidget(
        CustomButton(
          key: buttonKey,
          label: "CONTORNADO",
          outlined: true,
          borderColor: AppColors.gray,
        ),
      ),
    );

    await tester.pumpAndSettle();

    await expectLater(
      find.byKey(buttonKey),
      matchesGoldenFile(
        '../../../goldens/button/button_outlined_with_label.png',
      ),
    );
  });
}
