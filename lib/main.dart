import 'package:flutter/material.dart';
import 'package:nbt_team17/inventory/inventory.dart';
import 'package:nbt_team17/inventory/inventory_model.dart';
import 'package:nbt_team17/map/map_drawer.dart';
import 'package:nbt_team17/map/map_model.dart';
import 'package:nbt_team17/spells/spells.dart';
import 'package:nbt_team17/spells/spells_model.dart';
import 'package:nbt_team17/services/database_service.dart';
import 'package:nbt_team17/stats/stats_model.dart';
import 'package:provider/provider.dart';
import 'dice/dice.dart';
import 'map/map.dart';
import 'stats/stats_rules.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StatsModel()),
        ChangeNotifierProvider(create: (context) => MapModel()),
        ChangeNotifierProvider(create: (context) => SpellsModel()),
        ChangeNotifierProvider(create: (context) => InventoryModel()),
      ],
      child: MaterialApp(
        title: 'Tabletop Companion',
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false, // Turn off Debug banner
        home: _Home(),
      ),
    );
  }
}

class _Home extends StatefulWidget {
  @override
  State<_Home> createState() => _HomeState();
}

class _HomeState extends State<_Home> {
  int currentPageIndex = 1;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // # of tabs
      child: Scaffold(
          resizeToAvoidBottomInset: currentPageIndex == 0 ? false : true,
          drawer: currentPageIndex == 0
              ? SafeArea(
                  child: MapDrawer(
                  dbService: DatabaseService.instance,
                ))
              : null,
          bottomNavigationBar: NavigationBar(
            onDestinationSelected: (int index) => setState(() {
              currentPageIndex = index;
            }),
            selectedIndex: currentPageIndex,
            destinations: const <Widget>[
              // The tab's icon and label
              NavigationDestination(
                  icon: Icon(Icons.area_chart_sharp), label: 'Map'),
              NavigationDestination(
                  icon: Icon(Icons.bar_chart), label: 'Stats | Inventory'),
              NavigationDestination(
                  icon: Icon(Icons.rotate_90_degrees_ccw_sharp), label: 'Dice')
            ],
          ),
          body: SafeArea(
            child: <Widget>[
              // The tab's widgets
              const MapPage(),
              _RulesStatsPageView(),
              const Dice(),
            ][currentPageIndex],
          )),
    );
  }
}

class _RulesStatsPageView extends StatefulWidget {
  _RulesStatsPageView();
  final controller = PageController(initialPage: 0);

  @override
  State<_RulesStatsPageView> createState() => _RulesStatsPageViewState();
}

class _RulesStatsPageViewState extends State<_RulesStatsPageView> {
  DatabaseService? dbService;

  @override
  void initState() {
    dbService = DatabaseService.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: widget.controller,
      children: [
        Stats(dbService: dbService!),
        const Inventory(),
        const Spells(),
      ],
    );
  }
}
