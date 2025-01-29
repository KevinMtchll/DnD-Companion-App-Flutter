import 'package:flutter/material.dart';
import 'package:nbt_team17/defaults/app_defaults.dart';
import 'package:nbt_team17/services/file_manager.dart';

class SingleCharacterStats extends StatelessWidget {
  const SingleCharacterStats({super.key, required this.name, required this.attributes, required this.badge});
  final String name;
  final List<Text> attributes;
  final String badge;

  @override
  Widget build(BuildContext context) {
    Text emptyText = const Text("");

    return Scaffold(
      appBar: AppBar(
        title: Text(name, style: AppDefaults.titleDark),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Align(
                  alignment: Alignment.center,
                  child: Text("Stats", style: AppDefaults.heading1Dark, textAlign: TextAlign.center)
                )),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Name:", style: AppDefaults.listItem),
                                  const Text("Race:", style: AppDefaults.listItem),
                                  const Text("Class:", style: AppDefaults.listItem),
                                  const Text("Level:", style: AppDefaults.listItem),
                                  const Text("Background:", style: AppDefaults.listItem),
                                  emptyText,
                                  const Text("HP:", style: AppDefaults.listItem),
                                  const Text("AC:", style: AppDefaults.listItem),
                                  const Text("Speed:", style: AppDefaults.listItem),
                                  const Text("Initiative:", style: AppDefaults.listItem),
                                  emptyText,
                                  const Text("Strength:", style: AppDefaults.listItem),
                                  const Text("Dexterity:", style: AppDefaults.listItem),
                                  const Text("Constitution:", style: AppDefaults.listItem),
                                  const Text("Intelligence:", style: AppDefaults.listItem),
                                  const Text("Wisdom:", style: AppDefaults.listItem),
                                  const Text("Charisma:", style: AppDefaults.listItem),
                                  emptyText,
                                  const Text("Weapon:", style: AppDefaults.listItem),
                                  const Text("Attack:", style: AppDefaults.listItem),
                                  const Text("Damage:", style: AppDefaults.listItem),
                                  const Text("Damage Type:", style: AppDefaults.listItem),
                                  emptyText,
                                  const Text("Weapon:", style: AppDefaults.listItem),
                                  const Text("Attack:", style: AppDefaults.listItem),
                                  const Text("Damage:", style: AppDefaults.listItem),
                                  const Text("Damage Type:", style: AppDefaults.listItem),
                                ],
                              )
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  attributes[0],
                                  attributes[1],
                                  attributes[2],
                                  attributes[3],
                                  attributes[4],
                                  emptyText,
                                  attributes[5],
                                  attributes[6],
                                  attributes[7],
                                  attributes[8],
                                  emptyText,
                                  attributes[9],
                                  attributes[10],
                                  attributes[11],
                                  attributes[12],
                                  attributes[13],
                                  attributes[14],
                                  emptyText,
                                  attributes[15],
                                  attributes[16],
                                  attributes[17],
                                  attributes[18],
                                  emptyText,
                                  attributes[19],
                                  attributes[20],
                                  attributes[21],
                                  attributes[22],
                                ]
                              )
                            )
                          ],
                        ),
                        const Padding(padding: EdgeInsets.all(10)),
                        Container(
                        color: Colors.white,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Badge", style: AppDefaults.heading1Dark, textAlign: TextAlign.center)
                        )),
                        Padding(
                          padding: const EdgeInsets.all(15.0), 
                          child: FutureBuilder(
                            future: FileManager().loadImage(badge), 
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(child: CircularProgressIndicator());
                              } else if (snapshot.hasData) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: SizedBox(width: 150, height: 150, child: snapshot.data)
                                );
                              } else {
                                return const Text('ERR');
                              }
                            }
                          )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}