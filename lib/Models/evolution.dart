class Evolution {
  final String name;
  final int id;
  final List<String> types;
  final String spriteUrl;
  final int? minLevel;

  Evolution({
    required this.name,
    required this.id,
    required this.types,
    required this.spriteUrl,
    this.minLevel,
  });
}
