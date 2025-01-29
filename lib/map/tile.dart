/* These objects define the placeable tiles */
import 'package:flutter/material.dart';

class TileAsset {
  Widget child;
  // The current x and y coordinates of the tile object,
  // on the map. Dont change these from -1 when initializing.
  int x;
  int y;
  String name;
  int assetID;
  bool isPlayer;
  TileAsset(
      {required this.child,
      required this.name,
      this.x = -1,
      this.y = -1,
      required this.assetID,
      this.isPlayer = false,
      });
  TileAsset.fromJson(Map<String,dynamic> m) :
    child = m['child'],
    x = m['x'],
    y = m['y'],
    name = m['name'],
    assetID = m['assetID'],
    isPlayer = m['isPlayer'];
}

class PlayerAvatar extends TileAsset {
  PlayerAvatar({
    required super.child,
    required super.name,
    super.x,
    super.y,
    super.assetID = -1,
    super.isPlayer = true,
  });
  PlayerAvatar.fromJson(super.m) : super.fromJson();
}

class MapData {
  int width;
  int height;
  String placedTilesJson;

  MapData({required this.width, required this.height, required this.placedTilesJson});
  MapData.fromJson(Map<String,dynamic> m) :
    width = m['width'],
    height = m['height'],
    placedTilesJson = m['placedTilesJson'];
}
