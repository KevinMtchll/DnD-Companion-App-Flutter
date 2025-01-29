import 'package:flutter/material.dart';
import 'package:nbt_team17/defaults/app_defaults.dart';
import 'package:nbt_team17/map/map_assets.dart';
import 'package:nbt_team17/map/map_model.dart';
import 'package:nbt_team17/map/tile.dart';
import 'package:nbt_team17/services/database_service.dart';
import 'package:nbt_team17/services/file_manager.dart';
import 'package:provider/provider.dart';

class MapDrawer extends StatefulWidget {
  const MapDrawer({super.key, required this.dbService});
  final DatabaseService dbService;

  @override
  State<MapDrawer> createState() => _MapDrawerState();
}

class _MapDrawerState extends State<MapDrawer> {
  int drawerIndex = 0;

  Widget generateListTiles(int listIdx) {
    final mapModel = context.read<MapModel>();
    List<TileAsset> list = switch (listIdx) {
      3 => MapAssets().oneByOne,
      4 => MapAssets().wallCorners,
      5 => MapAssets().wallEdges,
      _ => MapAssets().junctions,
    };
    String headerText = switch (listIdx) {
      3 => '1x1 Tiles',
      4 => 'Corner Tiles',
      5 => 'Edge Tiles',
      _ => 'Junction Tiles',
    };
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: Align(
            alignment: Alignment.center,
            child: Text(headerText, style: AppDefaults.heading1Dark, textAlign: TextAlign.center),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: list.length + 1,
            itemBuilder: (context, index) {
              if (index == list.length) {
                return ListTile(
                  title: const Text('Back', style: AppDefaults.listItem), 
                  leading: Icon(Icons.arrow_back, color: Colors.white, size: AppDefaults.listItem.fontSize),
                  onTap: () {
                    setState(() {
                      drawerIndex = 0;
                    });
                  },
                );
              }
              return ListTile(
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('assets/${list[index].assetID}.png'),
                ),
                title: Text(
                  list[index].name,
                  style: AppDefaults.listItem,
                ),
                onTap: () {
                  mapModel.setTile(list[index]);
                  Navigator.pop(context);
                }
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final mapModel = context.read<MapModel>();
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: switch (drawerIndex) {
          1 || 2 => Column(
            children: [
              Container(
                color: Colors.white,
                child: Align(
                  alignment: Alignment.center,
                  child: drawerIndex == 1 
                  ? Text("Default Characters", style: AppDefaults.heading1Dark, textAlign: TextAlign.center)
                  : Text("Custom Characters", style: AppDefaults.heading1Dark, textAlign: TextAlign.center),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                    future: drawerIndex == 1 ? widget.dbService.getDefaultCharacters() : widget.dbService.getCustomCharacters(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator());
                      } else if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data!.length + 1,
                            itemBuilder: (context, index) {
                              if (index == snapshot.data!.length) {
                                return ListTile(
                                  title: const Text('Back', style: AppDefaults.listItem), 
                                  leading: Icon(Icons.arrow_back, color: Colors.white, size: AppDefaults.listItem.fontSize),
                                  onTap: () {
                                    setState(() {
                                      drawerIndex = 0;
                                    });
                                  },
                                );
                              }
                              return FutureBuilder(
                                  future: snapshot.data![index],
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator());
                                    } else if (snapshot.hasData) {
                                      return ListTile(
                                        title: 
                                          Text(snapshot.data!.name, style: AppDefaults.listItem),
                                          leading: Icon(
                                            Icons.shield,
                                            color: Colors.white,
                                            size: AppDefaults.listItem.fontSize
                                          ),
                                        onTap: () {
                                          mapModel.setTile(PlayerAvatar(
                                            name: 'Character',
                                            child: const Placeholder(),
                                          ));
                                          mapModel.setChild(
                                            Container(
                                              decoration:
                                                const BoxDecoration(
                                                  color: Colors.transparent,
                                                  shape: BoxShape.circle),
                                              child: Stack(
                                                children: [
                                                  ClipOval(
                                                    child: FutureBuilder(
                                                      future: _getBadgeFromPlayerName(snapshot.data!.name), 
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
                                                  Center(child: Text(
                                                    snapshot.data!.name, 
                                                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)
                                                  )),
                                                ],
                                              )
                                            )
                                          );
                                          mapModel.setName(snapshot.data!.name);
                                          Navigator.pop(context);
                                        },
                                      );
                                    } else {
                                      return const Text("Error occured");
                                    }
                                  }
                                );
                            });
                      } else {
                        return const Text("Error occured");
                      }
                    }
                  ),
              ),
              ],
          ),
          0 => Column(
            children: [
              Container(
                color: Colors.white,
                child: Align(
                  alignment: Alignment.center,
                  child: Text('Tile Categories', style: AppDefaults.heading1Dark, textAlign: TextAlign.center),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: MapAssets().tileAssets.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Center(
                          child: Text(
                            MapAssets().tileAssets[index],
                          style: AppDefaults.listItem,
                      )),
                      onTap: () {
                        drawerIndex = index + 1;
                        setState(() {});
                      }
                    );
                  },
                ),
              ),
            ],
          ),
          _ => generateListTiles(drawerIndex),
        }
      ),
    );
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
