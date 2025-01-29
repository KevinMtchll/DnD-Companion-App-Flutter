import 'package:flutter/material.dart';
import 'package:nbt_team17/map/tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapModel extends ChangeNotifier {
  TileAsset? _currentTile;
  TileAsset? get currentTile => _currentTile;

  void setTile(TileAsset? tile) {
    _currentTile = tile;
    notifyListeners();
  }

  void setName(String name) {
    _currentTile!.name = name;
    notifyListeners();
  }
  
  void setChild(Widget child) {
    _currentTile!.child = child;
    notifyListeners();
  }

  void initializeMapCount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('maps') == null) {
      prefs.setStringList('maps', []);
    }
  }

  void addMap(String mapName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> maps = prefs.getStringList('maps')!;
    if (!(maps.contains(mapName))) {
      maps.add(mapName);
    }
    prefs.setStringList('maps', maps);
  }
}