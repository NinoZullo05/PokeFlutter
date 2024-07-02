class FavoritePokemon {
  final int id;
  final String name;
  final String imageUrl;

  FavoritePokemon({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
    };
  }

  factory FavoritePokemon.fromMap(Map<String, dynamic> map) {
    return FavoritePokemon(
      id: map['id'],
      name: map['name'],
      imageUrl: map['imageUrl'],
    );
  }
}
