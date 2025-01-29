import 'package:fluttertoast/fluttertoast.dart';
import 'package:nbt_team17/defaults/app_defaults.dart';
import 'package:nbt_team17/services/character.dart';
import 'package:nbt_team17/services/character_weapon.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:math';

const _filename = "stats_and_rules.db";

class DatabaseService {
  static Random random = Random();

  // Singleton
  DatabaseService._init();
  static final DatabaseService instance = DatabaseService._init();
  static Database? _db;

  // Tables
  final int _default = 1;
  final int _custom = 0;
  final int _notFound = -1;
  final String _unknown = "N/A";
  
  // CHARACTER
  final String _characterDataTable = "character";
  final String _characterIdCol = "character_id";
  final String _characterNameCol = "character_name";
  final String _characterRaceCol = "race_id";
  final String _characterClassCol = "class_id";
  final String _characterLevelCol = "level";
  final String _characterBackgroundCol = "background";
  final String _characterHPCol = "hp";
  final String _characterACCol = "ac";
  final String _characterSpeedCol = "speed";
  final String _characterInitiativeCol = "initiative";
  final String _characterStrengthCol = "strength";
  final String _characterDexterityCol = "dexterity";
  final String _characterConstitutionCol = "constitution";
  final String _characterIntelligenceCol = "intelligence";
  final String _characterWisdomCol = "wisdom"; 
  final String _characterCharismaCol = "charisma";
  final String _characterWeapon1Col = "weapon1_id";
  final String _characterWeapon2Col = "weapon2_id";
  final String _characterDefaultCol = "is_default";
  final String _characterBadgeCol = "badge";

  // RACE
  final String _raceDataTable = "race";
  final String _raceIdCol = "race_id";
  final String _raceNameCol = "race_name";

  // CLASS
  final String _classDataTable = "character_class";
  final String _classIdCol = "character_class_id";
  final String _classNameCol = "character_class_name";

  // WEAPON
  final String _weaponDataTable = "weapon";
  final String _weaponIdCol = "weapon_id";
  final String _weaponNameCol = "weapon_name";
  final String _weaponAttackCol = "attack";
  final String _weaponDamageCol = "damage";
  final String _weaponDamageTypeCol = "damage_type_id";

  // DAMAGE TYPE
  final String _damageTypeDataTable = "damage_type";
  final String _damageTypeIdCol = "damage_type_id";
  final String _damageTypeNameCol = "damage_type_name";

  //%%%%%%%%%%%%%%%%%%%%%%%% DATABASE CONSTRUCTOR & INIT %%%%%%%%%%%%%%%%%%%%%%%%%%%

  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    }
    
    _db = await _initializeDB(_filename);
    return _db!;
  }

  void _onConfigure(Database db) async {
    await db.execute("PRAGMA foreign_keys = ON");
  }

  Future<Database> _initializeDB(String filename) async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, filename);
    return await openDatabase(
      onConfigure: _onConfigure,
      databasePath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(AppDefaults.createRaceTable);
        await db.execute(AppDefaults.createClassTable);
        await db.execute(AppDefaults.createDamageTypeTable);
        await db.execute(AppDefaults.createWeaponTable);
        await db.execute(AppDefaults.createCharacterTable);
        await db.execute(AppDefaults.insertRaces[0]);
        await db.execute(AppDefaults.insertRaces[1]);
        await db.execute(AppDefaults.insertRaces[2]);
        await db.execute(AppDefaults.insertRaces[3]);
        await db.execute(AppDefaults.insertClasses[0]);
        await db.execute(AppDefaults.insertClasses[1]);
        await db.execute(AppDefaults.insertClasses[2]);
        await db.execute(AppDefaults.insertClasses[3]);
        await db.execute(AppDefaults.insertDamageTypes[0]);
        await db.execute(AppDefaults.insertDamageTypes[1]);
        await db.execute(AppDefaults.insertDamageTypes[2]);
        await db.execute(AppDefaults.insertDamageTypes[3]);
        await db.execute(AppDefaults.insertDamageTypes[4]);
        await db.execute(AppDefaults.insertWeapon1s[0]);
        await db.execute(AppDefaults.insertWeapon1s[1]);
        await db.execute(AppDefaults.insertWeapon1s[2]);
        await db.execute(AppDefaults.insertWeapon1s[3]);
        await db.execute(AppDefaults.insertWeapon2s[0]);
        await db.execute(AppDefaults.insertWeapon2s[1]);
        await db.execute(AppDefaults.insertWeapon2s[2]);
        await db.execute(AppDefaults.insertWeapon2s[3]);
        await db.execute(AppDefaults.insertCharacters[0]);
        await db.execute(AppDefaults.insertCharacters[1]);
        await db.execute(AppDefaults.insertCharacters[2]);
        await db.execute(AppDefaults.insertCharacters[3]);
      }, 
    );
  }
  //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  //%%%%%%%%%%%%%%%%%%%%%%%% ADD FUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  Future<void> addRace(String name) async {
    final db = await database;
    int raceId = random.nextInt(10000) + 100;
    var result = await db.rawQuery("SELECT * FROM $_raceDataTable WHERE $_raceIdCol=$raceId");

    // CHECK IF ID EXISTS: If ID exists, then result.isNotEmpty == TRUE
    while (result.isNotEmpty) {
      raceId = random.nextInt(10000) + 100;
      result = await db.rawQuery("SELECT * FROM $_raceDataTable WHERE $_raceIdCol=$raceId");
    }
    
    int res = await db.insert(_raceDataTable, {_raceIdCol: raceId, _raceNameCol: name});
    if (res != raceId) {
      print("ERROR IN CREATING RACE [$name]");
    }

    // Notify [new weapon created]
    Fluttertoast.showToast(msg: "Race $name added");

    // DEBUG:
    // var result = await db.insert(_raceDataTable, {_raceIdCol: raceId, _raceNameCol: name});
    // print(result)
  }

  Future<void> addClass(String name) async {
    final db = await database;
    int classId = random.nextInt(10000) + 100;
    var result = await db.rawQuery("SELECT * FROM $_classDataTable WHERE $_classIdCol=$classId");

    // CHECK IF ID EXISTS: If ID exists, then result.isNotEmpty == TRUE
    while (result.isNotEmpty) {
      classId = random.nextInt(10000) + 100;
      result = await db.rawQuery("SELECT * FROM $_classDataTable WHERE $_classIdCol=$classId");
    }

    int res = await db.insert(_classDataTable, {_classIdCol: classId, _classNameCol: name});
    if (res != classId) {
      print("ERROR IN CREATING CLASS [$name]");
    }

    // Notify [new weapon created]
    Fluttertoast.showToast(msg: "Class $name added");

    // DEBUG:
    // var result = await db.insert(_classDataTable, {_classIdCol: classId, _classNameCol: name});
    // print(result)
  }

  Future<void> addDamageType(String name) async {
    final db = await database;
    int damageTypeId = random.nextInt(10000) + 100;
    var result = await db.rawQuery("SELECT * FROM $_damageTypeDataTable WHERE $_damageTypeIdCol=$damageTypeId");

    // CHECK IF ID EXISTS: If ID exists, then result.isNotEmpty == TRUE
    while (result.isNotEmpty) {
      damageTypeId = random.nextInt(10000) + 100;
      result = await db.rawQuery("SELECT * FROM $_damageTypeDataTable WHERE $_damageTypeIdCol=$damageTypeId");
    }

    int res = await db.insert(_damageTypeDataTable, {_damageTypeIdCol: damageTypeId, _damageTypeNameCol: name});
    if (res != damageTypeId) {
      print("ERROR IN CREATING DAMAGE TYPE [$name]");
    }

    // Notify [new weapon created]
    Fluttertoast.showToast(msg: "Damage Type $name added");

    // DEBUG:
    // var result = await db.insert(_damageTypeDataTable, {_damageTypeIdCol: damageTypeId, _damageTypeNameCol: name});
    // print(result)
  }

  Future<void> addWeapon(List<String> weapon) async {
    // index: weapon[0]: name, weapon[1]: attack, weapon[2]: damage, weapon[3]: damageType
    final db = await database;
    int weaponId = random.nextInt(10000) + 100;
    var result = await db.rawQuery("SELECT * FROM $_weaponDataTable WHERE $_weaponIdCol=$weaponId");

    // CHECK IF ID EXISTS: If ID exists, then result.isNotEmpty == TRUE
    while (result.isNotEmpty) {
      weaponId = random.nextInt(10000) + 100;
      result = await db.rawQuery("SELECT * FROM $_weaponDataTable WHERE $_weaponIdCol=$weaponId");
    }

    // Find damage_type_id
    int dtId = await getDamageTypeId(weapon[3]);
    if (dtId == _notFound) {
      await addDamageType(weapon[3]); // add damage type if not found
      dtId = await getDamageTypeId(weapon[3]);
    }

    await db.insert(_weaponDataTable, {
      _weaponIdCol: weaponId,
      _weaponNameCol: weapon[0],
      _weaponAttackCol: weapon[1],
      _weaponDamageCol: weapon[2],
      _weaponDamageTypeCol: dtId
    });

    // Notify [new weapon created]
    Fluttertoast.showToast(msg: "Weapon ${weapon[0]} added");
  }

  void addCharacter(List<String> attributes, List<String> weapon1, List<String> weapon2) async {
    final db = await database;
    int characterId = random.nextInt(10000) + 100;
    var result = await db.rawQuery("SELECT * FROM $_characterDataTable WHERE $_characterIdCol=$characterId");

    // CHECK IF ID EXISTS: If ID exists, then result.isNotEmpty == TRUE
    while (result.isNotEmpty) {
      characterId = random.nextInt(10000) + 100;
      result = await db.rawQuery("SELECT * FROM $_characterDataTable WHERE $_characterIdCol=$characterId");
    }

    // If character name exists, abort adding new character
    List<String> names = await getCustomCharacterNames();
    for (int i = 0; i < names.length; i++) {
      if (attributes[0] == names[i]) {
        Fluttertoast.showToast(msg: "Character Name found in database. Try again with another name.");
        return;
      }
    }

    /*  index of atts: 
        0: name, 1: race, 2: class, 3: level, 4: background, 5: hp, 6: ac, 7: speed
        8: initiative, 9: strength, 10: dexterity, 11: constitution, 12: intelligence, 
        13: wisdom, 14: charisma, 15: weapon1, 16: weapon2, 17: default, 18: badge (key)
    */

    // INSERT WEAPONS
    int weaponId1 = await getWeaponId(attributes[15]); // check if weapon already exists
    if (weaponId1 == _notFound) {
      await addWeapon(weapon1);
      weaponId1 = await getWeaponId(attributes[15]); // assert: attributes[15] == weapon1[0]
    } else {
      Fluttertoast.showToast(msg: "Weapon ${attributes[15]} found in db. Obtaining params.");
    }

    int weaponId2 = await getWeaponId(attributes[16]); // check if weapon already exists
    if (weaponId2 == _notFound) {
      await addWeapon(weapon2);
      weaponId2 = await getWeaponId(attributes[16]); // assert: attributes[15] == weapon1[0]
    } else {
      Fluttertoast.showToast(msg: "Weapon ${attributes[16]} found in db. Obtaining params.");
    }

    // INSERT/GET RACE
    int raceId = await getRaceId(attributes[1]);
    if (raceId == _notFound) {
      await addRace(attributes[1]);
      raceId = await getRaceId(attributes[1]);
    } 

    // INSERT/GET CLASS
    int classId = await getClassId(attributes[2]);
    if (classId == _notFound) {
      await addClass(attributes[2]);
      classId = await getClassId(attributes[2]);
    } 

    // Insert
    await db.insert(_characterDataTable, {
      _characterIdCol: characterId,
      _characterNameCol: attributes[0],
      _characterRaceCol: raceId,
      _characterClassCol: classId,
      _characterLevelCol: int.parse(attributes[3]),
      _characterBackgroundCol: attributes[4],
      _characterHPCol: attributes[5],
      _characterACCol: int.parse(attributes[6]),
      _characterSpeedCol: int.parse(attributes[7]),
      _characterInitiativeCol: int.parse(attributes[8]),
      _characterStrengthCol: attributes[9],
      _characterDexterityCol: attributes[10],
      _characterConstitutionCol: attributes[11],
      _characterIntelligenceCol: attributes[12],
      _characterWisdomCol: attributes[13],
      _characterCharismaCol: attributes[14],
      _characterWeapon1Col: weaponId1,
      _characterWeapon2Col: weaponId2,
      _characterDefaultCol: int.parse(attributes[17]),
      _characterBadgeCol: attributes[18]
    });

    // Notify [new character created]
    Fluttertoast.showToast(msg: "Character ${attributes[0]} added");
  }

  //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  //%%%%%%%%%%%%%%%%%%%%%%%%%% GETTER METHODS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  // RETURNS ID
  Future<int> getRaceId(String race) async {
    int raceId;
    try {
      final db = await database;
      final result = await db.rawQuery("SELECT $_raceIdCol FROM $_raceDataTable WHERE $_raceNameCol='$race'");
      if (result.isEmpty) {
        throw Exception("result: [$result] for [$race] >> ERROR");
      }
      raceId = result.map((e) => e[_raceIdCol] as int).toList().first;
    } on Exception catch (_) {
      raceId = _notFound;
    }

    return raceId;
  }

  Future<int> getClassId(String className) async {
    int classId;
    try {
      final db = await database;
      final result = await db.rawQuery("SELECT $_classIdCol FROM $_classDataTable WHERE $_classNameCol='$className'");
      if (result.isEmpty) {
        throw Exception("result: [$result] for [$className] >> ERROR");
      }
      classId = result.map((e) => e[_classIdCol] as int).toList().first;
    } on Exception catch (_) {
      classId = _notFound;
    }

    return classId;
  }

  Future<int> getDamageTypeId(String damageType) async {
    int dtId;
    try {
      final db = await database;
      final result = await db.rawQuery("SELECT $_damageTypeIdCol FROM $_damageTypeDataTable WHERE $_damageTypeNameCol='$damageType'");
      if (result.isEmpty) {
        throw Exception("result: [$result] for [$damageType] >> ERROR");
      }
      dtId = result.map((e) => e[_damageTypeIdCol] as int).toList().first;
    } on Exception catch (_) {
      dtId = _notFound;
    }

    return dtId;
  }

  Future<int> getWeaponId(String weapon) async {
    int weaponId;
    try {
      final db = await database;
      final result = await db.rawQuery("SELECT $_weaponIdCol FROM $_weaponDataTable WHERE $_weaponNameCol='$weapon'");
      if (result.isEmpty) {
        throw Exception("result: [$result] for [$weapon] >> ERROR");
      }
      weaponId = result.map((e) => e[_weaponIdCol] as int).toList().first;
    } on Exception catch (_) {
      weaponId = _notFound;
    }

    return weaponId;
  }

  Future<int> getCharacterId(String name) async {
    int characterId;
    try {
      final db = await database;
      final result = await db.rawQuery("SELECT $_characterIdCol FROM $_characterDataTable WHERE $_characterNameCol='$name'");
      if (result.isEmpty) {
        throw Exception("result: [$result] for [$name] >> ERROR");
      }
      characterId = result.map((e) => e[_characterIdCol] as int).toList().first;
    } on Exception catch (_) {
      characterId = _notFound;
    }

    return characterId;
  }

  // RETURNS NAME
  Future<String> getRace(int raceId) async {
    String raceName;
    try {
      final db = await database;
      final result = await db.rawQuery("SELECT $_raceNameCol FROM $_raceDataTable WHERE $_raceIdCol=$raceId");
      raceName = result.map((e) => e[_raceNameCol] as String).toList().first;
    } on Exception catch (_) {
      raceName = _unknown;
    }

    return raceName;
  }

  Future<String> getClass(int classId) async {
    String className;
    try {
      final db = await database;
      final result = await db.rawQuery("SELECT $_classNameCol FROM $_classDataTable WHERE $_classIdCol=$classId");
      className = result.map((e) => e[_classNameCol] as String).toList().first;
    } on Exception catch (_) {
      className = _unknown;
    }

    return className;
  }

  Future<String> getDamageType(int damageTypeId) async {
    String dtName;
    try {
      final db = await database;
      final result = await db.rawQuery("SELECT $_damageTypeNameCol FROM $_damageTypeDataTable WHERE $_damageTypeIdCol=$damageTypeId");
      dtName = result.map((e) => e[_damageTypeNameCol] as String).toList().first;
    } on Exception catch (_) {
      dtName = _unknown;
    }

    return dtName;
  }

  Future<CharacterWeapon> getWeapon(int weaponId) async {
    Future<CharacterWeapon> aWeapon;
    try {
      final db = await database;
      final result = await db.rawQuery("SELECT * FROM $_weaponDataTable WHERE $_weaponIdCol=$weaponId");
      aWeapon = result.map(
        (e) async => CharacterWeapon(
          name: e[_weaponNameCol] as String, 
          attack: "${e[_weaponAttackCol]}", 
          damage: e[_weaponDamageCol] as String, 
          type: await getDamageType(e[_weaponDamageTypeCol] as int))
      ).first;

    } on Exception catch (_) {
      aWeapon = CharacterWeapon(name: _unknown, attack: _unknown, damage: _unknown, type: _unknown) as Future<CharacterWeapon>;
    }

    return aWeapon;

  }

  // RETURNS LIST OF CHARACTERS
  Future<List<Future<Character>>> getAllCharacters() async {
    final db = await database;
    /* DEBUG:
    if (db.isOpen) {
      var res = db.query('sqlite_master', where: 'name = ?', whereArgs: [_characterDataTable]);
      print("getAllCharacters(): $res");
    } */
    
    final result = await db.rawQuery(
      'SELECT * FROM $_characterDataTable'
    );

    List<Future<Character>> uniqueCharacters = result.map(
      (e) async => Character(
        characterRace: await getRace(int.parse("${e[_characterRaceCol]}")), 
        characterClass: await getClass(e[_characterClassCol] as int),
        hp: e[_characterHPCol] as String, 
        ac: e[_characterACCol] as int, 
        speed: e[_characterSpeedCol] as int, 
        initiative: e[_characterInitiativeCol] as int, 
        strength: e[_characterStrengthCol] as String, 
        dexterity: e[_characterDexterityCol] as String, 
        constitution: e[_characterConstitutionCol] as String, 
        intelligence: e[_characterIntelligenceCol] as String, 
        wisdom: e[_characterWisdomCol] as String, 
        charisma: e[_characterCharismaCol] as String,
        name: e[_characterNameCol] as String, 
        level: e[_characterLevelCol] as int, 
        background: e[_characterBackgroundCol] as String, 
        weapon1: await getWeapon(e[_characterWeapon1Col] as int), 
        weapon2: await getWeapon(e[_characterWeapon2Col] as int),
        badge: e[_characterBadgeCol] as String
      )
    ).toList();

    /*
    DEBUG: UNIQUE CHARACTERS
    final allCharacters = await db.rawQuery("SELECT * FROM $_characterDataTable");
    for (var i = 0; i < allCharacters.length; i++) {
      print(allCharacters[i]);
    }

    DEBUG: TOTAL Nº OF ENTRIES
    final characterCount = await db.rawQuery('SELECT COUNT(*) FROM $_characterDataTable');
    print("character count: $characterCount");
    */

    // Returns list of unique characters
    return uniqueCharacters;
  }

  Future<List<Future<Character>>> getDefaultCharacters() async {
    final db = await database;

    // default: 1 => default character
    final result = await db.rawQuery("SELECT * FROM $_characterDataTable WHERE $_characterDefaultCol=$_default");

    List<Future<Character>> defaultCharacters = result.map(
      (e) async => Character(
        characterRace: await getRace(int.parse("${e[_characterRaceCol]}")), 
        characterClass: await getClass(e[_characterClassCol] as int),
        hp: e[_characterHPCol] as String, 
        ac: e[_characterACCol] as int, 
        speed: e[_characterSpeedCol] as int, 
        initiative: e[_characterInitiativeCol] as int, 
        strength: e[_characterStrengthCol] as String, 
        dexterity: e[_characterDexterityCol] as String, 
        constitution: e[_characterConstitutionCol] as String, 
        intelligence: e[_characterIntelligenceCol] as String, 
        wisdom: e[_characterWisdomCol] as String, 
        charisma: e[_characterCharismaCol] as String,
        name: e[_characterNameCol] as String, 
        level: e[_characterLevelCol] as int, 
        background: e[_characterBackgroundCol] as String, 
        weapon1: await getWeapon(e[_characterWeapon1Col] as int), 
        weapon2: await getWeapon(e[_characterWeapon2Col] as int), 
        badge: e[_characterBadgeCol] as String
      )
    ).toList();

    return defaultCharacters;
  }

  Future<List<Future<Character>>> getCustomCharacters() async {
    final db = await database;

    // default: 1 => default character
    final result = await db.rawQuery("SELECT * FROM $_characterDataTable WHERE $_characterDefaultCol=$_custom");

    List<Future<Character>> customCharacters = result.map(
      (e) async => Character(
        characterRace: await getRace(int.parse("${e[_characterRaceCol]}")), 
        characterClass: await getClass(e[_characterClassCol] as int),
        hp: e[_characterHPCol] as String, 
        ac: e[_characterACCol] as int, 
        speed: e[_characterSpeedCol] as int, 
        initiative: e[_characterInitiativeCol] as int, 
        strength: e[_characterStrengthCol] as String, 
        dexterity: e[_characterDexterityCol] as String, 
        constitution: e[_characterConstitutionCol] as String, 
        intelligence: e[_characterIntelligenceCol] as String, 
        wisdom: e[_characterWisdomCol] as String, 
        charisma: e[_characterCharismaCol] as String,
        name: e[_characterNameCol] as String, 
        level: e[_characterLevelCol] as int, 
        background: e[_characterBackgroundCol] as String, 
        weapon1: await getWeapon(e[_characterWeapon1Col] as int), 
        weapon2: await getWeapon(e[_characterWeapon2Col] as int), 
        badge: e[_characterBadgeCol] as String
      )
    ).toList();

    return customCharacters;
  }

  Future<List<String>> getCustomCharacterNames() async {
    final db = await database;
    List<String> names = [];

    // default: 1 => default character
    List<Map> result = await db.rawQuery("SELECT $_characterNameCol FROM $_characterDataTable WHERE $_characterDefaultCol=$_custom");
    for (int i = 0; i < result.length; i++) {
      names.add(result[i][_characterNameCol]);
    }

    return names;
  }

  //%%%%%%%%%%%%%%%%%%%%%%%%%% SETTER/UPDATE METHODS %%%%%%%%%%%%%%%%%%%%%%%%%%%%

  void updateCharacter(List<String> attributes, List<String> weapon1, List<String> weapon2, String formerName) async {
    final db = await database;
    int characterId;
    
    // find character id from name
    try {
      final result = await db.rawQuery("SELECT $_characterIdCol FROM $_characterDataTable WHERE $_characterNameCol='$formerName'");
      characterId = result.map((e) => e[_characterIdCol] as int).toList().first;
    } on Exception catch (_) {
      throw Exception('dbService: characterId not found');
    }

    /*  index of atts: 
        0: name, 1: race, 2: class, 3: level, 4: background, 5: hp, 6: ac, 7: speed
        8: initiative, 9: strength, 10: dexterity, 11: constitution, 12: intelligence, 
        13: wisdom, 14: charisma, 15: weapon1, 16: weapon2, 17: default, 18: badge (key)
    */

    // INSERT WEAPONS
    int weaponId1 = await getWeaponId(attributes[15]); // check if weapon already exists
    if (weaponId1 == _notFound) {
      await addWeapon(weapon1);
      weaponId1 = await getWeaponId(attributes[15]); // assert: attributes[15] == weapon1[0]
    } else {
      Fluttertoast.showToast(msg: "Weapon ${attributes[15]} found in db. Obtaining params.");
    }

    int weaponId2 = await getWeaponId(attributes[16]); // check if weapon already exists
    if (weaponId2 == _notFound) {
      await addWeapon(weapon2);
      weaponId2 = await getWeaponId(attributes[16]); // assert: attributes[15] == weapon1[0]
    } else {
      Fluttertoast.showToast(msg: "Weapon ${attributes[16]} found in db. Obtaining params.");
    }

    // INSERT/GET RACE
    int raceId = await getRaceId(attributes[1]);
    if (raceId == _notFound) {
      await addRace(attributes[1]);
      raceId = await getRaceId(attributes[1]);
    } 

    // INSERT/GET CLASS
    int classId = await getClassId(attributes[2]);
    if (classId == _notFound) {
      await addClass(attributes[2]);
      classId = await getClassId(attributes[2]);
    } 

    // Insert
    await db.update(
      _characterDataTable, 
      {
        _characterIdCol: characterId,
        _characterNameCol: attributes[0],
        _characterRaceCol: raceId,
        _characterClassCol: classId,
        _characterLevelCol: int.parse(attributes[3]),
        _characterBackgroundCol: attributes[4],
        _characterHPCol: attributes[5],
        _characterACCol: int.parse(attributes[6]),
        _characterSpeedCol: int.parse(attributes[7]),
        _characterInitiativeCol: int.parse(attributes[8]),
        _characterStrengthCol: attributes[9],
        _characterDexterityCol: attributes[10],
        _characterConstitutionCol: attributes[11],
        _characterIntelligenceCol: attributes[12],
        _characterWisdomCol: attributes[13],
        _characterCharismaCol: attributes[14],
        _characterWeapon1Col: weaponId1,
        _characterWeapon2Col: weaponId2,
        _characterDefaultCol: int.parse(attributes[17]),
        _characterBadgeCol: attributes[18]
      },
      where: "$_characterIdCol = ?",
      whereArgs: [characterId]  
    );

    // Notify [new character created]
    Fluttertoast.showToast(msg: "Character ${attributes[0]} updated");
  }

  Future<void> deleteCharacter(String name) async {
    final db = await database;
    await db.rawDelete("DELETE FROM $_characterDataTable WHERE $_characterNameCol = '$name'");
  }
}