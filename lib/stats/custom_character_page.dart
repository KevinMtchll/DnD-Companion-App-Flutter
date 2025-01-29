import 'package:flutter/material.dart';
import 'package:nbt_team17/defaults/app_defaults.dart';
import 'package:nbt_team17/services/character.dart';
import 'package:nbt_team17/services/database_service.dart';
import 'package:nbt_team17/services/file_manager.dart';
import 'package:nbt_team17/stats/add_character_page.dart';
import 'package:nbt_team17/stats/edit_character_page.dart';
import 'package:nbt_team17/stats/single_character_stats.dart';
import 'package:nbt_team17/stats/stats_model.dart';
import 'package:provider/provider.dart';

class CustomCharacterPage extends StatefulWidget {
  const CustomCharacterPage({super.key, required this.dbService});
  final DatabaseService dbService;

  @override
  State<CustomCharacterPage> createState() => _CustomCharacterPageState();
} 



class _CustomCharacterPageState extends State<CustomCharacterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom Characters", style: AppDefaults.titleDark),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: widget.dbService.getCustomCharacters(), 
              builder: (context,snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  // DEBUG: print("length: ${snapshot.data!.length}");
                  return snapshot.data!.isEmpty
                  ? const Text("No custom characters", style: AppDefaults.listItem)
                  : ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return FutureBuilder(
                        future: snapshot.data![index],  
                        builder: (context,snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasData) {
                            // Create individual character stat list
                            List<Text> singleCharacter = [];
                            Character c = snapshot.data!;
                            singleCharacter.add(Text(c.name, style: AppDefaults.listItem));
                            singleCharacter.add(Text(c.characterRace, style: AppDefaults.listItem));
                            singleCharacter.add(Text(c.characterClass, style: AppDefaults.listItem));
                            singleCharacter.add(Text("${c.level}", style: AppDefaults.listItem));
                            singleCharacter.add(Text(c.background, style: AppDefaults.listItem));
                            singleCharacter.add(Text(c.hp, style: AppDefaults.listItem));
                            singleCharacter.add(Text("${c.ac}", style: AppDefaults.listItem));
                            singleCharacter.add(Text("${c.speed}", style: AppDefaults.listItem));
                            singleCharacter.add(Text("${c.initiative}", style: AppDefaults.listItem));
                            singleCharacter.add(Text(c.strength, style: AppDefaults.listItem));
                            singleCharacter.add(Text(c.dexterity, style: AppDefaults.listItem));
                            singleCharacter.add(Text(c.constitution, style: AppDefaults.listItem));
                            singleCharacter.add(Text(c.intelligence, style: AppDefaults.listItem));
                            singleCharacter.add(Text(c.wisdom, style: AppDefaults.listItem));
                            singleCharacter.add(Text(c.charisma, style: AppDefaults.listItem));
                            singleCharacter.add(Text(c.weapon1.name, style: AppDefaults.listItem));
                            singleCharacter.add(Text(c.weapon1.attack, style: AppDefaults.listItem));
                            singleCharacter.add(Text(c.weapon1.damage, style: AppDefaults.listItem));
                            singleCharacter.add(Text(c.weapon1.type, style: AppDefaults.listItem));
                            singleCharacter.add(Text(c.weapon2.name, style: AppDefaults.listItem));
                            singleCharacter.add(Text(c.weapon2.attack, style: AppDefaults.listItem));
                            singleCharacter.add(Text(c.weapon2.damage, style: AppDefaults.listItem));
                            singleCharacter.add(Text(c.weapon2.type, style: AppDefaults.listItem));

                            // return ListTile that includes:
                            // (1) leading :: badge 
                            // (2) transition to single character stats page
                            // (3) trailing :: Row(edit button, delete button)
                            return ListTile(
                              title: Hero(
                                tag: "hero-transition${index.toString()}", 
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(padding: const EdgeInsets.all(10),
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
                                            )),
                                        Padding(padding: const EdgeInsets.all(10),
                                                child: Text(snapshot.data!.name, style: AppDefaults.listItem))
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: ElevatedButton.icon(
                                            onPressed: () {
                                              final provider = Provider.of<StatsModel>(context, listen: false);
                                              provider.updateCharacterName(snapshot.data!.name);
                                              provider.updateRaceName(snapshot.data!.characterRace);
                                              provider.updateClassName(snapshot.data!.characterClass);
                                              provider.updateLevel(snapshot.data!.level);
                                              provider.updateBackgroundText(snapshot.data!.background);
                                              provider.updateHP(snapshot.data!.getHPValues());
                                              provider.updateAC(snapshot.data!.ac);
                                              provider.updateSpeed(snapshot.data!.speed);
                                              provider.updateInitiative(snapshot.data!.initiative);
                                              provider.updateMainStrength(snapshot.data!.getMainStrength());
                                              provider.updateAddStrength(snapshot.data!.getAddStrength());
                                              provider.updateMainDexterity(snapshot.data!.getMainDexterity());
                                              provider.updateAddDexterity(snapshot.data!.getAddDexterity());
                                              provider.updateMainConstitution(snapshot.data!.getMainConstitution());
                                              provider.updateAddConstitution(snapshot.data!.getAddConstitution());
                                              provider.updateMainIntelligence(snapshot.data!.getMainIntelligence());
                                              provider.updateAddIntelligence(snapshot.data!.getAddIntelligence());
                                              provider.updateMainWisdom(snapshot.data!.getMainWisdom());
                                              provider.updateAddWisdom(snapshot.data!.getAddWisdom());
                                              provider.updateMainCharisma(snapshot.data!.getMainCharisma());
                                              provider.updateAddCharisma(snapshot.data!.getAddCharisma());

                                              provider.updateWeapon1Name(snapshot.data!.weapon1.name);
                                              provider.updateWeapon1Attack(snapshot.data!.getWeapon1Attack());
                                              provider.updateWeapon1DamageDice(snapshot.data!.getWeapon1DamageDice());
                                              provider.updateWeapon1Damage(snapshot.data!.getWeapon1Damage());
                                              provider.updateWeapon1DType(snapshot.data!.weapon1.type);

                                              provider.updateWeapon2Name(snapshot.data!.weapon2.name);
                                              provider.updateWeapon2Attack(snapshot.data!.getWeapon2Attack());
                                              provider.updateWeapon2DamageDice(snapshot.data!.getWeapon2DamageDice());
                                              provider.updateWeapon2Damage(snapshot.data!.getWeapon2Damage());
                                              provider.updateWeapon2DType(snapshot.data!.weapon2.type);

                                              provider.updateBadge(snapshot.data!.badge);

                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return EditCharacterPage(dbService: widget.dbService, formerCharacter: snapshot.data!);
                                                  }
                                                )
                                              );
                                            }, 
                                            label: const Icon(Icons.edit, color: Colors.white)
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: ElevatedButton.icon(
                                            onPressed: () async {
                                              showDialog(
                                                context: context, 
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: const Text('Delete Character?'),
                                                    content: Text('Do you want to delete ${snapshot.data!.name} from this list?'),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () async {
                                                          widget.dbService.deleteCharacter(snapshot.data!.name);
                                                          Navigator.of(context)..pop()..pop();
                                                        }, 
                                                        child: const Text('Yes')
                                                      ),
                                                      TextButton(onPressed: () => Navigator.pop(context, 'No'), child: const Text('No')),
                                                    ],
                                                  );    
                                                }
                                              );
                                            }, 
                                            label: const Icon(Icons.delete, color: Colors.white)
                                          ),
                                        )
                                      ]
                                    )
                                  ]
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context, 
                                  MaterialPageRoute(
                                    builder: (context) {    
                                      return SingleCharacterStats(
                                        name: snapshot.data!.name, 
                                        attributes: singleCharacter,
                                        badge: snapshot.data!.badge
                                      );
                                    }
                                  )
                                );
                              },
                            );
                          } else {
                            return const Text("Error occured");
                          }
                        }
                      );
                    }
                  );
                } else {
                  return const Text("Error occured");
                }
              }
            )
          ),
          Padding(
             padding: const EdgeInsets.all(8.0),
             child: Card(
              child: ListTile( 
                onTap: () {
                  final provider = Provider.of<StatsModel>(context, listen: false);
                  provider.updateCharacterName('[no name specified]');
                  provider.updateRaceName('[no race specified]');
                  provider.updateClassName('[no class specified]');
                  provider.updateLevel(0);
                  provider.updateBackgroundText('[no background specified]');
                  provider.updateHP(const RangeValues(0, 100));
                  provider.updateAC(0);
                  provider.updateSpeed(0);
                  provider.updateInitiative(0);
                  provider.updateMainStrength(5);
                  provider.updateAddStrength(0);
                  provider.updateMainDexterity(5);
                  provider.updateAddDexterity(0);
                  provider.updateMainConstitution(5);
                  provider.updateAddConstitution(0);
                  provider.updateMainIntelligence(5);
                  provider.updateAddIntelligence(0);
                  provider.updateMainWisdom(5);
                  provider.updateAddWisdom(0);
                  provider.updateMainCharisma(5);
                  provider.updateAddCharisma(0);

                  provider.updateWeapon1Name('[null]');
                  provider.updateWeapon1Attack(0);
                  provider.updateWeapon1DamageDice('[null]');
                  provider.updateWeapon1Damage(0);
                  provider.updateWeapon1DType('[null]');

                  provider.updateWeapon2Name('[null]');
                  provider.updateWeapon2Attack(0);
                  provider.updateWeapon2DamageDice('[null]');
                  provider.updateWeapon2Damage(0);
                  provider.updateWeapon2DType('[null]');

                  provider.updateBadge('[null]');
                  
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return AddCharacterPage(dbService: widget.dbService);
                      }
                    )
                  );
                }, 
                title: const Text("Add Character"),
                leading: const Icon(Icons.person_add_alt_1_sharp),
              ),
            ),
          )
        ],
      ),
    );
  }
}
