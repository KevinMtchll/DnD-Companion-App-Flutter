// character_stats_popup.dart
import 'package:flutter/material.dart';
import 'package:nbt_team17/defaults/app_defaults.dart';
import 'package:nbt_team17/services/database_service.dart';

// character_stats_popup.dart
// import 'package:flutter/material.dart';
// import 'package:nbt_team17/defaults/app_defaults.dart';
// import 'package:nbt_team17/services/database_service.dart';

class CharacterStatsPopup extends StatelessWidget {
  final String characterName;
  final DatabaseService dbService;
  final VoidCallback onClose;

  const CharacterStatsPopup({
    super.key,
    required this.characterName,
    required this.dbService,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 425),
      color: Theme.of(context).cardColor.withOpacity(0.9),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<int>(
          future: dbService.getCharacterId(characterName),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData && snapshot.data! != -1) {
              final characterId = snapshot.data!;
              return FutureBuilder<Map<String, dynamic>>(
                future: _getCharacterInfo(characterId),
                builder: (context, infoSnapshot) {
                  if (infoSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (infoSnapshot.hasData) {
                    final info = infoSnapshot.data!;
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: Colors.white,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Text(characterName, style: AppDefaults.heading1Dark)),
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  icon: const Icon(Icons.close, color: Colors.black, size: 30),
                                  onPressed: onClose,
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 25),
                                    Text('Lvl.${info['level']} ${info['race']} ${info['class']}',
                                      style: TextStyle(color: ThemeData.dark().canvasColor, fontSize: 15, fontWeight: FontWeight.bold,))
                                  ],
                                )
                              )
                            ]
                          )
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                const Text('HP', style: AppDefaults.listItem),
                                Text('${info['hp']}')
                              ],
                            ),
                            Column(
                              children: [
                                const Text('AC', style: AppDefaults.listItem),
                                Text('${info['ac']}')
                              ],
                            ),
                            Column(
                              children: [
                                const Text('Speed', style: AppDefaults.listItem),
                                Text('${info['speed']}')
                              ],
                            ),
                            Column(
                              children: [
                                const Text('Init', style: AppDefaults.listItem),
                                Text('${info['initiative']}')
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                const Text('Strength', style: AppDefaults.listItem),
                                Text('${info['strength']}')
                              ],
                            ),
                            Column(
                              children: [
                                const Text('Dexterity', style: AppDefaults.listItem),
                                Text('${info['dexterity']}')
                              ],
                            ),
                            Column(
                              children: [
                                const Text('Constitution', style: AppDefaults.listItem),
                                Text('${info['constitution']}')
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                const Text('Intelligence', style: AppDefaults.listItem),
                                Text('${info['intelligence']}')
                              ],
                            ),
                            Column(
                              children: [
                                const Text('Wisdom', style: AppDefaults.listItem),
                                Text('${info['wisdom']}')
                              ],
                            ),
                            Column(
                              children: [
                                const Text('Charisma', style: AppDefaults.listItem),
                                Text('${info['charisma']}')
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                const Text('Weapon 1', style: AppDefaults.listItem),
                                Text('${info['weapon1']}')
                              ],
                            ),
                            Column(
                              children: [
                                const Text('Weapon 2', style: AppDefaults.listItem),
                                Text('${info['weapon2']}')
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return const Text("Error loading character info");
                  }
                },
              );
            } else {
              return const Text("Character not found");
            }
          },
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> _getCharacterInfo(int characterId) async {
    final db = await dbService.database;
    final result = await db.rawQuery(
        "SELECT * FROM character WHERE character_id = ?", [characterId]);

    if (result.isEmpty) return {};

    final characterData = result.first;

    // Get race and class names using their IDs
    final race = await dbService.getRace(characterData['race_id'] as int);
    final characterClass =
        await dbService.getClass(characterData['class_id'] as int);

    // Get weapon names
    final weapon1 =
        await dbService.getWeapon(characterData['weapon1_id'] as int);
    final weapon2 =
        await dbService.getWeapon(characterData['weapon2_id'] as int);

    return {
      'race': race,
      'class': characterClass,
      'level': characterData['level'].toString(),
      'hp': characterData['hp'].toString(),
      'ac': characterData['ac'].toString(),
      'speed': characterData['speed'].toString(),
      'initiative': characterData['initiative'].toString(),
      'strength': characterData['strength'].toString(),
      'dexterity': characterData['dexterity'].toString(),
      'constitution': characterData['constitution'].toString(),
      'intelligence': characterData['intelligence'].toString(),
      'wisdom': characterData['wisdom'].toString(),
      'charisma': characterData['charisma'].toString(),
      'weapon1': weapon1.name,
      'weapon2': weapon2.name,
    };
  }
}

// Widget _buildStatBox(String label, String value) {
//   return Column(
//     children: [
//       Text(label, style: AppDefaults.listItem),
//       Text(value, style: AppDefaults.listItem),
//     ],
//   );
// }
