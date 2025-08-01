import 'package:rick_and_morty/app_imports.dart';

abstract class ICharacterDatasource {
  Future<String> getCharactersList({
    int? page,
    String? searchQuery,
    GenderEnum? gender,
    SpeciesEnum? specie,
    StatusEnum? status,
  });
}
