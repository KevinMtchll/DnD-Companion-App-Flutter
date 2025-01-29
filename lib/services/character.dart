import 'package:flutter/material.dart';
import 'package:nbt_team17/services/character_weapon.dart';

class Character {
  final String name;
  final String characterRace;
  final String characterClass;
  final int level;
  final String background;
  final String hp;
  final int ac;
  final int speed;
  final int initiative;
  final String strength;
  final String dexterity;
  final String constitution;
  final String intelligence;
  final String wisdom;
  final String charisma;
  final CharacterWeapon weapon1;
  final CharacterWeapon weapon2;
  final String badge;

  Character({
    required this.characterRace,
    required this.hp, 
    required this.ac, 
    required this.speed, 
    required this.initiative, 
    required this.strength, 
    required this.dexterity, 
    required this.constitution, 
    required this.intelligence, 
    required this.wisdom, 
    required this.charisma,
    required this.name,
    required this.characterClass,
    required this.level,
    required this.background,
    required this.weapon1,
    required this.weapon2,
    required this.badge
  });

  RangeValues getHPValues() {
    final match = RegExp(r'([0-9]+)\/([0-9]+)$').firstMatch(hp);
    final start = match?.group(1);
    final end = match?.group(2);

    return RangeValues(double.parse(start ?? '0'),double.parse(end ?? '100'));
  }

  int getMainStrength() {
    final match = RegExp(r'([0-9]+)\(\+([0-9]+)\)$').firstMatch(strength);
    final mainStrength = match?.group(1);

    return int.parse(mainStrength ?? '0');
  }

  int getAddStrength() {
    final match = RegExp(r'([0-9]+)\(\+([0-9]+)\)$').firstMatch(strength);
    final addStrength = match?.group(2);

    return int.parse(addStrength ?? '0');
  }

  int getMainDexterity() {
    final match = RegExp(r'([0-9]+)\(\+([0-9]+)\)$').firstMatch(dexterity);
    final mainDexterity = match?.group(1);

    return int.parse(mainDexterity ?? '0');
  }

  int getAddDexterity() {
    final match = RegExp(r'([0-9]+)\(\+([0-9]+)\)$').firstMatch(dexterity);
    final addDexterity = match?.group(2);

    return int.parse(addDexterity ?? '0');
  }

  int getMainConstitution() {
    final match = RegExp(r'([0-9]+)\(\+([0-9]+)\)$').firstMatch(constitution);
    final mainConstitution = match?.group(1);

    return int.parse(mainConstitution ?? '0');
  }

  int getAddConstitution() {
    final match = RegExp(r'([0-9]+)\(\+([0-9]+)\)$').firstMatch(constitution);
    final addConstitution = match?.group(2);

    return int.parse(addConstitution ?? '0');
  }

  int getMainIntelligence() {
    final match = RegExp(r'([0-9]+)\(\+([0-9]+)\)$').firstMatch(intelligence);
    final mainIntelligence = match?.group(1);

    return int.parse(mainIntelligence ?? '0');
  }

  int getAddIntelligence() {
    final match = RegExp(r'([0-9]+)\(\+([0-9]+)\)$').firstMatch(intelligence);
    final addIntelligence = match?.group(2);

    return int.parse(addIntelligence ?? '0');
  }

  int getMainWisdom() {
    final match = RegExp(r'([0-9]+)\(\+([0-9]+)\)$').firstMatch(wisdom);
    final mainWisdom = match?.group(1);

    return int.parse(mainWisdom ?? '0');
  }

  int getAddWisdom() {
    final match = RegExp(r'([0-9]+)\(\+([0-9]+)\)$').firstMatch(wisdom);
    final addWisdom = match?.group(2);

    return int.parse(addWisdom ?? '0');
  }

  int getMainCharisma() {
    final match = RegExp(r'([0-9]+)\(\+([0-9]+)\)$').firstMatch(charisma);
    final mainCharisma = match?.group(1);

    return int.parse(mainCharisma ?? '0');
  }

  int getAddCharisma() {
    final match = RegExp(r'([0-9]+)\(\+([0-9]+)\)$').firstMatch(charisma);
    final addCharisma = match?.group(2);

    return int.parse(addCharisma ?? '0');
  }

  int getWeapon1Attack() {
    return int.parse(weapon1.attack);
  }

  String getWeapon1DamageDice() {
    final match = RegExp(r'([0-9]d[0-9]+) \+ ([0-9]+)$').firstMatch(weapon1.damage);
    final damageDice = match?.group(1);

    return damageDice ?? '[null]';
  }

  int getWeapon1Damage() {
    final match = RegExp(r'([0-9]d[0-9]+) \+ ([0-9]+)$').firstMatch(weapon1.damage);
    final damage = match?.group(2);

    return int.parse(damage ?? '0');
  }

  int getWeapon2Attack() {
    return int.parse(weapon2.attack);
  }

  String getWeapon2DamageDice() {
    final match = RegExp(r'([0-9]d[0-9]+) \+ ([0-9]+)$').firstMatch(weapon2.damage);
    final damageDice = match?.group(1);

    return damageDice ?? '[null]';
  }

  int getWeapon2Damage() {
    final match = RegExp(r'([0-9]d[0-9]+) \+ ([0-9]+)$').firstMatch(weapon2.damage);
    final damage = match?.group(2);

    return int.parse(damage ?? '0');
  }

}