import 'package:rick_and_morty/app_imports.dart';

class CharacterMapper {
  static CharacterEntity fromMap(Map<String, dynamic> map) {
    return CharacterEntity(
      id: map['id'] as int,
      name: map['name'] as String,
      status: map['status'] as String,
      species: map['species'] as String,
      type: map['type'] as String,
      gender: map['gender'] as String,
      imageUrl: map['image'] as String,
      episodes: List<String>.from(map['episode'] as List<dynamic>),
      url: map['url'] as String,
      created: map['created'] as String,
    );
  }
}
