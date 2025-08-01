class CharacterEntity {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;

  final String imageUrl;
  final List<String> episodes;
  final String url;
  final String created;

  CharacterEntity({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,

    required this.imageUrl,
    required this.episodes,
    required this.url,
    required this.created,
  });
}
