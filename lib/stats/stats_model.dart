import 'package:flutter/material.dart';

class StatsModel extends ChangeNotifier {
  String _characterName = "[no name specified]";
  String _raceName = "[no race specified]";
  String _className = "[no class specified]";
  int _levelNum = 0;
  String _backgroundText = "[no background specified]";

  RangeValues _hp = const RangeValues(0.0, 100.0);
  int _ac = 0;
  int _speed = 0;
  int _initiative = 0;

  int _mainStrength = 5;
  int _mainDexterity = 5;
  int _mainConstitution = 5;
  int _mainIntelligence = 5;
  int _mainWisdom = 5;
  int _mainCharisma = 5;
  int _addStrength = 0;
  int _addDexterity = 0;
  int _addConstitution = 0;
  int _addIntelligence = 0;
  int _addWisdom = 0;
  int _addCharisma = 0;

  String _weapon1Name = "[null]";
  int _weapon1Attack = 0;
  int _weapon1Damage = 0;
  String _weapon1DamageDice = "[null]";
  String _weapon1DType = "[null]";

  String _weapon2Name = "[null]";
  int _weapon2Attack = 0;
  int _weapon2Damage = 0;
  String _weapon2DamageDice = "[null]";
  String _weapon2DType = "[null]";
  String _badge = "[null]";


  // GETTERS
  String get characterName => _characterName;
  String get raceName => _raceName;
  String get className => _className;
  String get backgroundText => _backgroundText;
  RangeValues get hp => _hp;
  String get weapon1Name => _weapon1Name;
  int get weapon1Attack => _weapon1Attack;
  int get weapon1Damage => _weapon1Damage;
  String get weapon1DamageDice => _weapon1DamageDice;
  String get weapon1DType => _weapon1DType;
  String get weapon2Name => _weapon2Name;
  int get weapon2Attack => _weapon2Attack;
  int get weapon2Damage => _weapon2Damage;
  String get weapon2DamageDice => _weapon2DamageDice;
  String get weapon2DType => _weapon2DType;
  int get levelNum => _levelNum;
  int get ac => _ac;
  int get speed => _speed;
  int get initiative => _initiative;
  int get mainStrength => _mainStrength;
  int get addStrength => _addStrength;
  int get mainDexterity => _mainDexterity;
  int get addDexterity => _addDexterity;
  int get mainConstitution => _mainConstitution;
  int get addConstitution => _addConstitution;
  int get mainIntelligence => _mainIntelligence;
  int get addIntelligence => _addIntelligence;
  int get mainWisdom => _mainWisdom;
  int get addWisdom => _addWisdom;
  int get mainCharisma => _mainCharisma;
  int get addCharisma => _addCharisma;
  String get badge => _badge;


  // SETTERS
  void updateCharacterName(String name) {
    _characterName = name;
    notifyListeners();
  }

  void updateRaceName(String race) {
    _raceName = race;
    notifyListeners();
  }

  void updateClassName(String c) {
    _className = c;
    notifyListeners();
  }

  void updateBackgroundText(String back) {
    _backgroundText = back;
    notifyListeners();
  }

  void updateLevel(int val) {
    try {
      _levelNum = val;
    } on Exception catch (_) {
      _levelNum = 0;
    }
    
    notifyListeners();
  }

  void updateHP(RangeValues v1) {
    _hp = v1;
    notifyListeners();
  }

  void updateAC(int num) {
    try {
      _ac = num;
    } on Exception catch (_) {
      _ac = 0;
    }
    
    notifyListeners();
  }

  void updateSpeed(int num) {
    try {
      _speed = num;
    } on Exception catch (_) {
      _speed = 0;
    }
    
    notifyListeners();
  }

  void updateInitiative(int num) {
    try {
      _initiative = num;
    } on Exception catch (_) {
      _initiative = 0;
    }
    
    notifyListeners();
  }

  void updateMainStrength(int main) {
    _mainStrength = main;
    notifyListeners();
  }

  void updateAddStrength(int add) {
    _addStrength = add;
    notifyListeners();
  }
  void updateMainDexterity(int main) {
    _mainDexterity = main;
    notifyListeners();
  }

  void updateAddDexterity(int add) {
    _addDexterity = add;
    notifyListeners();
  }

  void updateMainConstitution(int main) {
    _mainConstitution = main;
    notifyListeners();
  }

  void updateAddConstitution(int add) {
    _addConstitution = add;
    notifyListeners();
  }

  void updateMainIntelligence(int main) {
    _mainIntelligence = main;
    notifyListeners();
  }
  void updateAddIntelligence(int add) {
    _addIntelligence = add;
    notifyListeners();
  }

  void updateMainWisdom(int main) {
    _mainWisdom = main;
    notifyListeners();
  }
  void updateAddWisdom(int add) {
    _addWisdom = add;
    notifyListeners();
  }

  void updateMainCharisma(int main) {
    _mainCharisma = main;
    notifyListeners();
  }

  void updateAddCharisma(int add) {
    _addCharisma = add;
    notifyListeners();
  }

  void updateWeapon1Name(String val) {
    _weapon1Name = val;
    notifyListeners();
  }

  void updateWeapon1Attack(int val) {
    _weapon1Attack = val;
    notifyListeners();
  }

  void updateWeapon1Damage(int val) {
    _weapon1Damage = val;
    notifyListeners();
  }

  void updateWeapon1DamageDice(String val) {
    _weapon1DamageDice = val;
    notifyListeners();
  }

  void updateWeapon1DType(String val) {
    _weapon1DType = val;
    notifyListeners();
  }

  void updateWeapon2Name(String val) {
    _weapon2Name = val;
    notifyListeners();
  }

  void updateWeapon2Attack(int val) {
    _weapon2Attack = val;
    notifyListeners();
  }

  void updateWeapon2Damage(int val) {
    _weapon2Damage = val;
    notifyListeners();
  }

  void updateWeapon2DamageDice(String val) {
    _weapon2DamageDice = val;
    notifyListeners();
  }

  void updateWeapon2DType(String val) {
    _weapon2DType = val;
    notifyListeners();
  }

  void updateBadge(String val) {
    _badge = val;
    notifyListeners();
  }
}