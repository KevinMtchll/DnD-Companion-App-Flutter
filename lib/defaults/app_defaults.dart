import 'dart:math';
import 'package:flutter/material.dart';

class AppDefaults {
  static Random random = Random();
  
  // TEXT
  static const listItem = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold
  );

  static TextStyle listItemDark = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: ThemeData.dark().canvasColor
  );

  static TextStyle heading1Dark = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: ThemeData.dark().canvasColor
  );

  static const TextStyle titleDark = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white
  );

  static const TextStyle italicSmall = TextStyle(
    fontSize: 12,
    fontStyle: FontStyle.italic,
    color: Colors.white
  );

  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% DATABASE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  // DEFAULT WEAPONS
  static List<String> greatsword = ["Greatsword", "+5", "2d6 + 2", "Slashing"];
  static List<String> javelin = ["Javelin", "+5", "1d6 + 2", "Piercing"];
  static List<String> iceStaff = ["Ice Staff", "+6", "1d10 + 4", "Freezing"];
  static List<String> frostDagger = ["Frost Dagger", "+5", "1d4 + 2", "Piercing"]; // later: implement multiple damage types [ex. cold & piercing]
  static List<String> warhammer = ["Warhammer", "+7", "1d10 + 4", "Bludgeoning"];
  static List<String> handAxe = ["Hand Axe", "+6", "1d6 + 4", "Slashing"];
  static List<String> rapier = ["Rapier", "+7", "1d8 + 4", "Piercing"];
  static List<String> poisonShortbow = ["Poison Shortbow", "+5", "1d6 + 4", "Poison"];

  // DEFAULT CHARACTERS
  static List<String> defaultPlayer1 = [
    "Adventurer", "Dragonborn", "Paladin", "8", "Haunted One",
    "60/80", "18", "30", "0",
    "14(+2)", "10(+0)", "16(+3)", "10(+0)", "12(+1)", "18(+4)",
    "Greatsword", "Javelin",
    "1"
  ];

  static List<String> defaultPlayer2 = [
    "Frostbite", "Tiefling", "Sorcerer", "8", "The Chill",
    "48/65", "14", "30", "2",
    "8(+1)", "14(+2)", "12(+1)", "10(+0)", "10(+0)", "18(+4)",
    "Ice Staff", "Frost Dagger",
    "1"
  ];

  static List<String> defaultPlayer3 = [
    "Steelheart", "Dwarf", "Fighter", "8", "The Immovable",
    "75/95", "19", "25", "1",
    "18(+4)", "12(+1)", "18(+4)", "10(+0)", "10(+0)", "8(+0)",
    "Warhammer", "Hand Axe",
    "1"
  ];

  static List<String> defaultPlayer4 = [
    "ShadowStep", "Half-Elf", "Rogue", "8", "The Phantom",
    "50/70", "16", "35", "4",
    "10(+0)", "18(+4)", "14(+2)", "12(+1)", "14(+2)", "14(+2)",
    "Rapier", "Poison Shortbow",
    "1"
  ];

  // DEFAULT IDS
  static List<int> characterID = [1001,1002,1003,1004];
  static List<int> raceID = [1011,1012,1013,1014];
  static List<int> classID = [1021,1022,1023,1024];
  static List<int> weapon1ID = [1031,1032,1033,1034];
  static List<int> weapon2ID = [1041,1042,1043,1044];
  
  // 1131: Slashing, 1132: Piercing, 1133: Freezing, 1134: Bludgeoining, 1135: Poison
  static List<int> damageTypeID = [1131,1132,1133,1134,1135]; 

  // BADGES
  static List<String> badges = [
    "shield-1", "shield-3", "shield-3", "shield-4", "shield-default"
  ];

  // %%%%%%%%%%%%%%%%%%% INITIALIZATION MACROS %%%%%%%%%%%%%%%%%%%%%
  // Tables
  static const int _default = 1;
  
  // CHARACTER
  static const String _characterDataTable = "character";
  static const String _characterIdCol = "character_id";
  static const String _characterNameCol = "character_name";
  static const String _characterRaceCol = "race_id";
  static const String _characterClassCol = "class_id";
  static const String _characterLevelCol = "level";
  static const String _characterBackgroundCol = "background";
  static const String _characterHPCol = "hp";
  static const String _characterACCol = "ac";
  static const String _characterSpeedCol = "speed";
  static const String _characterInitiativeCol = "initiative";
  static const String _characterStrengthCol = "strength";
  static const String _characterDexterityCol = "dexterity";
  static const String _characterConstitutionCol = "constitution";
  static const String _characterIntelligenceCol = "intelligence";
  static const String _characterWisdomCol = "wisdom"; 
  static const String _characterCharismaCol = "charisma";
  static const String _characterWeapon1Col = "weapon1_id";
  static const String _characterWeapon2Col = "weapon2_id";
  static const String _characterDefaultCol = "is_default";
  static const String _characterBadgeCol = "badge";

  // RACE
  static const String _raceDataTable = "race";
  static const String _raceIdCol = "race_id";
  static const String _raceNameCol = "race_name";

  // CLASS
  static const String _classDataTable = "character_class";
  static const String _classIdCol = "character_class_id";
  static const String _classNameCol = "character_class_name";

  // WEAPON
  static const String _weaponDataTable = "weapon";
  static const String _weaponIdCol = "weapon_id";
  static const String _weaponNameCol = "weapon_name";
  static const String _weaponAttackCol = "attack";
  static const String _weaponDamageCol = "damage";
  static const String _weaponDamageTypeCol = "damage_type_id";

  // DAMAGE TYPE
  static const String _damageTypeDataTable = "damage_type";
  static const String _damageTypeIdCol = "damage_type_id";
  static const String _damageTypeNameCol = "damage_type_name";

  // SQL
  static String createRaceTable =
          '''
          CREATE TABLE $_raceDataTable (
            $_raceIdCol INTEGER PRIMARY KEY,
            $_raceNameCol STRING NOT NULL
          );
          ''';
  
  static String createClassTable = 
          '''
          CREATE TABLE $_classDataTable (
            $_classIdCol INTEGER PRIMARY KEY,
            $_classNameCol STRING NOT NULL
          );
          ''';
  
  static String createDamageTypeTable = 
          '''
          CREATE TABLE $_damageTypeDataTable (
            $_damageTypeIdCol INTEGER PRIMARY KEY,
            $_damageTypeNameCol STRING NOT NULL
          );
          ''';

  static String createWeaponTable = 
          '''
          CREATE TABLE $_weaponDataTable (
            $_weaponIdCol INTEGER PRIMARY KEY,
            $_weaponNameCol STRING NOT NULL,
            $_weaponAttackCol STRING,
            $_weaponDamageCol STRING,
            $_weaponDamageTypeCol INTEGER,
            FOREIGN KEY($_weaponDamageTypeCol) REFERENCES $_damageTypeDataTable($_damageTypeIdCol)
          );
          ''';
  
  static String createCharacterTable = 
          '''
          CREATE TABLE $_characterDataTable (
            $_characterIdCol INTEGER PRIMARY KEY,
            $_characterNameCol STRING NOT NULL,
            $_characterRaceCol INTEGER,
            $_characterClassCol INTEGER,            
            $_characterLevelCol INTEGER,
            $_characterBackgroundCol STRING,
            $_characterHPCol STRING,
            $_characterACCol INTEGER,
            $_characterSpeedCol INTEGER,
            $_characterInitiativeCol INTEGER,
            $_characterStrengthCol STRING,
            $_characterDexterityCol STRING,
            $_characterConstitutionCol STRING,
            $_characterIntelligenceCol STRING,
            $_characterWisdomCol STRING,
            $_characterCharismaCol STRING,
            $_characterWeapon1Col INTEGER,
            $_characterWeapon2Col INTEGER,
            $_characterDefaultCol INTEGER,
            $_characterBadgeCol STRING,
            FOREIGN KEY($_characterRaceCol) REFERENCES $_raceDataTable($_raceIdCol),
            FOREIGN KEY($_characterClassCol) REFERENCES $_classDataTable($_classIdCol),
            FOREIGN KEY($_characterWeapon1Col) REFERENCES $_weaponDataTable($_weaponIdCol),
            FOREIGN KEY($_characterWeapon2Col) REFERENCES $_weaponDataTable($_weaponIdCol)
          );
          ''';
  
  static List<String> insertRaces = [
    "INSERT INTO $_raceDataTable($_raceIdCol,$_raceNameCol) VALUES(${raceID[0]},'${defaultPlayer1[1]}');",
    "INSERT INTO $_raceDataTable($_raceIdCol,$_raceNameCol) VALUES(${raceID[1]},'${defaultPlayer2[1]}');",
    "INSERT INTO $_raceDataTable($_raceIdCol,$_raceNameCol) VALUES(${raceID[2]},'${defaultPlayer3[1]}');",
    "INSERT INTO $_raceDataTable($_raceIdCol,$_raceNameCol) VALUES(${raceID[3]},'${defaultPlayer4[1]}');"
  ];

  static List<String> insertClasses = [
    "INSERT INTO $_classDataTable($_classIdCol,$_classNameCol) VALUES(${classID[0]},'${defaultPlayer1[2]}');",
    "INSERT INTO $_classDataTable($_classIdCol,$_classNameCol) VALUES(${classID[1]},'${defaultPlayer2[2]}');",
    "INSERT INTO $_classDataTable($_classIdCol,$_classNameCol) VALUES(${classID[2]},'${defaultPlayer3[2]}');",
    "INSERT INTO $_classDataTable($_classIdCol,$_classNameCol) VALUES(${classID[3]},'${defaultPlayer4[2]}');"
  ];

  static List<String> insertDamageTypes = [
    "INSERT INTO $_damageTypeDataTable($_damageTypeIdCol,$_damageTypeNameCol) VALUES(${damageTypeID[0]},'${greatsword[3]}');",
    "INSERT INTO $_damageTypeDataTable($_damageTypeIdCol,$_damageTypeNameCol) VALUES(${damageTypeID[1]},'${javelin[3]}');",
    "INSERT INTO $_damageTypeDataTable($_damageTypeIdCol,$_damageTypeNameCol) VALUES(${damageTypeID[2]},'${iceStaff[3]}');",
    "INSERT INTO $_damageTypeDataTable($_damageTypeIdCol,$_damageTypeNameCol) VALUES(${damageTypeID[3]},'${warhammer[3]}');",
    "INSERT INTO $_damageTypeDataTable($_damageTypeIdCol,$_damageTypeNameCol) VALUES(${damageTypeID[4]},'${poisonShortbow[3]}');"
  ];

  static List<String> insertWeapon1s = [
          '''
          INSERT INTO $_weaponDataTable($_weaponIdCol,$_weaponNameCol,$_weaponAttackCol,$_weaponDamageCol,$_weaponDamageTypeCol) 
          VALUES(${weapon1ID[0]},'${greatsword[0]}','${greatsword[1]}','${greatsword[2]}',${damageTypeID[0]});
          ''',
          '''
          INSERT INTO $_weaponDataTable($_weaponIdCol,$_weaponNameCol,$_weaponAttackCol,$_weaponDamageCol,$_weaponDamageTypeCol) 
          VALUES(${weapon1ID[1]},'${iceStaff[0]}','${iceStaff[1]}','${iceStaff[2]}',${damageTypeID[2]});
          ''',
          '''
          INSERT INTO $_weaponDataTable($_weaponIdCol,$_weaponNameCol,$_weaponAttackCol,$_weaponDamageCol,$_weaponDamageTypeCol) 
          VALUES(${weapon1ID[2]},'${warhammer[0]}','${warhammer[1]}','${warhammer[2]}',${damageTypeID[3]});
          ''',
          '''
          INSERT INTO $_weaponDataTable($_weaponIdCol,$_weaponNameCol,$_weaponAttackCol,$_weaponDamageCol,$_weaponDamageTypeCol) 
          VALUES(${weapon1ID[3]},'${rapier[0]}','${rapier[1]}','${rapier[2]}',${damageTypeID[1]});
          '''
  ];

  static List<String> insertWeapon2s = [
          '''
          INSERT INTO $_weaponDataTable($_weaponIdCol,$_weaponNameCol,$_weaponAttackCol,$_weaponDamageCol,$_weaponDamageTypeCol) 
          VALUES(${weapon2ID[0]},'${javelin[0]}','${javelin[1]}','${javelin[2]}',${damageTypeID[1]});
          ''',
          '''
          INSERT INTO $_weaponDataTable($_weaponIdCol,$_weaponNameCol,$_weaponAttackCol,$_weaponDamageCol,$_weaponDamageTypeCol) 
          VALUES(${weapon2ID[1]},'${frostDagger[0]}','${frostDagger[1]}','${frostDagger[2]}',${damageTypeID[1]});
          ''',
          '''
          INSERT INTO $_weaponDataTable($_weaponIdCol,$_weaponNameCol,$_weaponAttackCol,$_weaponDamageCol,$_weaponDamageTypeCol) 
          VALUES(${weapon2ID[2]},'${handAxe[0]}','${handAxe[1]}','${handAxe[2]}',${damageTypeID[0]});
          ''',
          '''
          INSERT INTO $_weaponDataTable($_weaponIdCol,$_weaponNameCol,$_weaponAttackCol,$_weaponDamageCol,$_weaponDamageTypeCol) 
          VALUES(${weapon2ID[3]},'${poisonShortbow[0]}','${poisonShortbow[1]}','${poisonShortbow[2]}',${damageTypeID[4]});
          '''
  ];

  static List<String> insertCharacters = [
          '''
          INSERT INTO $_characterDataTable($_characterIdCol,$_characterNameCol,$_characterRaceCol,$_characterClassCol,            
            $_characterLevelCol,$_characterBackgroundCol,$_characterHPCol,$_characterACCol,$_characterSpeedCol,$_characterInitiativeCol,
            $_characterStrengthCol,$_characterDexterityCol,$_characterConstitutionCol,$_characterIntelligenceCol,$_characterWisdomCol,
            $_characterCharismaCol,$_characterWeapon1Col,$_characterWeapon2Col,$_characterDefaultCol,$_characterBadgeCol) 
          
          VALUES(
            ${characterID[0]},'${defaultPlayer1[0]}',${raceID[0]},${classID[0]},${int.parse(defaultPlayer1[3])},
            '${defaultPlayer1[4]}','${defaultPlayer1[5]}',
            ${int.parse(defaultPlayer1[6])},${int.parse(defaultPlayer1[7])},
            ${int.parse(defaultPlayer1[8])},'${defaultPlayer1[9]}',
            '${defaultPlayer1[10]}','${defaultPlayer1[11]}',
            '${defaultPlayer1[12]}','${defaultPlayer1[13]}',
            '${defaultPlayer1[14]}',${weapon1ID[0]},${weapon2ID[0]},$_default,'${badges[0]}');
          ''',
          '''
          INSERT INTO $_characterDataTable($_characterIdCol,$_characterNameCol,$_characterRaceCol,$_characterClassCol,            
            $_characterLevelCol,$_characterBackgroundCol,$_characterHPCol,$_characterACCol,$_characterSpeedCol,$_characterInitiativeCol,
            $_characterStrengthCol,$_characterDexterityCol,$_characterConstitutionCol,$_characterIntelligenceCol,$_characterWisdomCol,
            $_characterCharismaCol,$_characterWeapon1Col,$_characterWeapon2Col,$_characterDefaultCol,$_characterBadgeCol) 
          
          VALUES(
            ${characterID[1]},'${defaultPlayer2[0]}',${raceID[1]},${classID[1]},${int.parse(defaultPlayer2[3])},
            '${defaultPlayer2[4]}','${defaultPlayer2[5]}',
            ${int.parse(defaultPlayer2[6])},${int.parse(defaultPlayer2[7])},
            ${int.parse(defaultPlayer2[8])},'${defaultPlayer2[9]}',
            '${defaultPlayer2[10]}','${defaultPlayer2[11]}',
            '${defaultPlayer2[12]}','${defaultPlayer2[13]}',
            '${defaultPlayer2[14]}',${weapon1ID[1]},${weapon2ID[1]},$_default,'${badges[1]}');
          ''',
          '''
          INSERT INTO $_characterDataTable($_characterIdCol,$_characterNameCol,$_characterRaceCol,$_characterClassCol,            
            $_characterLevelCol,$_characterBackgroundCol,$_characterHPCol,$_characterACCol,$_characterSpeedCol,$_characterInitiativeCol,
            $_characterStrengthCol,$_characterDexterityCol,$_characterConstitutionCol,$_characterIntelligenceCol,$_characterWisdomCol,
            $_characterCharismaCol,$_characterWeapon1Col,$_characterWeapon2Col,$_characterDefaultCol,$_characterBadgeCol) 
          
          VALUES(
            ${characterID[2]},'${defaultPlayer3[0]}',${raceID[2]},${classID[2]},${int.parse(defaultPlayer3[3])},
            '${defaultPlayer3[4]}','${defaultPlayer3[5]}',
            ${int.parse(defaultPlayer3[6])},${int.parse(defaultPlayer3[7])},
            ${int.parse(defaultPlayer3[8])},'${defaultPlayer3[9]}',
            '${defaultPlayer3[10]}','${defaultPlayer3[11]}',
            '${defaultPlayer3[12]}','${defaultPlayer3[13]}',
            '${defaultPlayer3[14]}',${weapon1ID[2]},${weapon2ID[2]},$_default,'${badges[2]}');
          ''',
          '''
          INSERT INTO $_characterDataTable($_characterIdCol,$_characterNameCol,$_characterRaceCol,$_characterClassCol,            
            $_characterLevelCol,$_characterBackgroundCol,$_characterHPCol,$_characterACCol,$_characterSpeedCol,$_characterInitiativeCol,
            $_characterStrengthCol,$_characterDexterityCol,$_characterConstitutionCol,$_characterIntelligenceCol,$_characterWisdomCol,
            $_characterCharismaCol,$_characterWeapon1Col,$_characterWeapon2Col,$_characterDefaultCol,$_characterBadgeCol) 
          
          VALUES(
            ${characterID[3]},'${defaultPlayer4[0]}',${raceID[3]},${classID[3]},${int.parse(defaultPlayer4[3])},
            '${defaultPlayer4[4]}','${defaultPlayer4[5]}',
            ${int.parse(defaultPlayer4[6])},${int.parse(defaultPlayer4[7])},
            ${int.parse(defaultPlayer4[8])},'${defaultPlayer4[9]}',
            '${defaultPlayer4[10]}','${defaultPlayer4[11]}',
            '${defaultPlayer4[12]}','${defaultPlayer4[13]}',
            '${defaultPlayer4[14]}',${weapon1ID[3]},${weapon2ID[3]},$_default,'${badges[3]}');
          '''
  ];

  // DEFAULT IMAGE
  static const String noPhotoAvailable = '/9j/4AAQSkZJRgABAQACWAJYAAD/2wBDAAgGBgcGBQgHBwcJCQgKDBQNDAsLDBkSEw8UHRofHh0aHBwgJC4nICIsIxwcKDcpLDAxNDQ0Hyc5PTgyPC4zNDL/wAALCAPUA9QBASIA/8QAGwABAAMBAQEBAAAAAAAAAAAAAAQFBgMBAgf/xAA6EAEAAQMBAwkHAwQDAAMBAAAAAQIDBBEFFTQSExQhMVJTcpIiUWFikaKxQXGCIzKBwTVC0SRUoXP/2gAIAQEAAD8A/fwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAfNVdNEa11RTHvmdHz0iz41v1Q86RY8a36oOkWPGt+qDpFjxrfqg6RY8a36oOkWPGt+qDpFjxrfqg6RY8a36oOkWPGt+qDpFjxrfqg6RY8a36oOkWPGt+qDpFjxrfqg6RY8a36oOkWPGt+qDpFjxrfqg6RY8a36oOkWPGt+qDpFjxrfqg6RY8a36oOkWPGt+qDpFjxrfqg6RY8a36oOkWPGt+qDpFjxrfqg6RY8a36oOkWPGt+qDpFjxrfqg6RY8a36oOkWPGt+qDpFjxrfqg6RY8a36oOkWPGt+qDpFjxrfqg6RY8a36oOkWPGt+qDpFjxrfqg6RY8a36oOkWPGt+qDpFjxrfqg6RY8a36oOkWPGt+qDpFjxrfqg6RY8a36oOkWPGt+qDpFjxrfqg6RY8a36oOkWPGt+qDpFjxrfqg6RY8a36oOkWPGt+qDpFjxrfqg6RY8a36oOkWPGt+qDpFjxrfqg6RY8a36oOkWPGt+qDpFjxrfqg6RY8a36oOkWPGt+qHsX7MzpF2iZn9Iqh0AAAAAAAAAAAAAAAAAAAAVe3ODp88fhQAAAAAAAAAAAAAAAAAAAA7YnGWfPDWgAAAAAAAAAAAAAAAAAAAKzbnB0+ePwz72ImZ0iJmfg95uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQ5uvuVfQmiuI1mmrT9ny7YnGWfPDWgAAAAAAAAAAAAAAAAAAAKzbnB0+ePwz6x2Lx/wDCWh0g0g0g0g0g0g0g0g0g0g0g0g0g0g0g0g0g0g0g0g0g0g0g0g0g0g0g0g0g0g0g0g0g0g0g0g0g0g0g0g0g0g0g0g0g0g0g0g0g0g0g0g0g0g0g0hHz4/8AgX/JLKu2Jxlnzw1oAAAAAAAAAAAAAAAAAAACs25wdPnj8M+sdi8f/CWiAAB5rEdswaxP6vQAANQAAAAAAAAAAARs/gL/AJJZV2xOMs+eGtAAAAAAAAAAAAAAAAAAAAVm3ODp88fhn1jsXj/4S0QAPJmIjrlWZW2bdqZosxzlUfr+iqu7Ryr3bdmmPdT1I811VTrNVU/vJTcrpnWmuqP2lKs7UyrMx/U5ce6rrW+Jta1kTFFX9Ov3T2SsAARNo5UYuLMxPt1dVKPsjL561Nqufbo7Nf1hZgAAAAAAAAAACNn8Bf8AJLKu2Jxlnzw1oAAAAAAAAAAAAAAAAAAACs25wdPnj8M+sdi8f/CWiAHkzERMzOmjPbR2lVkVTbtTMWo/XvK4AFvs3ac0zFi/VrTPVTVP6fCV4ATOnazG0srpWVMxPsU9VP8A6441+rGyKLtP6T1x74au3cpu26a6J1pqjWH0AAAAAAAAAAAjZ/AX/JLKu2Jxlnzw1oAAAAAAAAAAAAAAAAAAACs25wdPnj8M+sdi8f8AwlogBUbZy+TTGPRPXVGtX7e5RgADRbJy+fx+bqn26Or94WIK3a+VzOPzdM+3c6v2hnhc7Fyu3Hqn40/+LoAAAAAAAAAABGz+Av8AkllXbE4yz54a0AAAAAAAAAAAAAAAAAAABWbc4Onzx+GfWOxeP/hLRAPJnSmZnshksm7N/JuXJ/Wrq/ZyAAEvZt6bOdbnX2ap5M/5agfNdcW6JqqnSIjWZZXLyJysiq7PZPVEe6HAfVu5VauU3KZ0qpnWGrxsinJsU3Kf1jrj3S7AAAAAAAAAAAjZ/AX/ACSyrticZZ88NaAAAAAAAAAAAAAAAAAAAArNucHT54/DPrHYvH/wlogHDMq5GHeqjtiiWTAAB7TPJqifdOrYUTyqIn3w+lPtrL0ojHonrnrq/b3KQBZ7Hy+ZvzZqn2a+z4S0AAAAAAAAAAAI2fwF/wAksq7YnGWfPDWgAAAAAAAAAAAAAAAAAAAKzbnB0+ePwz6x2Lx/8JaIBHzY5WDeiO5LKAAA9jrmIbC3GlER7oh8ZF6nHs1XauymNWUvXar16q5XPXVOr4AexMxOsdsNPs/K6VjU1T/dHVV+6WAAAAAAAAAAI2fwF/ySyrticZZ88NaAAAAAAAAAAAAAAAAAAAArNucHT54/DPrHYvH/AMJaIB810xXRVTPZMaMjdtzau126u2mZh8AACRg2pvZtqj9OVrP7Q1ah2zl8u7GPTPs09dXxlVAAm7NyujZUcqf6dfVV/wCtNHYAAAAAAAAAAI2fwF/ySyrticZZ88NaAAAAAAAAAAAAAAAAAAAArNucHT54/DPrHYvH/wAJaIAUW2sXkXYyKY9mrqq+EqkAAXmxcSaKKsiqNJq6qf2Ts7JjFxqrn/bspj4stVVNVU1VTrMzrMvAAGj2Tl9Ix+RVPt2+qfjH6LAAAAAAAAAABGz+Av8AkllXbE4yz54a0AAAAAAAAAAAAAAAAAAABWbc4Onzx+GfWOxeP/hLRAD4u2qLtuqiuNaao0mGYzcOvEu6TGtE/wBtXvRgATtn4FWVciqqNLUds+/4NJTTFFMUxGkR1RDObUyukZHJpn+nR1R8Z/VAAAHfDyJxcmm5HZ2VR74auiqK6IqpnWJjWJegAAAAAAAAAjZ/AX/JLKu2Jxlnzw1oAAAAAAAAAAAAAAAAAAACs25wdPnj8M+sdi8f/CWiAB8XbVF6iaLlMVUz+kqTL2NcoqmrHnl092e2FZXRXbq5NdM0z7ph8j7t2bl6rS3RVVPwha4mxp1ivJnq7kf7XNFFNFMU0xEUx2RCHtTK6NjTFM/1K+qn/wBZoAABebFy+XROPXPtU9dP7LcAAAAAAAAAEbP4C/5JZV2xOMs+eGtAAAAAAAAAAAAAAAAAAAAVm3ODp88fhn1jsXj/AOEtEAAPmu3RcjSumKo+Mao9WzsSrtsU/wCHtOz8SjssUf5jV3popojSmIiPdEPp5VVFMTMzpEfqy2dkzlZNVevsx1Ux8EYAAB92btVi9TconrpnVrLF6m/ZouUdlUaugAAAAAAAAAjZ/AX/ACSyrticZZ88NaAAAAAAAAAAAAAAAAAAAArNucHT54/DPrHYvH/wlogAAAFVtnL5uzFiifar7fhChAAABbbGy+RcnHrnqq66f3XoAAAAAAAAAjZ/AX/JLKu2Jxlnzw1oAAAAAAAAAAAAAAAAAAACs25wdPnj8M+sdi8f/CWiAAAB8XbtNm3VXXOlNMayymRfqyL9V2rtmfpDkAAAD2mqaKoqpnSYnWJarDyacrGpuR29lUe6UgAAAAAAAABGz+Av+SWVdsTjLPnhrQAAAAAAAAAAAAAAAAAAAFZtzg6fPH4Z9Y7F4/8AhLRAAAApNtZesxjUT2ddf/inAAAAFhsrL6PkxRVPsXOqfhP6NHE6wAAAAAAAAAjZ/AX/ACSyrticZZ88NaAAAAAAAAAAAAAAAAAAAArNucHT54/DPrHYvH/wlogAABxysinGx6rtX6R1R75ZSuuq5XVXVOtVU6y+QAAAAaXZmX0nGjWfbo6qv/U4AAAAAAAAEbP4C/5JZV2xOMs+eGtAAAAAAAAAAAAAAAAAAAAVm3ODp88fhn1jsXj/AOEtEAAAM9tfL56/zVM+xb7fjKtAAAAASsDKnFyqa5n2J6qv2aiJ1iJjsl6AAACvr2nbozox/wDr2TV7pWAAAACNn8Bf8ksq7YnGWfPDWgAAAAAAAAAAAAAAAAAAAKzbnB0+ePwz6x2Lx/8ACWiAAARNo5XRcaaon26uqll9ZmdZ7QAAAAAX+x8vnbPM1T7VHZ8YWgAAAgbTzYxbGlE/1auz4fFm5mZnWZ6/e0Oys7n7XNXJ/qUR9YWQAAAI2fwF/wAksq7YnGWfPDWgAAAAAAAAAAAAAAAAAAAKzbnB0+ePwz6x2Lx/8JaIAACeqGY2lldKypmJ9inqpQwAAAAAdsa/VjX6btP6T1x74aq3cpu26a6Z1pqjWH2AADnfvUY9mq5XOkRH1ZXIv1ZN+q7X2z2R7ocn3au12LtNyidKqZanFyacqxTcp/Xtj3S7gAACNn8Bf8ksq7YnGWfPDWgAAAAAAAAAAAAAAAAAAAKzbnB0+ePwz6x2Lx/8JaIAAFdtfL5jH5uifbudX7R+rOgAAAAAC52Ll9uNVPxo/wBwugAB5M6M7tTNnIvc3RP9OifrKvBM2dmziX+uf6dXVVH+2miYqiJidYn9XoAACNn8Bf8AJLKu2Jxlnzw1oAAAAAAAAAAAAAAAAAAACs25wdPnj8M+sdi8f/CWiAAHzXXTRRVVVOkRGsyyuXkVZWTVcnsnqpj3Q4AAAAAAD6t3KrVym5TOlVM6w1eLkU5GPRcp/WOuPdLsAAq9r5vNW+Ytz7dUe1PuhQAC62Pnax0a5PXH9kz+FyAAAjZ/AX/JLKu2Jxlnzw1oAAAAAAAAAAAAAAAAAAACs25wdPnj8M+sdi8f/CWiAAFPtrL5NMY9E9dXXV+ykAAAAAAAWex8vmr/ADNc+xX2fCWgABHzMqnEsTcnt7KY98stcuVXblVdc61VTrL5AHtNU01RVTOkxOsS0+BmRl2Iqnqrp6qoSwAARs/gL/kllXbE4yz54a0AAAAAAAAAAAAAAAAAAABWbc4Onzx+GfWOxeP/AIS0QADlfvUWLNdyueqmGUvXar12q5VOtVU6vgAAAAAAAiZiYmO2Go2flRlYtNUz7cdVX7pYDyqqmimaqp0iOuZZfPy5y78zHVbp6qYRQAEjDyqsW/FcddPZVHvhqLdym7bpronWmY1iX2AAI2fwF/ySyrticZZ88NaAAAAAAAAAAAAAAAAAAAArNucHT54/DPrHYvH/AMJaIABQ7Zyucuxj0z7NHXV8ZVQAAAAAAAJmzcro2VGs+xX1VNNHXD0FJtjN1no1uer/ALzH4U4AALTZGbzVzmK59ir+2Z/SV+AAI2fwF/ySyrticZZ88NaAAAAAAAAAAAAAAAAAAAArNucHT54/DPrHYvH/AMJaIAEbNyYxcaqv/t2Ux8WWqqmqqaqp1mZ1mXgAAAAAAADR7Jy+fxubqn27fVPxj9FgIW0c2MSx7M/1KuqmP9s1MzMzMzrM9svAAAGi2XndJs83XP8AUojr+Me9YgAI2fwF/wAksq7YnGWfPDWgAAAAAAAAAAAAAAAAAAAKzbnB0+ePwz6x2Lx/8JaIAGb2rl9IyeTTPsUdUfGfegAAAAAAAADvh5M4uTTcjs7Ko98NVRVFdEVUzrExrEvm9dos2qrlc6U0xrLLZWRVlX6rlX+I90OIAAA6WL1WPepu0T1x/wDrU41+jJsU3KJ6pjs9zsACNn8Bf8ksq7YnGWfPDWgAAAAAAAAAAAAAAAAAAAKzbnB0+ePwz6x2Lx/8JaIAQdqZfRsaYpn26+qPh8WaAAAAAAAAAXmxcvlW5x6566eun9kXa2dz93maJ/p0T1/GVaAAAAnbMzZxb/Jrn+lX2/D4tJE6xrq9AEbP4C/5JZV2xOMs+eGtAAAAAAAAAAAAAAAAAAAAVm3ODp88fhn1jsXj/wCEtEA8qmKaZmZ6oZbOypy8mqv/AKx1Ux8EYAAAAAAAAB9UV1UVcqmZiffD5AAAABebHzucp6Pcn2qY9mffHuW4AjZ/AX/JLKu2Jxlnzw1oAAAAAAAAAAAAAAAAAAACs25wdPnj8M+sdi8f/CWiAVW2cvm7XMUT7Vfb8IUIAAAAAAAAAAAAAAPqiuq3XTXTOlUTrEtPhZdOXYiuOqqOqqPdKUAjZ/AX/JLKu2Jxlnzw1oAAAAAAAAAAAAAAAAAAACs25wdPnj8M+sdi8f8AwlogfF25TatVXK50ppjWWUyL9WRfru1dtU/SHIAAAAAAAAAAAAAABJwcurEyIr7aJ6qo+DUUV010U1UzExMaxL6BGz+Av+SWVdsTjLPnhrQAAAAAAAAAAAAAAAAAAAFZtzg6fPH4Z9Y7F4/+EtECk21la1RjUT8av/FOAAAAAAAAAAAAAAAC22Pm8ivo9yfZn+yZ/SfcvQRs/gL/AJJZV2xOMs+eGtAAAAAAAAAAAAAAAAAAAAVm3ODp88fhn1jsXj/4S0Q4ZeRTjY9dyr9OyPfLK111XLlVdU61VTrL5AAAAAAAAAAAAAAAAidJ1hpdm5sZVnk1T/Uo7fj8U4Rs/gL/AJJZV2xOMs+eGtAAAAAAAAAAAAAAAAAAAAVm3ODp88fhn1jsXj/4S0Qz218vnsjmqZ9i32/GVaAAAAAAAAAAAAAAAAOuPfrxr9NyieuO2PfDVWL1N+zTconWKodEbP4C/wCSWVdsTjLPnhrQAAAAAAAAAAAAAAAAAAAFZtzg6fPH4Z9Y7F4/+EtE55HOcxXFrTnJjSNVDOxsuZ1nka+Y3LlfJ6jcuV8nqNy5Xyeo3LlfJ6jcuV8nqNy5Xyeo3LlfJ6jcuV8nqNy5Xyeo3LlfJ6jcuV8nqNy5Xyeo3LlfJ6jcuV8nqNy5Xyeo3LlfJ6jcuV8nqNy5Xyeo3LlfJ6jcuV8nqNy5Xyeo3LlfJ6jcuV8nqNy5Xyeo3LlfJ6jcuV8nqNy5Xyeo3LlfJ6jcuV8nqNy5Xyeo3LlfJ6jcuV8nqNy5Xyeo3LlfJ6jcuV8nqNy5Xyeo3LlfJ6jcuV8nqNy5Xyeo3LlfJ6jcuV8nqNy5Xyeo3LlfJ6jcuV8nqNy5Xyeo3LlfJ6jcuV8nqNy5Xyeo3LlfJ6jcuV8nqNy5XyepO2bi5eJcmmvkzaq7dJ7JWiNn8Bf8ksq7YnGWfPDWgAAAAAAAAAAAAAAAAAAAKzbnB0+ePwz6x2Lx/wDCWiAAAAAAAAAAAAAAAAAAEbP4C/5JZV2xOMs+eGtAAAAAAAAAAAAAAAAAAAAVm3ODp88fhn0zZuRbxsvnLszFPJmOqNVxvjD79Xpk3xh9+r0yb4w+/V6ZN8Yffq9Mm+MPv1emTfGH36vTJvjD79Xpk3xh9+r0yb4w+/V6ZN8Yffq9Mm+MPv1emTfGH36vTJvjD79Xpk3xh9+r0yb4w+/V6ZN8Yffq9Mm+MPv1emTfGH36vTJvjD79Xpk3xh9+r0yb4w+/V6ZN8Yffq9Mm+MPv1emTfGH36vTJvjD79Xpk3xh9+r0yb4w+/V6ZN8Yffq9Mm+MPv1emTfGH36vTJvjD79Xpk3xh9+r0yb4w+/V6ZN8Yffq9Mm+MPv1emTfGH36vTJvjD79Xpk3xh9+r0yb4w+/V6ZN8Yffq9Mm+MPv1emTfGH36vTJvjD79Xpk3xh9+r0yb4w+/V6ZN8Yffq9Mm+MPv1emTfGH36vTJvjD79Xpk3xh9+r0yb4w+/V6ZN8Yffq9Mm+MPv1emTfGH36vTJvjD79Xpk3xh9+r0y45e1MW7iXbdFVU1VU6R7KhdsTjLPnhrQAAAAAAAAAAAAAAAAAAAFZtzg6fPH4Z8AAAAAAAAAAAAAAAAAAAHbE4yz54a0AAAAAAAAAAAAAAAAAAABA2rj3cnGpotU8qYq17VPurM8L7oN1ZnhfdBurM8L7oN1ZnhfdBurM8L7oN1ZnhfdBurM8L7oN1ZnhfdBurM8L7oN1ZnhfdBurM8L7oN1ZnhfdBurM8L7oN1ZnhfdBurM8L7oN1ZnhfdBurM8L7oN1ZnhfdBurM8L7oN1ZnhfdBurM8L7oN1ZnhfdBurM8L7oN1ZnhfdBurM8L7oN1ZnhfdBurM8L7oN1ZnhfdBurM8L7oN1ZnhfdBurM8L7oN1ZnhfdBurM8L7oN1ZnhfdBurM8L7oN1ZnhfdBurM8L7oN1ZnhfdBurM8L7oN1ZnhfdBurM8L7oN1ZnhfdBurM8L7oN1ZnhfdBurM8L7oN1ZnhfdBurM8L7oN1ZnhfdBurM8L7oN1ZnhfdBurM8L7oN1ZnhfdBurM8L7oN1ZnhfdBurM8L7oN1ZnhfdBurM8L7oN1ZnhfdBurM8L7oN1ZnhfdDrj7Ny7eTarqtaRTVEz1w0QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABqAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADjlXKrWNcrp/uppmYVOHti5VfijImnkVdXKiNNJXkTr2AqNp59/FyYotTTFM069carHFuVXcW1XV/dVTEy7AAOeRc5nHuXIjXk0zOjPWtqZUX4qqr5VMz106dTSR1xD0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABHzuCveSWVimZiZiNdOuV3snP5cRj3J9qP7Zn9YW4z22+Np8kfmVzg8DZ8kJAADyqIqpmJjWJ7UK3srFt3ucimdYnWImeqE4AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAR87gr3klS7Hopryq6ao1pm3MTDjmYteBkxNMzyZnWipebPzYy7Gs6Rcp6qo/2mM9tvjafJH5lc4PA2fJD7v36Me1Ny5OlMKO7tXKyLnJx4miJ7IpjWZecnatMcv8ArfV0xdsXbdfIyY5Udk1aaTC9pqprpiqmYmJjWJh6PKv7ZUGJnZNzNt2670zTNWkwv/0UVe0b9raVVNV2eapuaTEx+j6vZ+Xl3Jpw6Kooj9YjrlGnKz8O5E3KrkfCvriVnc2tbpwqL1Ma119UU+6f1V83NqZEc5TFzkz2cmNIeWdp5WPd5N2ZqiJ66au1oLN2m9apuUTrTVGsOOZmW8O1y64mZnqiI/VTVbQzsuuYs8qI7tEf7fNde0seOXXVdpj3z1wsNm7TnInmrsRFz9Jj9VoqtobUmxXNmzETXHbM/oiU07VyI5cVXIiezr0edOz8Kvk3tZ+Fcdv+XWjbGXc/sx6av2iZXVEzNETVGk6daozdrzFc2saImY6pr/8AHCKNrXY5et3T99CjaOZh3IoyKZqj3Vdv1Xli/RkWqbludaZdAAAAAAAAAAAAAAAAAAAAAAAAAAAAEfO4K95JU2xONq8krrLxqMqxNuv/ABPulnKK72zszs0qpnSY98NLYv0ZFmm5RPVP/wCKPbfG0+SPzK5weBs+SFRtq/NWRTZifZojWf3WGy8Wmzi01zHt1xrM/BPU+2sWnm4yKY0qidKtP1h9bDvzXars1T/Z1x+y2HlX9s/sy+D/AMla87UT2MtlxrtG7HvuNNZs0WLcUW6dKYcNpWqbuDd1jrpjlR8NFFs2zTfzrdFfXTGtWjT6aRop9u2aYptXYj2pnkz8XbYlc1YdVMz/AG19Sdfx7WTb5F2nWO17asW7FEUW6Yppj3PqqmK4mKo1ieqYZij/AOPtOIp/63NP8atT+jMYsRe2pTFzr1rmZ197Tx1IG16KasCqqrtpmJiUbYMzyL1P6RMSlbVvzYwquTOlVc8mFdsbGpuXKr1cR7HVTr719rHvRNo2KL+Hc105VMcqmVfsK7POXLUz1acqF4AAAAAAAAAAAAAAAAAAAAAAAAAAAAj53BXvJKm2JxtXkloVftPBjJtcuiP6tMdXxj3KrZ2bOJe5FevN1TpVHun3um2picyiYnWJojrXODwNnyQz+1P+Ru6++Pw0ljTmLenZyY/DohbV03dd1+H5Vuw9el3PdyP9r8eVf2z+zL4P/JWvO1E9jLZX/JXP/wCn+2qcM3gr/klR7G/5CPLLRqrbvD2vP/p5sLh7vn/0sb+Rbx6OXcqiKfyqrm2q66uTj2dZ+PXP0ec9te5100TTHliPyrfb6bHOf385HK/fVrWe2liV4uR0i3OlM1ax8JSLW3Y5ERdszNXvpntRsnMv7Sqi1atzFOvZHXr+632fidEx+RPXXM61T8UTb2vMWvN/pBwtn1Zdqqum9yNJ0001StyXP/s/bJuS5/8AZ+2UjA2ZOJfm5NzlaxppEaLIAAAAAAAAAAAAAAAAAAAAAAAAAAABHzuCveSVNsTjavJLQik2vgcmZybUdX/eI/KpquVVxTFU68mNI/ZqcHgbPkhT7asTRlRd09muNP8AMLLZeTTfxKadfbojSYTlRtrJiLMY8T7VU6zHug2HYmm3cvTH93VH7LceVf2z+zL4P/JWvO1E9jLZX/JXP/6f7apwzeCv+SVHsb/kI8stGqtu8Pa8/wDp5sLh7vn/ANIm2rlVWbFEz7NNMaQt8CxatYtuaIjWqImZ/WUmqqKaZmqYiI7Zlla6qa9ozVTOtM3dYn/LVs1n3pr2lPPazboq05PwWtN/ZtyInWz+1VOiRbvYsdVu5aj4RMO8TExrE9SHtWxN/Bq5Me1TPKhWbHyqbN2q1XMRTX2TPvaB5VVFMazMREfrL4tXrd+mardcVRHVrDoAAAAAAAAAAAAAAAAAAAAAAAAAAAA4ZlNVeJdppiZqmmYiIVWyMa/Zy5quWqqY5MxrMLweVUxVExMaxPbDPZmy71q9PMW6q7c9cafp8F3h01UYdqmqNKopiJiX1kY9GTZm3cjqn/8AFFc2dmYl3l2OVVEdlVHb9DpO1KvZ0u+h94+yb9+5y8mZppnrnWeuV5bt026IpojSmI0iH2PKv7ZZ7Ew8mjOt11Wa4pivWZmGh/RncjDyas65XTZrmma9YnRo47HHLpqrxLtNMa1TRMREKjZWLfs5sV3LVVNPJnrmF6rdsWbt+xbptUTXMVazp+xsexdsWLlN2iaJmrWNf2ebU2fVk6XbXXXEaTHvhX2b+0cWnmqbdcxHZE0a6JFOPtDPmOkVTbtfrHZr/hxvbOu2s6nmbVU2omJiY61/XXFFE1VTpTEazKgua7WzdLNuKIjtrnt0+LvOwo/S/P8Amlzr2HdpjWi7RV8JjRGx8i/hZMUVTMRFWlVE9jTdsKbO2RM1zcxtOvrmj/xGpubTsRyIi7pHZE06k2No5kxFyK+T83VC22fgxh0TrVNVdXb7k0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAcMy1VexLtFP8AdNM6KHZuXTh364uxMU1dUzp2SvqM3GrjWm/R6nO7tLFtUzM3Iqn3UzqprFuvaO0JucnSnlcqr4Q0gAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAiZOzcfJnlVU8mvvU9SFVsGnX2b86fGl92th2aZ1uXKqvhHUsbNm3Yo5FumKafg6AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA/9k=';

}