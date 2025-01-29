import 'package:flutter/material.dart';
import 'package:nbt_team17/defaults/app_defaults.dart';
import 'package:nbt_team17/services/character.dart';
import 'package:nbt_team17/services/database_service.dart';
import 'package:nbt_team17/services/file_manager.dart';
import 'package:nbt_team17/stats/custom_character_page.dart';
import 'package:nbt_team17/stats/single_character_stats.dart';

class Stats extends StatefulWidget {
  const Stats({super.key, required this.dbService});
  final DatabaseService dbService;

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: FutureBuilder(
                future: widget.dbService.getDefaultCharacters(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    return Column(
                      children: [
                        Container(
                          color: Colors.white,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Character Stats", style: AppDefaults.heading1Dark, textAlign: TextAlign.center),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return FutureBuilder(
                                future: snapshot.data![index],
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.hasData) {
                                    return ListTile(
                                      title: Hero(
                                        tag: "hero-transition${index.toString()}",
                                        child: Row(children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: FutureBuilder(
                                              future: FileManager().loadImage(snapshot.data!.badge), 
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState == ConnectionState.waiting) {
                                                  return const Center(child: CircularProgressIndicator());
                                                } else if (snapshot.hasData) {
                                                  double? fSize = AppDefaults.listItem.fontSize;
                                                  return ClipRRect(
                                                    borderRadius: BorderRadius.circular(3),
                                                    child: SizedBox(width: fSize, height: fSize, child: snapshot.data)
                                                  );
                                                } else {
                                                  return const Text('ERR');
                                                }
                                              }
                                            ),
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text(snapshot.data!.name,
                                                  style: AppDefaults.listItem))
                                        ]),
                                      ),
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context) {
                                          List<Text> singleCharacter = [];
                                          Character c = snapshot.data!;
                                          singleCharacter.add(Text(c.name,
                                              style: AppDefaults.listItem));
                                          singleCharacter.add(Text(
                                              c.characterRace,
                                              style: AppDefaults.listItem));
                                          singleCharacter.add(Text(
                                              c.characterClass,
                                              style: AppDefaults.listItem));
                                          singleCharacter.add(Text("${c.level}",
                                              style: AppDefaults.listItem));
                                          singleCharacter.add(Text(c.background,
                                              style: AppDefaults.listItem));
                                          singleCharacter.add(Text(c.hp,
                                              style: AppDefaults.listItem));
                                          singleCharacter.add(Text("${c.ac}",
                                              style: AppDefaults.listItem));
                                          singleCharacter.add(Text("${c.speed}",
                                              style: AppDefaults.listItem));
                                          singleCharacter.add(Text(
                                              "${c.initiative}",
                                              style: AppDefaults.listItem));
                                          singleCharacter.add(Text(c.strength,
                                              style: AppDefaults.listItem));
                                          singleCharacter.add(Text(c.dexterity,
                                              style: AppDefaults.listItem));
                                          singleCharacter.add(Text(c.constitution,
                                              style: AppDefaults.listItem));
                                          singleCharacter.add(Text(
                                              c.intelligence,
                                              style: AppDefaults.listItem));
                                          singleCharacter.add(Text(c.wisdom,
                                              style: AppDefaults.listItem));
                                          singleCharacter.add(Text(c.charisma,
                                              style: AppDefaults.listItem));
                                          singleCharacter.add(Text(c.weapon1.name,
                                              style: AppDefaults.listItem));
                                          singleCharacter.add(Text(
                                              c.weapon1.attack,
                                              style: AppDefaults.listItem));
                                          singleCharacter.add(Text(
                                              c.weapon1.damage,
                                              style: AppDefaults.listItem));
                                          singleCharacter.add(Text(c.weapon1.type,
                                              style: AppDefaults.listItem));
                                          singleCharacter.add(Text(c.weapon2.name,
                                              style: AppDefaults.listItem));
                                          singleCharacter.add(Text(
                                              c.weapon2.attack,
                                              style: AppDefaults.listItem));
                                          singleCharacter.add(Text(
                                              c.weapon2.damage,
                                              style: AppDefaults.listItem));
                                          singleCharacter.add(Text(c.weapon2.type,
                                              style: AppDefaults.listItem));
                                          return SingleCharacterStats(
                                              name: snapshot.data!.name,
                                              attributes: singleCharacter,
                                              badge: snapshot.data!.badge);
                                        }));
                                      },
                                    );
                                  } else {
                                    return const Text("Error occured");
                                  }
                                });
                          }),
                        )
                      ],
                    );
                  } else {
                    return const Text("Error occured");
                  }
                })),
        Container(
            color: Colors.white,
            child: Align(
              alignment: Alignment.centerLeft,
              child: ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return CustomCharacterPage(dbService: widget.dbService);
                    }));
                  },
                  title: Text("Custom Characters",
                      style: AppDefaults.listItemDark)),
            ))
      ],
    );
  }
}
