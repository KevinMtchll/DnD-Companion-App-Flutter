import 'package:flutter/material.dart';
import 'package:nbt_team17/map/tile.dart';

class MapAssets {
  
  final tileAssets = [
    'Default Character',
    'Custom Character',
    '1x1 Tiles',
    'Corners',
    'Edges',
    'Junctions'
  ];

  final List<TileAsset> oneByOne = [
    /* Add all placeable assets here as a TileAsset or
    a PlayerAvatar which is a subtype of TileAsset. */
    TileAsset(
      name: 'Horizontal Wall',
      assetID: 1,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black, shape: BoxShape.rectangle),
        child: Center(child: Image.asset('assets/1.png'))
      )
    ),
    TileAsset(
      name: 'Vertical Wall',
      assetID: 2,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black, shape: BoxShape.rectangle),
        child: Center(child: Image.asset('assets/2.png'))
      )
    ),
    TileAsset(
      name: 'Endpiece Left',
      assetID: 3,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black, shape: BoxShape.rectangle),
        child: Center(child: Image.asset('assets/3.png'))
      )
    ),
    TileAsset(
      name: 'Endpiece Right',
      assetID: 4,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black, shape: BoxShape.rectangle),
        child: Center(child: Image.asset('assets/4.png'))
      )
    ),
    TileAsset(
      name: 'Endpiece Top',
      assetID: 5,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black, shape: BoxShape.rectangle),
        child: Center(child: Image.asset('assets/5.png'))
      )
    ),
    TileAsset(
      name: 'Endpiece Bottom',
      assetID: 6,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black, shape: BoxShape.rectangle),
        child: Center(child: Image.asset('assets/6.png'))
      )
    ),
    TileAsset(
      name: 'Inner Bottom-Left',
      assetID: 9,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black, shape: BoxShape.rectangle),
        child: Center(child: Image.asset('assets/9.png'))
      )
    ),
    TileAsset(
      name: 'Inner Bottom-Right',
      assetID: 12,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black, shape: BoxShape.rectangle),
        child: Center(child: Image.asset('assets/12.png'))
      )
    ),
    TileAsset(
      name: 'Inner Top-Left',
      assetID: 10,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black, shape: BoxShape.rectangle),
        child: Center(child: Image.asset('assets/10.png'))
      )
    ),
    TileAsset(
      name: 'Inner Top-Right',
      assetID: 11,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black, shape: BoxShape.rectangle),
        child: Center(child: Image.asset('assets/11.png'))
      )
    ),
    TileAsset(
      name: 'Filler Wall',
      assetID: 7,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black, shape: BoxShape.rectangle),
        child: Center(child: Image.asset('assets/7.png'))
      )
    ),
  ];

  final List<TileAsset> wallCorners = [
    TileAsset(
      name: 'Corner Bottom-Left',
      assetID: 13,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black, shape: BoxShape.rectangle),
        child: Center(child: Image.asset('assets/13.png'))
      )
    ),
    TileAsset(
      name: 'Corner Bottom-Right',
      assetID: 16,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black, shape: BoxShape.rectangle),
        child: Center(child: Image.asset('assets/16.png'))
      )
    ),
    TileAsset(
      name: 'Corner Top-Left',
      assetID: 14,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black, shape: BoxShape.rectangle),
        child: Center(child: Image.asset('assets/14.png'))
      )
    ),
    TileAsset(
      name: 'Corner Top-Right',
      assetID: 15,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black, shape: BoxShape.rectangle),
        child: Center(child: Image.asset('assets/15.png'))
      )
    ),
  ];

  final List<TileAsset> wallEdges = [
    TileAsset(
      name: 'Wall Bottom',
      assetID: 17,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black, shape: BoxShape.rectangle),
        child: Center(child: Image.asset('assets/17.png'))
      )
    ),
    TileAsset(
      name: 'Wall Left',
      assetID: 18,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black, shape: BoxShape.rectangle),
        child: Center(child: Image.asset('assets/18.png'))
      )
    ),
    TileAsset(
      name: 'Wall Right',
      assetID: 20,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black, shape: BoxShape.rectangle),
        child: Center(child: Image.asset('assets/20.png'))
      )
    ),
    TileAsset(
      name: 'Wall Top',
      assetID: 19,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black, shape: BoxShape.rectangle),
        child: Center(child: Image.asset('assets/19.png'))
      )
    ),
  ];

  final List<TileAsset> junctions = [
    TileAsset(
      name: 'Junction 4-Way',
      assetID: 8,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black, shape: BoxShape.rectangle),
        child: Center(child: Image.asset('assets/8.png'))
      )
    ),
    TileAsset(
      name: 'Junction Left',
      assetID: 21,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black, shape: BoxShape.rectangle),
        child: Center(child: Image.asset('assets/21.png'))
      )
    ),
    TileAsset(
      name: 'Junction Right',
      assetID: 23,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black, shape: BoxShape.rectangle),
        child: Center(child: Image.asset('assets/23.png'))
      )
    ),
    TileAsset(
      name: 'Junction Top',
      assetID: 22,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black, shape: BoxShape.rectangle),
        child: Center(child: Image.asset('assets/22.png'))
      )
    ),
    TileAsset(
      name: 'Junction Bottom',
      assetID: 24,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black, shape: BoxShape.rectangle),
        child: Center(child: Image.asset('assets/24.png'))
      )
    ),
    TileAsset(
      name: 'Junction Top-Left',
      assetID: 25,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black, shape: BoxShape.rectangle),
        child: Center(child: Image.asset('assets/25.png'))
      )
    ),
    TileAsset(
      name: 'Junction Top-Right',
      assetID: 26,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black, shape: BoxShape.rectangle),
        child: Center(child: Image.asset('assets/26.png'))
      )
    ),
    TileAsset(
      name: 'Junction Bottom-Left',
      assetID: 28,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black, shape: BoxShape.rectangle),
        child: Center(child: Image.asset('assets/28.png'))
      )
    ),
    TileAsset(
      name: 'Junction Bottom-Right',
      assetID: 27,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black, shape: BoxShape.rectangle),
        child: Center(child: Image.asset('assets/27.png'))
      )
    ),
  ];
}
