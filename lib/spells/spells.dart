import 'package:flutter/material.dart';
import 'package:nbt_team17/spells/spells_model.dart';
import 'package:provider/provider.dart';

class Spells extends StatefulWidget {
  const Spells({super.key});
  //final DatabaseService dbService;

  @override
  State<Spells> createState() => _SpellsState();
}

class _SpellsState extends State<Spells> {
  int selectedLevel = 0;

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<SpellsModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Spell Slots')),
      body: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          DropdownButton<int>(
            value: selectedLevel,
            items: List.generate(10, (index) {
              return DropdownMenuItem(
                value: index,
                child: Text('Level ${index + 1}'),
              );
            }),
            onChanged: (int? value) {
              setState(() {
                selectedLevel = value!;
              });
            },
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              setState(() {
                model.addSpellSlot(selectedLevel);
              });
            },
            child: const Text('Add'),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              setState(() {
                model.removeSpellSlot(selectedLevel);
              });
            },
            child: const Text('Remove'),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              setState(() {
                model.resetSpellSlots();
              });
            },
            child: const Text('Reset'),
          ),
        ]),
        Expanded(
          child: ListView.builder(
            itemCount: model.getSpellSlots().length,
            itemBuilder: (context, level) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Level ${level + 1} Slots'),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: model.getSpellSlots()[level].length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context, index) {
                      bool isAvailable = model.getSpellSlot(level, index);
                      return GestureDetector(
                        onTap: isAvailable
                            ? () {
                                setState(() {
                                  model.setSpellSlotFalse(level, index);
                                });
                              }
                            : null,
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: isAvailable ? Colors.green : Colors.grey,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black),
                          ),
                          child: Center(
                            child: Text(
                              isAvailable ? 'Available' : 'Used',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ]),
    );
  }
}
