import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import 'dart:math' as math;

class DiceTuple {
  final int sides;
  final String name;
  DiceTuple(this.sides, this.name);
}

class Dice extends StatefulWidget {
  const Dice({super.key});

  @override
  State<Dice> createState() => _DiceState();
}

class _DiceState extends State<Dice> {
  static int _index = 5;
  static String _diceNumber = 'd20'; // Initialize with a starting value
  late ShakeDetector detector;
  List<DiceTuple> dice = 
    [
      DiceTuple(4,'d4'),
      DiceTuple(6,'d6'),
      DiceTuple(8,'d8'),
      DiceTuple(10,'d10'),
      DiceTuple(12,'d12'),
      DiceTuple(20,'d20'),
      DiceTuple(100,'d100'),
    ];
  
  @override
  void initState() {
    super.initState();
    detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        rtd();
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 1000,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 1.2, // smaller = more sensitive
    );
  }

  @override
  void dispose() {
    super.dispose();
    detector.stopListening();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) { 
          return Stack(
            children: [
              Flex( // Flex the choice list to avoid overflow
                mainAxisAlignment: MainAxisAlignment.center,
                direction: orientation == Orientation.portrait ? Axis.vertical : Axis.horizontal,
                children: List<Widget>.generate( // Generate list of dice choices
                  7,
                  (int idx) {
                    return ChoiceChip(
                      padding: const EdgeInsets.all(10),
                      showCheckmark: false,
                      label: Text(dice.elementAt(idx).name), 
                      selected: _index == idx,
                      onSelected: (bool selected) {
                        _index = selected ? idx : _index;
                        if (selected) { // Resets the number to the selected die only when a new die is selected
                          _diceNumber = 'd${dice.elementAt(_index).sides}';
                        }
                        setState(() => _index);
                      },
                    );
                  },
                ).toList(),
              ),
              Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      _diceNumber,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: FloatingActionButton.extended( // Button to roll dice
                      label: const Text('Roll Dice'),
                      backgroundColor: Theme.of(context).focusColor,
                      onPressed: () {
                        rtd();
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  void rtd() { // roll the dice
    setState(() =>
     _diceNumber = (math.Random().nextInt(dice.elementAt(_index).sides) + 1).toString() // Generate new random number
    );
  }

}
