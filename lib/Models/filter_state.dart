class FilterState {
  final List<String> generations;
  final List<String> types;
  final List<String> weaknesses;
  final double minWeight;
  final double maxWeight;
  final int minHeight;
  final int maxHeight;
  late final String orderBy;

  FilterState({
    required this.generations,
    required this.types,
    required this.weaknesses,
    required this.minWeight,
    required this.maxWeight,
    required this.minHeight,
    required this.maxHeight,
    required this.orderBy,
  });

  Map<String, dynamic> toMap() {
    return {
      'generations': generations.join(','),
      'types': types.join(','),
      'weaknesses': weaknesses.join(','),
      'minWeight': minWeight,
      'maxWeight': maxWeight,
      'minHeight': minHeight,
      'maxHeight': maxHeight,
      'orderBy': orderBy,
    };
  }

  factory FilterState.fromMap(Map<String, dynamic> map) {
    return FilterState(
      generations: (map['generations'] as String).split(','),
      types: (map['types'] as String).split(','),
      weaknesses: (map['weaknesses'] as String).split(','),
      minWeight: map['minWeight'],
      maxWeight: map['maxWeight'],
      minHeight: map['minHeight'],
      maxHeight: map['maxHeight'],
      orderBy: map['orderBy'],
    );
  }
}
