/// A substance.
class Substance {
  /// Creates a new [Substance].
  Substance({
    required this.name,
    required this.daysBetween,
    required this.lastUsed,
  });

  /// Creates a new [Substance] from JSON.
  Substance.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        daysBetween = json['days_between'] as int,
        lastUsed = json['last_used'] as double;

  /// The substance name.
  final String name;

  /// How many days you must wait between doses.
  final int daysBetween;

  /// The epoch time the substance was last used.
  final double? lastUsed;

  /// Convert to JSON.
  Map<String, dynamic> toJson() => {
        'name': name,
        'days_between': daysBetween,
        'last_used': lastUsed,
      };
}
