import 'package:flutter/material.dart';
import 'package:nbt_team17/defaults/app_defaults.dart';
import 'package:nbt_team17/services/character.dart';
import 'package:nbt_team17/services/database_service.dart';
import 'package:nbt_team17/services/file_manager.dart';
import 'package:nbt_team17/stats/stats_model.dart';
import 'package:provider/provider.dart';

class EditCharacterPage extends StatefulWidget {
  const EditCharacterPage({super.key, required this.dbService, required this.formerCharacter});
  final DatabaseService dbService;
  final Character formerCharacter;

  @override
  State<EditCharacterPage> createState() => _EditCharacterPageState();

}

enum DiceLabel {
  dFour('1d4','1d4'),
  dSix('1d6','1d6'),
  dEight('1d8','1d8'),
  dTen('1d10','1d10'),
  dTwelve('1d12','1d12'),
  dTwenty('1d20','1d20'),
  dHundred('1d100','1d100');

  const DiceLabel(this.label, this.dType);
  final String label;
  final String dType;
}

enum DamageTypeLabel {
  acid('Acid','Acid'),
  lighting('Lighting','Lighting'),
  necrotic('Necrotic','Necrotic'),
  radiant('Radiant','Radiant'),
  psychic('Psychic','Psychic'),
  bludgeoning('Bludgeoning','Bludgeoning'),
  poison('Poison','Poison'),
  fire('Fire','Fire'),
  explosive('Explosive','Explosive'),
  freezing('Freezing','Freezing'),
  piercing('Piercing','Piercing'),
  slashing('Slashing','Slashing');


  const DamageTypeLabel(this.label, this.dmType);
  final String label;
  final String dmType;
}

enum RaceLabel {
  dwarf('Dwarf', 'Dwarf'),
  elf('Elf', 'Elf'),
  halfling('Halfling', 'Halfling'),
  human('Human', 'Human'),
  aasimar('Aasimar', 'Aasimar'),
  dragonborn('Dragonborn', 'Dragonborn'),
  gnome('Gnome', 'Gnome'),
  goliath('Goliath', 'Goliath'),
  orc('Orc', 'Orc'),
  tiefling('Tiefling', 'Tiefling');

  const RaceLabel(this.label, this.race);
  final String label;
  final String race;
}

enum ClassLabel {
  barbarian('Barbarian', 'Barbarian'),
  bard('Bard', 'Bard'),
  cleric('Cleric', 'Cleric'),
  druid('Druid', 'Druid'),
  fighter('Fighter', 'Fighter'),
  monk('Monk', 'Monk'),
  paladin('Paladin', 'Paladin'),
  ranger('Ranger', 'Ranger'),
  rogue('Rogue', 'Rogue'),
  sorcerer('Sorcerer', 'Sorcerer'),
  warlock('Warlock', 'Warlock'),
  wizard('Wizard', 'Wizard');

  const ClassLabel(this.label, this.cName);
  final String label;
  final String cName;
}

enum BadgesLabel {
  shield1('shield-1', 'shield-1'),
  shield2('shield-2', 'shield-2'),
  shield3('shield-3', 'shield-3'),
  shield4('shield-4', 'shield-4'),
  shieldDefault('shield-default', 'shield-default');

  const BadgesLabel(this.label, this.bName);
  final String label;
  final String bName;
}


class _EditCharacterPageState extends State<EditCharacterPage> {
  bool characterFound = false;

  // TEXT CONTROLLERS
  late TextEditingController _textControllerCharName;
  late TextEditingController _textControllerCharRace;
  late TextEditingController _textControllerCharClass;
  late TextEditingController _textControllerCharBackground;

  late TextEditingController _textControllerCharWeapon1Name;
  late TextEditingController _textControllerCharWeapon1DamageDice;
  late TextEditingController _textControllerCharWeapon1DType;

  late TextEditingController _textControllerCharWeapon2Name;
  late TextEditingController _textControllerCharWeapon2DamageDice;
  late TextEditingController _textControllerCharWeapon2DType;
  late TextEditingController _textControllerCharBadge;

  void initTextEditing() {
    _textControllerCharName = TextEditingController()
      ..addListener(() {
        Provider.of<StatsModel>(context, listen: false)
            .updateCharacterName(_textControllerCharName.text);
      });

    _textControllerCharRace = TextEditingController()
      ..addListener(() {
        Provider.of<StatsModel>(context, listen: false)
            .updateRaceName(_textControllerCharRace.text);
      });

    _textControllerCharClass = TextEditingController()
      ..addListener(() {
        Provider.of<StatsModel>(context, listen: false)
            .updateClassName(_textControllerCharClass.text);
      });

    _textControllerCharBackground = TextEditingController()
      ..addListener(() {
        Provider.of<StatsModel>(context, listen: false)
            .updateBackgroundText(_textControllerCharBackground.text);
      });

    _textControllerCharWeapon1Name = TextEditingController()
      ..addListener(() {
        Provider.of<StatsModel>(context, listen: false)
            .updateWeapon1Name(_textControllerCharWeapon1Name.text);
      });

    _textControllerCharWeapon1DamageDice = TextEditingController()
      ..addListener(() {
        Provider.of<StatsModel>(context, listen: false)
            .updateWeapon1DamageDice(_textControllerCharWeapon1DamageDice.text);
      });

    _textControllerCharWeapon1DType = TextEditingController()
      ..addListener(() {
        Provider.of<StatsModel>(context, listen: false)
            .updateWeapon1DType(_textControllerCharWeapon1DType.text);
      });

    _textControllerCharWeapon2Name = TextEditingController()
      ..addListener(() {
        Provider.of<StatsModel>(context, listen: false)
            .updateWeapon2Name(_textControllerCharWeapon2Name.text);
      });
    
    _textControllerCharWeapon2DamageDice = TextEditingController()
      ..addListener(() {
        Provider.of<StatsModel>(context, listen: false)
            .updateWeapon2DamageDice(_textControllerCharWeapon2DamageDice.text);
      });

    _textControllerCharWeapon2DType = TextEditingController()
      ..addListener(() {
        Provider.of<StatsModel>(context, listen: false)
            .updateWeapon2DType(_textControllerCharWeapon2DType.text);
      });
    
    _textControllerCharBadge = TextEditingController()
      ..addListener(() {
        Provider.of<StatsModel>(context, listen: false)
            .updateBadge(_textControllerCharBadge.text);
      });
  }

  void disposeTextEditing() {
    _textControllerCharName.dispose();
    _textControllerCharRace.dispose();
    _textControllerCharClass.dispose();
    _textControllerCharBackground.dispose();

    _textControllerCharWeapon1Name.dispose();
    _textControllerCharWeapon1DType.dispose();

    _textControllerCharWeapon2Name.dispose();
    _textControllerCharWeapon2DType.dispose();
    _textControllerCharBadge.dispose();
  }

  @override
  void initState() {
    super.initState();
    initTextEditing();
  }

  @override
  void dispose() {
    disposeTextEditing();
    super.dispose();
  }

  // STATIC WIDGETS
  Widget buildHeader(String name) {
    return Container(
      color: Colors.white,
      child: Align(
        alignment: Alignment.center,
        child: Text(name,
            style: AppDefaults.heading1Dark, textAlign: TextAlign.center),
      ),
    );
  }

  InputDecoration setDecoration(String label, String hint, String helper, String err, int maxCount, int chars) {
    return InputDecoration(
        label: Text(label),
        helperText: helper,
        errorText: (chars > maxCount)? err: null,
        hintText: hint,
        border: const OutlineInputBorder(),
        hintStyle: TextStyle(color: ThemeData.dark().hintColor));
  }

  Widget createParam(TextEditingController control, TextInputType kType, String label, String hint, String helper, String err, int lines, int val, int limit) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      child: TextField(
        maxLines: lines,
        controller: control,
        keyboardType: kType,
        decoration: setDecoration(label, hint, helper, err, limit, val),
      ),
    );
  }

  Widget createSlider(Widget sl, String label) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(label,style: const TextStyle(fontSize: 16)),
          Expanded(child: sl),
        ],
      )
    );
  }

  Widget createDoubleSlider(Widget sl1, Widget sl2, String label) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(label,style: const TextStyle(fontSize: 16)),
          Expanded(
            child: Column(
              children: [
                sl1,
                sl2
              ],
            ),
          )
        ],
      )
    );
  }

  // BUILD WIDGET
  @override
  Widget build(BuildContext context) {
    //Text exceedsMaxChars = const Text("Exceeding Max Characters", style: AppDefaults.italicSmall);
    int maxCharactersName = 30;
    int maxCharactersBackground = 120;
    final provider = Provider.of<StatsModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.of(context)..pop()..pop(),
            icon: const Icon(Icons.arrow_back)
        ),
        title: const Text("Edit Character", style: AppDefaults.titleDark),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                //%%%%%%%%%%%%%%%%% BACKGROUND INFO %%%%%%%%%%%%%%%%%%%%%
                //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                buildHeader("Background Information"),
                //%%%%%%%%%%%%%%%%%%%%%%%%%% NAME %%%%%%%%%%%%%%%%%%%%%%%%%
                createParam(
                  _textControllerCharName, 
                  TextInputType.text, 
                  "Character Name", 
                  "Enter your character's name",
                  "Former name: ${widget.formerCharacter.name}",
                  "Max Characters: $maxCharactersName",
                  1,
                  Provider.of<StatsModel>(context).characterName.length,
                  maxCharactersName
                ),
                //%%%%%%%%%%%%%%%%%%%%%%%%%% RACE %%%%%%%%%%%%%%%%%%%%%%%%%
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 20.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: DropdownMenu<RaceLabel>(
                          helperText: "Former race: ${widget.formerCharacter.characterRace}",
                          expandedInsets: const EdgeInsets.all(8.0),
                          controller: _textControllerCharRace,
                          label: const Text("Select Race"),
                          dropdownMenuEntries: RaceLabel.values
                            .map<DropdownMenuEntry<RaceLabel>>(
                              (RaceLabel race) {
                                return DropdownMenuEntry<RaceLabel>(value: race, label: race.label);
                              }
                            ).toList(),
                        ),
                      ),
                    ]
                  ),
                ),
                //%%%%%%%%%%%%%%%%%%%%%%%%%% CLASS %%%%%%%%%%%%%%%%%%%%%%%%%
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 20.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: DropdownMenu<ClassLabel>(
                          helperText: "Former class: ${widget.formerCharacter.characterClass}",
                          expandedInsets: const EdgeInsets.all(8.0),
                          controller: _textControllerCharClass,
                          label: const Text("Select Class"),
                          dropdownMenuEntries: ClassLabel.values
                              .map<DropdownMenuEntry<ClassLabel>>(
                                (ClassLabel className) {
                                  return DropdownMenuEntry<ClassLabel>(value: className, label: className.label);
                                }
                              ).toList(),
                        ),
                      ),
                    ]
                  ),
                ),
                //%%%%%%%%%%%%%%%%%%%%%%%%%% LEVEL %%%%%%%%%%%%%%%%%%%%%%%%%
                createSlider(
                  Slider(
                    onChanged: (val) => provider.updateLevel(val.round()), 
                    value: provider.levelNum * 1.0,
                    label: provider.levelNum.round().toString(),
                    divisions: 50, min: 0, max: 50,
                  ), 
                  "Level"
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text('Former level: ${widget.formerCharacter.level}', style: const TextStyle(fontSize: 12)),
                ),
                //%%%%%%%%%%%%%%%%%%%%%%%%%% BACKGROUND %%%%%%%%%%%%%%%%%%%%%%%%%
                createParam(
                  _textControllerCharBackground, 
                  TextInputType.multiline, 
                  "Background", 
                  "Enter your character's background",
                  "Former background: ${widget.formerCharacter.background.substring(
                    0,
                    (widget.formerCharacter.background.length < 35)? widget.formerCharacter.background.length: 35
                  )}...",
                  "Max Characters: $maxCharactersBackground", 
                  5,
                  Provider.of<StatsModel>(context).backgroundText.length,
                  maxCharactersBackground
                ),
                const Padding(padding: EdgeInsets.only(top: 10.0, bottom: 10.0)),
                
                //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                //%%%%%%%%%%%%%%%%%%% MAIN STATS %%%%%%%%%%%%%%%%%%%%%%%%
                //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                buildHeader("Main Stats"),
                //%%%%%%%%%%%%%%%%%%%%%%%%%% HP %%%%%%%%%%%%%%%%%%%%%%%%%
                createSlider(
                  RangeSlider(
                    values: provider.hp,
                    onChanged: (val) => provider.updateHP(val),
                    labels: RangeLabels('${provider.hp.start.round()}', '${provider.hp.end.round()}'),
                    divisions: 100, min: 0, max: 100,
                  ), 
                  "HP"
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text('Former HP: ${widget.formerCharacter.hp}', style: const TextStyle(fontSize: 12)),
                ),
                //%%%%%%%%%%%%%%%%%%%%%%%%%% AC %%%%%%%%%%%%%%%%%%%%%%%%%
                createSlider(
                  Slider(
                    onChanged: (val) => provider.updateAC(val.round()),
                    value: provider.ac * 1.0,
                    label: provider.ac.round().toString(),
                    divisions: 50, min: 0, max: 50
                  ),
                  "AC"
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text('Former AC: ${widget.formerCharacter.ac}', style: const TextStyle(fontSize: 12)),
                ),
                //%%%%%%%%%%%%%%%%%%%%%%%%%% SPEED %%%%%%%%%%%%%%%%%%%%%%%%%
                createSlider(
                  Slider(
                    onChanged: (val) => provider.updateSpeed(val.round()),
                    value: provider.speed * 1.0,
                    label: provider.speed.round().toString(),
                    divisions: 50, min: 0, max: 50
                  ),
                  "Speed"
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text('Former Speed: ${widget.formerCharacter.speed}', style: const TextStyle(fontSize: 12)),
                ),
                //%%%%%%%%%%%%%%%%%%%%%%%%%% INITIATIVE %%%%%%%%%%%%%%%%%%%%%%%%%
                createSlider(
                  Slider(
                    onChanged: (val) => provider.updateInitiative(val.round()),
                    value: provider.initiative * 1.0,
                    label: provider.initiative.round().toString(),
                    divisions: 50, min: 0, max: 50
                  ),
                  "Initiative"
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text('Former Initiative: ${widget.formerCharacter.initiative}', style: const TextStyle(fontSize: 12)),
                ),
                const Padding(padding: EdgeInsets.only(top: 10.0, bottom: 10.0)),

                //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                //%%%%%%%%%%%%%%% SECONDARY STATS %%%%%%%%%%%%%%%%%%%%%%%
                //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                buildHeader("Secondary Stats"),
                //%%%%%%%%%%%%%%%%%%%%%%%%%% STRENGTH %%%%%%%%%%%%%%%%%%%%%%%%%
                createDoubleSlider(
                  Slider(
                    value: provider.mainStrength * 1.0, 
                    onChanged: (val) => provider.updateMainStrength(val.round()),
                    label: provider.mainStrength.round().toString(),
                    divisions: 45, min: 5, max: 50
                  ), 
                  Slider(
                    value: provider.addStrength * 1.0, 
                    onChanged: (val) => provider.updateAddStrength(val.round()),
                    label: '+${provider.addStrength.round()}',
                    divisions: 20, min: 0, max: 20
                  ), 
                  "Strength"
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text('Former Strength: ${widget.formerCharacter.strength}', style: const TextStyle(fontSize: 12)),
                ),
                //%%%%%%%%%%%%%%%%%%%%%%%%%% DEXTERITY %%%%%%%%%%%%%%%%%%%%%%%%%
                createDoubleSlider(
                  Slider(
                    value: provider.mainDexterity * 1.0, 
                    onChanged: (val) => provider.updateMainDexterity(val.round()),
                    label: provider.mainDexterity.round().toString(),
                    divisions: 45, min: 5, max: 50
                  ), 
                  Slider(
                    value: provider.addDexterity * 1.0, 
                    onChanged: (val) => provider.updateAddDexterity(val.round()),
                    label: '+${provider.addDexterity.round()}',
                    divisions: 20, min: 0, max: 20
                  ), 
                  "Dexterity"
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text('Former Dexterity: ${widget.formerCharacter.dexterity}', style: const TextStyle(fontSize: 12)),
                ),
                //%%%%%%%%%%%%%%%%%%%%%%%%%% CONSTITUTION %%%%%%%%%%%%%%%%%%%%%%%%%
                createDoubleSlider(
                  Slider(
                    value: provider.mainConstitution * 1.0, 
                    onChanged: (val) => provider.updateMainConstitution(val.round()),
                    label: provider.mainConstitution.round().toString(),
                    divisions: 45, min: 5, max: 50
                  ), 
                  Slider(
                    value: provider.addConstitution * 1.0, 
                    onChanged: (val) => provider.updateAddConstitution(val.round()),
                    label: '+${provider.addConstitution.round()}',
                    divisions: 20, min: 0, max: 20
                  ), 
                  "Constitution"
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text('Former Constitution: ${widget.formerCharacter.constitution}', style: const TextStyle(fontSize: 12)),
                ),
                //%%%%%%%%%%%%%%%%%%%%%%%%%% INTELLIGENCE %%%%%%%%%%%%%%%%%%%%%%%%%
                createDoubleSlider(
                  Slider(
                    value: provider.mainIntelligence * 1.0, 
                    onChanged: (val) => provider.updateMainIntelligence(val.round()),
                    label: provider.mainIntelligence.round().toString(),
                    divisions: 45, min: 5, max: 50
                  ), 
                  Slider(
                    value: provider.addIntelligence * 1.0, 
                    onChanged: (val) => provider.updateAddIntelligence(val.round()),
                    label: '+${provider.addIntelligence.round()}',
                    divisions: 20, min: 0, max: 20
                  ), 
                  "Intelligence"
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text('Former Intelligence: ${widget.formerCharacter.intelligence}', style: const TextStyle(fontSize: 12)),
                ),
                //%%%%%%%%%%%%%%%%%%%%%%%%%% WISDOM %%%%%%%%%%%%%%%%%%%%%%%%%
                createDoubleSlider(
                  Slider(
                    value: provider.mainWisdom * 1.0, 
                    onChanged: (val) => provider.updateMainWisdom(val.round()),
                    label: provider.mainWisdom.round().toString(),
                    divisions: 45, min: 5, max: 50
                  ), 
                  Slider(
                    value: provider.addWisdom * 1.0, 
                    onChanged: (val) => provider.updateAddWisdom(val.round()),
                    label: '+${provider.addWisdom.round()}',
                    divisions: 20, min: 0, max: 20
                  ), 
                  "Wisdom"
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text('Former Wisdom: ${widget.formerCharacter.wisdom}', style: const TextStyle(fontSize: 12)),
                ),
                //%%%%%%%%%%%%%%%%%%%%%%%%%% CHARISMA %%%%%%%%%%%%%%%%%%%%%%%%%
                createDoubleSlider(
                  Slider(
                    value: provider.mainCharisma * 1.0, 
                    onChanged: (val) => provider.updateMainCharisma(val.round()),
                    label: provider.mainCharisma.round().toString(),
                    divisions: 45, min: 5, max: 50
                  ), 
                  Slider(
                    value: provider.addCharisma * 1.0, 
                    onChanged: (val) => provider.updateAddCharisma(val.round()),
                    label: '+${provider.addCharisma.round()}',
                    divisions: 20, min: 0, max: 20
                  ), 
                  "Charisma"
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text('Former Charisma: ${widget.formerCharacter.charisma}', style: const TextStyle(fontSize: 12)),
                ),
                const Padding(padding: EdgeInsets.only(top: 10.0, bottom: 10.0)),

                //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                //%%%%%%%%%%%%%%%%%%%%% WEAPON 1 %%%%%%%%%%%%%%%%%%%%%%%%
                //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                buildHeader("First Weapon"),
                //%%%%%%%%%%%%%%%%%%%%%%%%%% WEAPON 1 NAME %%%%%%%%%%%%%%%%%%%%%%%%%
                createParam(
                  _textControllerCharWeapon1Name, 
                  TextInputType.text, 
                  "Name", 
                  "Enter your first weapon's name",
                  "Former 1st Weapon: ${widget.formerCharacter.weapon1.name}",
                  "Max Characters: $maxCharactersName",
                  1,
                  Provider.of<StatsModel>(context).weapon1Name.length,
                  maxCharactersName
                ),
                //%%%%%%%%%%%%%%%%%%%%%%%%%% WEAPON 1 ATTACK %%%%%%%%%%%%%%%%%%%%%%%%%
                createSlider(
                  Slider(
                    value: provider.weapon1Attack * 1.0, 
                    onChanged: (val) => provider.updateWeapon1Attack(val.round()),
                    label: '+${provider.weapon1Attack.round()}',
                    divisions: 20, min: 0, max: 20
                  ), 
                  "Attack"
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text('Former Attack (Weapon 1): ${widget.formerCharacter.weapon1.attack}', style: const TextStyle(fontSize: 12)),
                ),
                //%%%%%%%%%%%%%%%%%%%%%%%%%% WEAPON 1 DAMAGE %%%%%%%%%%%%%%%%%%%%%%%%%
                createDoubleSlider(
                  Slider(
                    value: provider.weapon1Damage * 1.0,
                    onChanged: (val) => provider.updateWeapon1Damage(val.round()),
                    label: '+${provider.weapon1Damage.round()}',
                    divisions: 20, min: 0, max: 20,
                  ), 
                  DropdownMenu<DiceLabel>(
                    expandedInsets: const EdgeInsets.all(8.0),
                    controller: _textControllerCharWeapon1DamageDice,
                    label: const Text("Select Dice (Damage)"),
                    dropdownMenuEntries: DiceLabel.values
                      .map<DropdownMenuEntry<DiceLabel>>(
                        (DiceLabel dice) {
                          return DropdownMenuEntry<DiceLabel>(value: dice, label: dice.label);
                        }
                      ).toList(),
                  ), 
                  'Damage '
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 4),
                  child: Text('Former Damage (Weapon 1): ${widget.formerCharacter.weapon1.damage}', style: const TextStyle(fontSize: 12)),
                ),
                //%%%%%%%%%%%%%%%%%%%%%%%%%% WEAPON 1 DAMAGE TYPE %%%%%%%%%%%%%%%%%%%%%%%%%
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 20.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: DropdownMenu<DamageTypeLabel>(
                          expandedInsets: const EdgeInsets.all(8.0),
                          controller: _textControllerCharWeapon1DType,
                          label: const Text("Select Damage Type"),
                          dropdownMenuEntries: DamageTypeLabel.values
                              .map<DropdownMenuEntry<DamageTypeLabel>>(
                                (DamageTypeLabel dm) {
                                  return DropdownMenuEntry<DamageTypeLabel>(value: dm, label: dm.label);
                                }
                              ).toList(),
                        ),
                      ),
                    ]
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 4),
                  child: Text('Former Damage Type (Weapon 1): ${widget.formerCharacter.weapon1.type}', style: const TextStyle(fontSize: 12)),
                ),
                const Padding(padding: EdgeInsets.only(top: 10.0, bottom: 10.0)),

                //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                //%%%%%%%%%%%%%%%%%%%%% WEAPON 2 %%%%%%%%%%%%%%%%%%%%%%%%
                //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                buildHeader("Second Weapon"),
                //%%%%%%%%%%%%%%%%%%%%%%%%%% WEAPON 2 NAME %%%%%%%%%%%%%%%%%%%%%%%%%
                createParam(
                  _textControllerCharWeapon2Name, 
                  TextInputType.text, 
                  "Name", 
                  "Enter your first weapon's name",
                  "Former 2nd Weapon: ${widget.formerCharacter.weapon2.name}",
                  "Max Characters: $maxCharactersName",
                  1,
                  Provider.of<StatsModel>(context).weapon2Name.length,
                  maxCharactersName
                ),
                //%%%%%%%%%%%%%%%%%%%%%%%%%% WEAPON 2 ATTACK %%%%%%%%%%%%%%%%%%%%%%%%%
                createSlider(
                  Slider(
                    value: provider.weapon2Attack * 1.0, 
                    onChanged: (val) => provider.updateWeapon2Attack(val.round()),
                    label: '+${provider.weapon2Attack.round()}',
                    divisions: 20, min: 0, max: 20
                  ), 
                  "Attack"
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text('Former Attack (Weapon 2): ${widget.formerCharacter.weapon2.attack}', style: const TextStyle(fontSize: 12)),
                ),
                //%%%%%%%%%%%%%%%%%%%%%%%%%% WEAPON 2 DAMAGE %%%%%%%%%%%%%%%%%%%%%%%%%
                createDoubleSlider(
                  Slider(
                    value: provider.weapon2Damage * 1.0,
                    onChanged: (val) => provider.updateWeapon2Damage(val.round()),
                    label: '+${provider.weapon2Damage.round()}',
                    divisions: 20, min: 0, max: 20,
                  ), 
                  DropdownMenu<DiceLabel>(
                    expandedInsets: const EdgeInsets.all(8.0),
                    controller: _textControllerCharWeapon2DamageDice,
                    label: const Text("Select Dice (Damage)"),
                    dropdownMenuEntries: DiceLabel.values
                      .map<DropdownMenuEntry<DiceLabel>>(
                        (DiceLabel dice) {
                          return DropdownMenuEntry<DiceLabel>(value: dice, label: dice.label);
                        }
                      ).toList(),
                  ), 
                  'Damage '
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text('Former Damage (Weapon 2): ${widget.formerCharacter.weapon2.damage}', style: const TextStyle(fontSize: 12)),
                ),
                //%%%%%%%%%%%%%%%%%%%%%%%%%% WEAPON 2 DAMAGE TYPE %%%%%%%%%%%%%%%%%%%%%%%%%
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 20.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: DropdownMenu<DamageTypeLabel>(
                          expandedInsets: const EdgeInsets.all(8.0),
                          controller: _textControllerCharWeapon2DType,
                          label: const Text("Select Damage Type"),
                          dropdownMenuEntries: DamageTypeLabel.values
                              .map<DropdownMenuEntry<DamageTypeLabel>>(
                                (DamageTypeLabel dm) {
                                  return DropdownMenuEntry<DamageTypeLabel>(value: dm, label: dm.label);
                                }
                              ).toList(),
                        ),
                      ),
                    ]
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text('Former Damage Type (Weapon 2): ${widget.formerCharacter.weapon2.type}', style: const TextStyle(fontSize: 12)),
                ),
                const Padding(padding: EdgeInsets.only(top: 10.0, bottom: 10.0)),

                //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                //%%%%%%%%%%%%%%%%%%%%%%% BADGES %%%%%%%%%%%%%%%%%%%%%%%%
                //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                buildHeader("Badge"),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 20.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: DropdownMenu<BadgesLabel>(
                          helperText: 'Former Badge: ${widget.formerCharacter.badge}',
                          expandedInsets: const EdgeInsets.all(8.0),
                          controller: _textControllerCharBadge,
                          label: const Text("Select Badge"),
                          dropdownMenuEntries: BadgesLabel.values
                            .map<DropdownMenuEntry<BadgesLabel>>(
                              (BadgesLabel badge) {
                                return DropdownMenuEntry<BadgesLabel>(
                                  value: badge, 
                                  label: badge.label, 
                                  leadingIcon: FutureBuilder(
                                    future: FileManager().loadImage(badge.label), 
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(child: CircularProgressIndicator());
                                      } else if (snapshot.hasData) {
                                        return SizedBox(width: 16, height: 16, child: snapshot.data);
                                      } else {
                                        return const Text('ERR');
                                      }
                                    }
                                  )
                                );
                              }
                            ).toList(),
                        ),
                      ),
                    ]
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FutureBuilder(
                    future: FileManager().loadImage(Provider.of<StatsModel>(context).badge), 
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasData) {
                        return SizedBox(width: 120, height: 120, child: snapshot.data);
                      } else {
                        return const Text('ERR');
                      }
                    }
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 10.0, bottom: 10.0)),

                //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                //%%%%%%%%%%%%%%%%%%%%% SUBMIT % %%%%%%%%%%%%%%%%%%%%%%%%
                //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) {
                        String txt = "Name: ${provider.characterName}\n";
                        txt += "Race: ${provider.raceName}\n";
                        txt += "Class: ${provider.className}\n";
                        txt += "Level: ${provider.levelNum}\n";
                        txt += "Background: ${provider.backgroundText}\n";
                        txt += "HP: ${provider.hp.start.round()}/${provider.hp.end.round()}\n";
                        txt += "AC: ${provider.ac}\n";
                        txt += "Speed: ${provider.speed}\n";
                        txt += "Initiative: ${provider.initiative}\n";
                        txt += "Strength: ${provider.mainStrength}(+${provider.addStrength})\n";
                        txt += "Dexterity: ${provider.mainDexterity}(+${provider.addDexterity})\n";
                        txt += "Constitution: ${provider.mainConstitution}(+${provider.addConstitution})\n";
                        txt += "Intelligence: ${provider.mainIntelligence}(+${provider.addIntelligence})\n";
                        txt += "Wisdom: ${provider.mainWisdom}(+${provider.addWisdom})\n";
                        txt += "Charisma: ${provider.mainCharisma}(+${provider.addCharisma})\n";
                        txt += "First Weapon: ${provider.weapon1Name}, Damage Dice: ${provider.weapon1DamageDice}\n";
                        txt += "Second Weapon: ${provider.weapon2Name}, Damage Dice: ${provider.weapon2DamageDice}\n";
                        txt += "Badge: ${provider.badge}";

                        return AlertDialog(
                          title: const Text('Update Character?'),
                          content: Text(txt),
                          actions: <Widget>[
                            TextButton(onPressed: () => Navigator.pop(context, 'Cancel'), child: const Text('Cancel')),
                            TextButton(
                              onPressed: () {
                                List<String> newCharacter = [
                                  provider.characterName, provider.raceName, provider.className, "${provider.levelNum}",
                                  provider.backgroundText, "${provider.hp.start.round()}/${provider.hp.end.round()}", "${provider.ac}",
                                  "${provider.speed}", "${provider.initiative}", '${provider.mainStrength}(+${provider.addStrength})', 
                                  '${provider.mainDexterity}(+${provider.addDexterity})',
                                  '${provider.mainConstitution}(+${provider.addConstitution})',
                                  '${provider.mainIntelligence}(+${provider.addIntelligence})',
                                  '${provider.mainWisdom}(+${provider.addWisdom})',
                                  '${provider.mainCharisma}(+${provider.addCharisma})',
                                  provider.weapon1Name, provider.weapon2Name, "0", provider.badge
                                ];
                                
                                List<String> newWeapon1 = [
                                  provider.weapon1Name,
                                  '+${provider.weapon1Attack}',
                                  '${provider.weapon1DamageDice} + ${provider.weapon1Damage}',
                                  provider.weapon1DType,
                                ];

                                List<String> newWeapon2 = [
                                  provider.weapon2Name,
                                  '+${provider.weapon2Attack}',
                                  '${provider.weapon2DamageDice} + ${provider.weapon2Damage}',
                                  provider.weapon2DType,
                                ];

                                // push to database
                                widget.dbService.updateCharacter(newCharacter, newWeapon1, newWeapon2, widget.formerCharacter.name);
                                // pop out of alert
                                Navigator.pop(context, 'OK');
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      }
                    ),
                    child: const Text("Update Character")
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}