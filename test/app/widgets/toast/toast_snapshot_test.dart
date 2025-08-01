import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty/app_imports.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  Widget rootWidget(Widget body) {
    return MainPageInit(
      child: MaterialApp(home: Scaffold(body: body)),
    );
  }

  testWidgets('Toast 1 - Success Toast', (WidgetTester tester) async {
    final Key toastKey = UniqueKey();

    await tester.pumpWidget(
      rootWidget(
        CustomToast(
          key: toastKey,
          backgroundColor: AppColors.success,
          icon: Icons.check_circle,
          message: 'Success message',
          textColor: Colors.white,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await expectLater(
      find.byKey(toastKey),
      matchesGoldenFile('../../../goldens/toast/success_toast.png'),
    );
  });

  testWidgets('Toast 2 - Error Toast', (WidgetTester tester) async {
    final Key toastKey = UniqueKey();
    final toast = CustomToast(
      key: toastKey,
      backgroundColor: AppColors.danger,
      icon: Icons.cancel,
      message: 'Error message',
      textColor: Colors.white,
    );

    await tester.pumpWidget(rootWidget(toast));
    await tester.pumpAndSettle();

    await expectLater(
      find.byKey(toastKey),
      matchesGoldenFile('../../../goldens/toast/error_toast.png'),
    );
  });

  testWidgets('Toast 3 - Alert Toast', (WidgetTester tester) async {
    final Key toastKey = UniqueKey();
    final toast = CustomToast(
      key: toastKey,
      backgroundColor: AppColors.alert,
      icon: Icons.info,
      message: 'Alert message',
      textColor: Colors.white,
    );

    await tester.pumpWidget(rootWidget(toast));
    await tester.pumpAndSettle();

    await expectLater(
      find.byKey(toastKey),
      matchesGoldenFile('../../../goldens/toast/alert_toast.png'),
    );
  });
}
