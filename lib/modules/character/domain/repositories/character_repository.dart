import 'package:rick_and_morty/app_imports.dart';

abstract class ICharacterRepository {
  Future<List<CharacterEntity>> getCharactersList({
    int? page,
    String? searchQuery,
    GenderEnum? gender,
    SpeciesEnum? specie,
    StatusEnum? status,
  });
}
