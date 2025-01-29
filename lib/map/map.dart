import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nbt_team17/defaults/app_defaults.dart';
import 'package:nbt_team17/map/map_model.dart';
import 'package:nbt_team17/map/tile.dart';
import 'package:nbt_team17/services/file_manager.dart';
import 'package:provider/provider.dart';
import 'package:nbt_team17/services/database_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'character_stats_popup.dart';
import 'package:path_provider/path_provider.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static List<TileAsset> _currentPlacedTiles = [];
  late TextEditingController _inputWidth;
  late TextEditingController _inputHeight;
  late TextEditingController _inputName;
  static bool defaultsAdded = false;
  static late int _width;
  static late int _height;
  static late Column _currentMap;
  static int _mapPageIndex = 0;
  static late String mapName;
  bool playerSelected = false;
  int _editMode = 3;
  TileAsset? _currentSelectedTile;

  @override
  void initState() {
    _inputWidth = TextEditingController();
    _inputHeight = TextEditingController();
    _inputName = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _inputWidth.dispose();
    _inputHeight.dispose();
    _inputName.dispose();
    super.dispose();
  }

  // I'm using a switch statement for this page navigation because
  // Navigator.push() removes the Navigation Bar, and I wanted to
  // keep it on the bottom while going through the different menus.
  @override
  Widget build(BuildContext context) {
    if (!defaultsAdded) {
      addDefaults();
      defaultsAdded = true;
    }
    _currentSelectedTile = context.read<MapModel>().currentTile;
    context.read<MapModel>().initializeMapCount();
    /* 1 = Prompt for map size, 2 = Map Page, default = Choose Map */
    return switch (_mapPageIndex) {
      // Prompt user for map size //
      1 => Center(
          child: SizedBox(
            width: 200,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Map size:', style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(hintText: "Width"),
                          keyboardType: TextInputType.number,
                          controller: _inputWidth,
                        ),
                      ),
                      const Expanded(child: Center(child: Text('X'))),
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(hintText: "Height"),
                          keyboardType: TextInputType.number,
                          controller: _inputHeight,
                        ),
                      ),
                    ],
                  ),
                  TextField(
                    decoration: const InputDecoration(hintText: "Name"),
                    controller: _inputName,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        // Back button
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(10),
                        ),
                        onPressed: () {
                          setState(() => _mapPageIndex = 0);
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          size: 40,
                        )
                      ),
                      const SizedBox(width: 15),
                      ElevatedButton(
                        // Confirm button
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(10),
                        ),
                        onPressed: () {
                          _width = int.parse(_inputWidth.text);
                          _height = int.parse(_inputHeight.text);
                          mapName = _inputName.text;
                          _currentMap = generateMap();
                          setState(() {
                            _editMode = 0;
                            _mapPageIndex = 2;
                          });
                        },
                        child: const Icon(Icons.check, size: 40)
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      // The Map Page //
      2 => Stack(children: [
        InteractiveViewer(
          // Allow the map to be draggable
          minScale: 0.1,
          maxScale: 1,
          constrained: false, // Allow overflow
          boundaryMargin: const EdgeInsets.all(double.infinity),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(131, 141, 138, 138),
                // const Color.fromARGB(68, 41, 40, 40)
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: _currentMap,
              ))),
      generateMapMenu(),
      _currentSelectedTile != null
        ? Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Selected: ${context.read<MapModel>().currentTile!.name}',
              style: Theme.of(context).textTheme.headlineSmall),
          ))
        : const SizedBox(),
      ]),
      _ => Column(
        children: [
          Container(
            color: Colors.white,
            child: Align(
              alignment: Alignment.center,
              child: Text("Maps", style: AppDefaults.heading1Dark, textAlign: TextAlign.center),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: SharedPreferences.getInstance(),
              builder: (context,snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.getStringList('maps')!.length + 1,
                    itemBuilder: (context,index) {
                      if (index == (snapshot.data!.getStringList('maps')!.length)) {
                        return ListTile(
                          title: const Text('Create New Map', style: AppDefaults.listItem), 
                          leading: const Icon(Icons.add, color: Colors.white, size: 30),
                          onTap: () {
                            setState(() {
                              _mapPageIndex = 1;
                            });
                          },
                        );
                      }
                      return ListTile(
                        title: Text(snapshot.data!.getStringList('maps')![index], style: AppDefaults.listItem),
                        leading: const Icon(Icons.area_chart_sharp, color: Colors.white, size: 30),
                        onTap: () async {
                          await readMap(snapshot.data!.getStringList('maps')![index]);
                          setState(() {
                            _currentMap = generateMap();
                            _editMode = 0;
                            _mapPageIndex = 2;
                          });
                        },
                      );
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }
            ),
          )
        ]
      ),
    };
  }

  Widget rebuildWithPopup(PlayerAvatar tile) {
    Container assumedChild = tile.child as Container;
    Stack stack = assumedChild.child as Stack;
    if (_currentSelectedTile == tile) {
      stack.children.add(
        Align(
          alignment: Alignment.topCenter,
          child: IconButton(
            icon: const Icon(Icons.bar_chart, color: Colors.white,),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => CharacterStatsPopup(
                  characterName: tile.name,
                  dbService: DatabaseService.instance,
                  onClose: () => Navigator.of(context).pop(),
                ),
              );
            },
          ),
        ),
      );
    } else {
      stack = Stack(
        children: stack.children.sublist(0,2),
      );
    }
    return Container(
      decoration:
        const BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle),
      child: stack
    );
  }

  void addDefaults() async {
    var mapModel = context.read<MapModel>();
    String downloadDir = (await getExternalStorageDirectory())!.path;
    mapModel.addMap('Labyrinth');
    await File('$downloadDir/Labyrinth.json').writeAsString(await rootBundle.loadString('assets/Labyrinth.json'));
  }

  Future<bool> saveMap(String name) async {
    String downloadDir = (await getExternalStorageDirectory())!.path;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? mapCount = prefs.getInt('mapCount');
    List<Map> downloadTiles = [];
    mapCount ??= 0;
    for (TileAsset tile in _currentPlacedTiles) {
      var map = {
        'x':tile.x, 
        'y':tile.y, 
        'name':tile.name,
        'assetID':tile.assetID,
        'isPlayer':tile.isPlayer,
      };
      downloadTiles.add(map as Map);
    }
    Map<String,dynamic> downloadMap = {
      'width':_width,
      'height':_height,
      'placedTilesJson':jsonEncode(downloadTiles)
    };
    if (await File('$downloadDir/$name.json').exists()) {
      await File('$downloadDir/$name.json').delete();
    }
    await File('$downloadDir/$name.json').writeAsString(jsonEncode(downloadMap));
    print('Saved a $_width x $_height map to $downloadDir/$name.json');
    return true;
  }

  Future<bool> readMap(String name) async {
    String downloadDir = (await getExternalStorageDirectory())!.path;
    String jsonStr = await File('$downloadDir/$name.json').readAsString();
    Map<String,dynamic> map = json.decode(jsonStr);
    MapData convertedMap = MapData.fromJson(map);
    mapName = name;
    _height = convertedMap.height;
    _width = convertedMap.width;
    List<dynamic> lst = json.decode(convertedMap.placedTilesJson);
    for (dynamic elem in lst) {
      elem = elem as Map<String,dynamic>;
      if (elem['isPlayer']) {
        _currentPlacedTiles.add(
        PlayerAvatar(
          x: elem['x'],
          y: elem['y'],
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle),
              child: Stack(
                children: [
                  ClipOval(
                    child: FutureBuilder(
                      future: _getBadgeFromPlayerName(elem['name']), 
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasData) {
                          return snapshot.data!;
                        } else {
                          return const Placeholder();
                        }
                      }
                    ),
                  ),
                  Center(
                    child: Text(
                      elem['name'], 
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)
                    )
                  ),
                ],
              )
          ),
          name: elem['name'], 
          assetID: elem['assetID'], 
          ),
        );
      } else {
        _currentPlacedTiles.add(
        TileAsset(
          x: elem['x'],
          y: elem['y'],
          child:Container(
            decoration: const BoxDecoration(
                color: Colors.black, shape: BoxShape.rectangle
            ),
            child: Center(child: Image.asset('assets/${elem['assetID']}.png'))
          ), 
          name: elem['name'], 
          assetID: elem['assetID'])
        );
      }
    }
    print('Loaded a $_width x $_height map from $downloadDir/$name.json');
    return true;
  }

  // The map is a column holding rows.
  Column generateMap() {
    _currentSelectedTile = context.read<MapModel>().currentTile;
    List<Row> columnChildren = [];
    late Row rowChildren;
    for (int y = 0; y < _height; y++) {
      List<Widget> nodes = [];
      for (int x = 0; x < _width; x++) {
        nodes.add(SizedBox(
          width: 100,
          height: 100,
          // Each tile has a gesture detector, but the x and y coordinates have to be
          // dynamically assigned.
          child: GestureDetector(
              onTap: () {
                _currentSelectedTile = context.read<MapModel>().currentTile;
                // if in editing mode (1), or the player avatar is selected, then allow movement of tile
                if ((_currentSelectedTile != null)) {
                  if (_currentSelectedTile is! PlayerAvatar && _editMode == 1) {
                    // This allows multiple tiles to be placed in a row
                    // in edit mode, unless a player avatar is being placed since
                    // there should only be one of those.
                    _currentSelectedTile = TileAsset(
                        child: _currentSelectedTile!.child,
                        name: _currentSelectedTile!.name,
                        x: x,
                        y: y,
                        assetID: _currentSelectedTile!.assetID);
                    _currentPlacedTiles.add(_currentSelectedTile!);
                    _currentMap = generateMap();
                    context.read<MapModel>().setTile(_currentSelectedTile);
                  } else if (_currentSelectedTile is PlayerAvatar) {
                    // This assumes the selected tile is a PlayerAvatar
                    // The point of this is to remove the last location
                    // and add to the selected one when a tile is tapped.
                    playerSelected = true;
                    _currentSelectedTile!.x = x;
                    _currentSelectedTile!.y = y;
                    _currentPlacedTiles.remove(_currentSelectedTile);
                    _currentPlacedTiles.add(_currentSelectedTile!);
                    _currentMap = generateMap();
                  }
                  setState(() {});
                }
              },
              child: Card(
                  elevation: 0,
                  color: switch (_editMode) {
                    1 => const Color.fromARGB(68, 76, 175, 79),
                    2 => const Color.fromARGB(68, 175, 101, 76),
                    _ => const Color.fromARGB(131, 114, 110, 110),
                  })),
        ));
      }
      rowChildren = Row(children: nodes);
      columnChildren.add(rowChildren);
    }
    // Every time the map is regenerated, check the tiles that have been placed,
    // and add them to the map before it's generated.
    for (TileAsset tile in _currentPlacedTiles) {
      Row row = columnChildren[tile.y];
      if (tile is PlayerAvatar) {
        row.children[tile.x] = SizedBox(
          width: 100,
          height: 100,
          child: Card(
            elevation: 0,
            // The tile under the player is slightly
            // darker to represent a shadow. This
            // also applies for tile assets.
            color: (_currentSelectedTile == tile) && (playerSelected)
              ? const Color.fromARGB(68, 76, 175, 79)
              : const Color.fromARGB(131, 97, 95, 95),
            child: GestureDetector(
              child: rebuildWithPopup(tile),
              onTap: () {
                if (_editMode != 2) {
                  switch (playerSelected) {
                    case true:
                      playerSelected = false;
                      if (_currentSelectedTile != tile) {
                        context.read<MapModel>().setTile(tile);
                        playerSelected = true;
                        setState(() {
                          _currentMap = generateMap();
                        });
                      } else {
                        context.read<MapModel>().setTile(null);
                      }
                      _currentSelectedTile = context.read<MapModel>().currentTile;
                      setState(() {
                        _currentMap = generateMap();
                      });
                    case false:
                      // Select the player if it's tapped on in-game
                      context.read<MapModel>().setTile(tile);
                      _currentSelectedTile =
                        context.read<MapModel>().currentTile;
                      playerSelected = true;
                      setState(() {
                        _currentMap = generateMap();
                      });
                  }
                } else {
                  // Remove if it's tapped in delete mode
                  _currentPlacedTiles.remove(tile);
                  playerSelected = false;
                  _currentSelectedTile = null;
                  setState(() {
                    _currentMap = generateMap();
                  });
                }
              }
            )
          )
        );
        columnChildren[tile.y] = row;
      } else {
        // Tile assets can fill in gaps between each other with the Container instead of SizedBox
        row.children[tile.x] = Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.all(0),
          width: 100,
          height: 100,
          color: const Color.fromARGB(131, 97, 95, 95),
          child: GestureDetector(
            child: tile.child,
            onTap: () {
              switch (_editMode) {
                case 2:
                  // Remove if it's tapped in delete mode
                  setState(() {
                    _currentPlacedTiles.remove(tile);
                    _currentMap = generateMap();
                  });
                default:
                  // Set selected tile variable if tapped
                  if (_currentSelectedTile != tile) {
                    if (tile.assetID == -1) {
                      playerSelected = false;
                    }
                    context.read<MapModel>().setTile(tile);
                  } else {
                    context.read<MapModel>().setTile(null);
                  }
                  _currentSelectedTile =
                      context.read<MapModel>().currentTile;
                  setState(() {
                    _currentMap = generateMap();
                  });
              }
            }
          )
        );
        columnChildren[tile.y] = row;
      }
    }
    print('Map state rebuilt');
    context.read<MapModel>().addMap(mapName);
    saveMap(mapName);
    return Column(children: columnChildren);
  }

  Widget generateMapMenu() {
    /* 1 = Edit Mode, 2 = Delete Mode, 3 = Pause Menu, default (0) = In-game map view */
    if (_editMode ==3) {
      _currentSelectedTile = null;
    }
    return switch (_editMode) {
      // Edit Mode //
      1 => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  // Exit Edit Mode button
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(10),
                  ),
                  onPressed: () {
                    setState(() => _editMode = 0);
                    _currentMap = generateMap();
                  },
                  child: const Icon(Icons.check, size: 40)
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Row(children: [
                  ElevatedButton(
                    // Add Tile button
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(10),
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: const Icon(Icons.add, size: 40)
                  ),
                  ElevatedButton(
                    // Delete Mode button
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(10),
                    ),
                    onPressed: () {
                      context.read<MapModel>().setTile(null);
                      _currentSelectedTile = null;
                      setState(() => _editMode = 2);
                      _currentMap = generateMap();
                    },
                    child: const Icon(Icons.delete_forever, size: 40)
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 9.0),
                    child: Text('Edit Mode',
                      style: Theme.of(context).textTheme.headlineMedium),
                  ),
                ])
              ),
            ],
          ),
        ),
      // Delete Mode //
      2 => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  // Exit Delete Mode Button
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(10),
                  ),
                  onPressed: () {
                    setState(() => _editMode = 1);
                    _currentMap = generateMap();
                  },
                  child: const Icon(Icons.check, size: 40)
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 12.0,
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text('Delete Mode',
                    style: Theme.of(context).textTheme.headlineMedium)
                )
              ),
            ],
          ),
        ),
      // Pause Menu //
      3 => Center(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
                color: Theme.of(context).canvasColor,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Game Paused',
                      style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height:10),
                    SizedBox(
                      width: 170,
                      child: FloatingActionButton.extended(
                        // Resume button
                        label: const Text('Resume'),
                        backgroundColor: Theme.of(context).focusColor,
                        onPressed: () {
                          setState(() {
                            _editMode = 0;
                            context.read<MapModel>().setTile(null);
                          });
                          _currentMap = generateMap();
                        },
                      ),
                    ),
                    const SizedBox(height:10),
                    SizedBox(
                      width: 170,
                      child: FloatingActionButton.extended(
                        // Exit Button
                        label: const Text('Exit Game'),
                        backgroundColor: Theme.of(context).focusColor,
                        onPressed: ()  {
                          setState(() {
                            _currentPlacedTiles = [];
                            _editMode = 3;
                            _mapPageIndex = 0;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      // In-game Mode //
      _ => Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                // Edit Mode button
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(10),
                ),
                onPressed: () {
                  setState(() => _editMode = 1);
                  _currentMap = generateMap();
                },
                child: const Icon(Icons.edit, size: 40)
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                // Edit Mode button
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(10),
                ),
                onPressed: () {
                  _currentSelectedTile = null;
                  context.read<MapModel>().setTile(null);
                  setState(() => _editMode = 3);
                },
                child: const Icon(Icons.menu, size: 40)
              ),
            ),
          ),
        ]
      )
    };
  }

  Future<Image> _getBadgeFromPlayerName(String name) async {
    int characterId = await DatabaseService.instance.getCharacterId(name);

    var dbService = DatabaseService.instance;
    final db = await dbService.database;
    final result = await db.rawQuery(
        "SELECT * FROM character WHERE character_id = ?", [characterId]);

    final characterData = result.first;

    String badgeStr = characterData['badge'].toString();
    return FileManager().loadImage(badgeStr);
  }
}
