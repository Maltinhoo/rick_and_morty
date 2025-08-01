import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty/app_imports.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget rootWidget(Widget body) {
    return MainPageInit(
      child: MaterialApp(home: Scaffold(body: body)),
    );
  }

  testWidgets('Vector 1 - Vector with Svg', (WidgetTester tester) async {
    final Key key = UniqueKey();
    await tester.pumpWidget(
      rootWidget(
        Vector(
          key: key,
          Vectors.filter,
          color: AppColors.primaryDark,
          size: 200,
        ),
      ),
    );

    await tester.pumpAndSettle();

    await expectLater(
      find.byKey(key),
      matchesGoldenFile('../../../goldens/vector/vector_with_svg.png'),
    );
  });

  testWidgets('Vector 2 - Vector with IconData', (WidgetTester tester) async {
    final Key key = UniqueKey();
    await tester.pumpWidget(
      rootWidget(
        Vector(key: key, Icons.home, color: AppColors.primaryDark, size: 200),
      ),
    );

    await tester.pumpAndSettle();

    await expectLater(
      find.byKey(key),
      matchesGoldenFile('../../../goldens/vector/vector_with_icon_data.png'),
    );
  });
}
