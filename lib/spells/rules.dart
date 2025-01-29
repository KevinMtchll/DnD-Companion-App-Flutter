import 'package:flutter/material.dart';

class Rules extends StatefulWidget {
  const Rules({super.key});
  //final DatabaseService dbService;

  @override
  State<Rules> createState() => _RulesState();
}

class _RulesState extends State<Rules> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Rules")),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Players:",
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 8),
                      Expanded(
                        child: TextField(
                          maxLines: null,
                          expands: true,
                          textAlignVertical: TextAlignVertical.top,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText:
                                  '- Player Name 1\n- Player Name 2\n- Player Name 3...',
                              hintMaxLines: null),
                        ),
                      )
                    ])),
            SizedBox(height: 20),
            Expanded(
                flex: 2,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Rules:",
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 8),
                      Expanded(
                        child: TextField(
                          maxLines: null,
                          expands: true,
                          textAlignVertical: TextAlignVertical.top,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Add custom rules here...'),
                        ),
                      )
                    ])),
          ],
        ),
      ),
    );
  }
}
