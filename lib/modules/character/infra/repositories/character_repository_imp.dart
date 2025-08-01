import 'dart:convert';

import 'package:rick_and_morty/app_imports.dart';

class CharacterRepositoryImp implements ICharacterRepository {
  final ICharacterDatasource _datasource;

  CharacterRepositoryImp(this._datasource);

  @override
  Future<List<CharacterEntity>> getCharactersList({
    int? page,
    String? searchQuery,
    GenderEnum? gender,
    SpeciesEnum? specie,
    StatusEnum? status,
  }) async {
    try {
      final response = await _datasource.getCharactersList(
        page: page,
        searchQuery: searchQuery,
        gender: gender,
        specie: specie,
        status: status,
      );
      return List<CharacterEntity>.from(
        jsonDecode(response).map((x) => CharacterMapper.fromMap(x)),
      ).toList();
    } catch (e) {
      if (e is IDefaultException) {
        throw CharacterException(e, e.message, StackTrace.current);
      } else if (e is Exception) {
        throw CharacterException(e, e.toString(), StackTrace.current);
      }
      throw CharacterException(e, 'Error while logging in', StackTrace.current);
    }
  }
  // @override
  // Future<UserEntity> login({
  //   required String cpf,
  //   required String password,
  // }) async {
  //   try {
  //     final response = await _datasource.login({
  //       'cpf': cpf,
  //       'password': password,
  //     });
  //     final user = UserMapper.fromMap(jsonDecode(response));

  //     return user;
  //   } catch (e) {
  //     if (e is IDefaultException) {
  //       throw LoginException(e, e.message, StackTrace.current);
  //     } else if (e is Exception) {
  //       throw LoginException(e, e.toString(), StackTrace.current);
  //     }
  //     throw LoginException(e, 'Error while logging in', StackTrace.current);
  //   }
  // }
}
