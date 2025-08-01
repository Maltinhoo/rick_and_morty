import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rick_and_morty/app_imports.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    const channel = MethodChannel('plugins.flutter.io/path_provider');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          if (methodCall.method == 'getTemporaryDirectory') {
            return '/tmp'; // Return a fake temporary directory path
          }
          if (methodCall.method == 'getApplicationSupportDirectory') {
            return '/app_support'; // Return a fake application support directory path
          }
          return null;
        });

    await getTemporaryDirectory();
    await getApplicationSupportDirectory();
  });

  Widget rootWidget(Widget body) {
    return MainPageInit(
      child: MaterialApp(home: Scaffold(body: body)),
    );
  }

  testWidgets('Image 1 - Network Image', (WidgetTester tester) async {
    final Key key = UniqueKey();
    await tester.pumpWidget(
      rootWidget(
        CustomImage(
          key: key,
          image: 'https://placehold.co/600x400',
          width: 150,
          height: 150,
          fit: BoxFit.cover,
        ),
      ),
    );

    await tester.pump();

    await expectLater(
      find.byKey(key),
      matchesGoldenFile('../../../goldens/image/network_image.png'),
    );
  });

  testWidgets('Image 2 - Local Asset', (WidgetTester tester) async {
    final Key key = UniqueKey();
    await tester.pumpWidget(
      rootWidget(
        CustomImage(
          key: key,
          local: true,
          image: 'placeholder.jpg',
          width: 150,
          height: 150,
          fit: BoxFit.cover,
        ),
      ),
    );

    await tester.pump();

    await expectLater(
      find.byKey(key),
      matchesGoldenFile('../../../goldens/image/local_asset.png'),
    );
  });

  testWidgets('Image 3 - Error Widget', (WidgetTester tester) async {
    final Key key = UniqueKey();
    await tester.pumpWidget(
      rootWidget(
        CustomImage(
          key: key,
          image: 'https://via.placeholder.com/150',
          width: 150,
          height: 150,
          fit: BoxFit.cover,
          errorWidget: (context, error, stacktrace) {
            return const Vector(Icons.image);
          },
        ),
      ),
    );

    await tester.pump();

    await expectLater(
      find.byKey(key),
      matchesGoldenFile('../../../goldens/image/error_widget.png'),
    );
  });
}
