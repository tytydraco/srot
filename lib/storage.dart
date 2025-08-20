import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:srot/substance.dart';

/// Return the saved list of [Substance]s.
Future<List<Substance>> getSubstances() async {
  final sharedPrefs = await SharedPreferences.getInstance();

  final substancesJson = sharedPrefs.getStringList('substances');
  final substances = substancesJson?.map(
    (e) {
      final json = jsonDecode(e) as Map<String, dynamic>;
      return Substance.fromJson(json);
    },
  ).toList();

  return substances ?? [];
}

/// Add a saved [Subst
Future<void> addSubstance(Substance substance) async {
  final sharedPrefs = await SharedPreferences.getInstance();

  final substances = await getSubstances();
  substances.add(substance);

  final substancesJson = substances.map(
    (e) {
      final json = e.toJson();
      return jsonEncode(json);
    },
  ).toList();

  await sharedPrefs.setStringList('substances', substancesJson);
}

/// Update a saved [Substance]'s used time.
Future<void> updateSubstance(Substance substance) async {
  final substances = await getSubstances();

  final idx =
      substances.indexWhere((element) => element.name == substance.name);
  substances[idx].lastUsed = DateTime.now().millisecondsSinceEpoch;

  await setSubstances(substances);
}

/// Remove a saved [Substance] by name.
Future<void> removeSubstance(Substance substance) async {
  final sharedPrefs = await SharedPreferences.getInstance();

  final substances = await getSubstances();
  substances.removeWhere((element) => element.name == substance.name);

  final substancesJson = substances.map(
    (e) {
      final json = e.toJson();
      return jsonEncode(json);
    },
  ).toList();

  await sharedPrefs.setStringList('substances', substancesJson);
}

/// Set all [Substance]s.
Future<void> setSubstances(List<Substance> substances) async {
  final sharedPrefs = await SharedPreferences.getInstance();

  final substancesJson = substances.map(
    (e) {
      final json = e.toJson();
      return jsonEncode(json);
    },
  ).toList();

  await sharedPrefs.setStringList('substances', substancesJson);
}
