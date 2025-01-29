import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class SpellsModel extends ChangeNotifier {
  SpellSlots _spellSlots;
  static const String _spellSlotsFileName = 'spellSlots.json';

  SpellsModel() : _spellSlots = SpellSlots() {
    loadSpellSlots();
  }

  List<List<bool>> getSpellSlots() {
    return _spellSlots.spellSlots as List<List<bool>>;
  }

  Future<void> loadSpellSlots() async {
    Directory dir = await getApplicationDocumentsDirectory();
    File file = File('${dir.path}/$_spellSlotsFileName');
    if (await file.exists()) {
      String data = await file.readAsString();
      List<dynamic> json = jsonDecode(data) as List<dynamic>;
      _spellSlots = SpellSlots.fromJson(json);
      notifyListeners();
    }
  }

  Future<File> saveSpellSlots() async {
    Directory dir = await getApplicationDocumentsDirectory();
    File file = File('${dir.path}/$_spellSlotsFileName');
    final encoded = jsonEncode(_spellSlots);
    return await file.writeAsString(encoded);
  }

  void addSpellSlot(int level) {
    _spellSlots.addSpellSlot(level);
    notifyListeners();
    saveSpellSlots();
  }

  void removeSpellSlot(int level) {
    _spellSlots.removeSpellSlot(level);
    notifyListeners();
    saveSpellSlots();
  }

  void resetSpellSlots() {
    _spellSlots.resetSpellSlots();
    notifyListeners();
    saveSpellSlots();
  }

  bool getSpellSlot(int level, int index) {
    return _spellSlots.getSpellSlot(level, index);
  }

  void setSpellSlotFalse(int level, int indx) {
    _spellSlots.setSlotFalse(level, indx);
    notifyListeners();
    saveSpellSlots();
  }
}

class SpellSlots {
  final List<List<bool>> _spellSlots;

  SpellSlots() : _spellSlots = [];

  get spellSlots => _spellSlots;

  void addSpellSlot(int level) {
    while (_spellSlots.length <= level) {
      _spellSlots.add([]);
    }
    _spellSlots[level].add(true);
  }

  void removeSpellSlot(int level) {
    if (level >= _spellSlots.length) {
      return;
    }
    if (_spellSlots[level].isEmpty) {
      return;
    }

    _spellSlots[level].removeLast();

    if (_spellSlots[level].isEmpty && level == _spellSlots.length - 1) {
      _spellSlots.removeLast();
    }
  }

  void setSlotFalse(int level, int indx) {
    if (level >= _spellSlots.length) {
      return;
    }
    if (indx >= _spellSlots[level].length) {
      return;
    }
    _spellSlots[level][indx] = false;
  }

  void resetSpellSlots() {
    for (int i = 0; i < _spellSlots.length; i++) {
      for (int j = 0; j < _spellSlots[i].length; j++) {
        _spellSlots[i][j] = true;
      }
    }
  }

  bool getSpellSlot(int level, int index) {
    try {
      return _spellSlots[level][index];
    } catch (e) {
      return false;
    }
  }

  SpellSlots.fromJson(List<dynamic> json)
      : _spellSlots = json
            .map((list) => (list as List).map((b) => b as bool).toList())
            .toList();

  List<dynamic> toJson() => _spellSlots;
}
