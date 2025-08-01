import 'package:rick_and_morty/app_imports.dart';

class ServiceLocator {
  ServiceLocator._();

  static GetIt get locator => GetIt.instance;
  static Future<void> setupServiceLocator() async {
    await _registerBaseServices();
    await _registerInfra();
    await _registerExternal();
    await _registerPresenter();
  }

  static Future<void> _registerBaseServices() async {
    GetIt.I.registerLazySingleton<Dio>(() {
      return DioFactory.create();
    });
    GetIt.I.registerSingleton<IHttpService>(HttpServiceImp(locator<Dio>()));
  }

  static Future<void> _registerInfra() async {
    GetIt.I.registerLazySingleton<ICharacterRepository>(
      () => CharacterRepositoryImp(locator()),
    );
  }

  static Future<void> _registerExternal() async {
    GetIt.I.registerLazySingleton<ICharacterDatasource>(
      () => CharacterExternalDatasourceImp(locator()),
    );
  }

  static Future<void> _registerPresenter() async {
    GetIt.I.registerFactory<HomeCubit>(() => HomeCubit(locator()));
  }

  static Future<void> resetAllInstances() async {
    await locator.reset();
    await setupServiceLocator();
  }
}
