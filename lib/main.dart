import 'dart:async';

import 'package:rick_and_morty/app_imports.dart';

FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ServiceLocator.setupServiceLocator();
  runApp(const MyApp());
}
