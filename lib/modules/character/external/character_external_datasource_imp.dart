import 'dart:convert';

import 'package:rick_and_morty/app_imports.dart';

class CharacterExternalDatasourceImp implements ICharacterDatasource {
  final IHttpService _httpService;
  CharacterExternalDatasourceImp(this._httpService);

  @override
  Future<String> getCharactersList({
    int? page,
    String? searchQuery,
    GenderEnum? gender,
    SpeciesEnum? specie,
    StatusEnum? status,
  }) async {
    try {
      final response = await _httpService.restRequest(
        url: 'character/',
        query: {
          if (page != null) 'page': page,
          if (searchQuery != null) 'name': searchQuery,
          if (gender != null) 'gender': gender.name,
          if (specie != null) 'species': specie.specie,
          if (status != null) 'status': status.name,
        },
        method: HttpMethodsEnum.get,
      );
      return jsonEncode(response?['results']);
    } catch (e) {
      rethrow;
    }
  }
}
