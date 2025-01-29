import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class InventoryModel extends ChangeNotifier {
  Money _money;
  get money => _money;
  static const String moneyFileName = 'money.json';

  List<Item> _items;
  get items => _items;
  static const String itemsFileName = 'items.json';

  InventoryModel()
      : _money = Money(),
        _items = [] {
    loadMoney();
    loadItems();
  }

  Future<void> loadMoney() async {
    Directory dir = await getApplicationDocumentsDirectory();
    File file = File('${dir.path}/$moneyFileName');
    if (await file.exists()) {
      String data = await file.readAsString();
      Map<String, dynamic> json = jsonDecode(data);
      _money = Money.fromJson(json);
      notifyListeners();
    }
  }

  Future<File> saveMoney() async {
    Directory dir = await getApplicationDocumentsDirectory();
    File file = File('${dir.path}/$moneyFileName');
    final encoded = jsonEncode(_money);
    return await file.writeAsString(encoded);
  }

  Future<void> loadItems() async {
    Directory dir = await getApplicationDocumentsDirectory();
    File file = File('${dir.path}/$itemsFileName');
    if (await file.exists()) {
      String data = await file.readAsString();
      List<dynamic> jsonList = jsonDecode(data);
      _items = jsonList
          .map((item) => Item.fromJson(item as Map<String, dynamic>))
          .toList();
      notifyListeners();
    }
  }

  Future<File> saveItems() async {
    Directory dir = await getApplicationDocumentsDirectory();
    File file = File('${dir.path}/$itemsFileName');
    final json = _items.map((item) => item.toJson()).toList();
    final encoded = jsonEncode(json);
    return await file.writeAsString(encoded);
  }

  void changeAmount(Coin coin, int amount) {
    _money.changeAmount(coin, amount);
    notifyListeners();
    saveMoney();
  }

  void resetMoney(Coin coin) {
    _money.resetCoin(coin);
    notifyListeners();
    saveMoney();
  }

  int getCoinAmount(Coin coin) {
    return _money.getCoinAmount(coin);
  }

  void addItem(String name, String description, int quantity) {
    int quant = quantity < 0 ? 0 : quantity;
    Item item = Item(name: name, description: description, quantity: quant);
    _items.add(item);
    notifyListeners();
    saveItems();
  }

  void removeItem(String name, int quantity) {
    for (var item in _items) {
      if (item.name == name && quantity < item.quantity) {
        item.setQuantity(item.quantity - quantity);
        notifyListeners();
        saveItems();
        return;
      }
    }
    _items.removeWhere((item) => item.name == name);

    notifyListeners();
    saveItems();
  }

  ListView getItemsListView() {
    return ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          Item item = _items[index];
          return item.getItemListTile();
        });
  }
}

enum Coin {
  gold(name: "Gold", shorthand: "GP"),
  silver(name: "Silver", shorthand: "SP"),
  copper(name: "Copper", shorthand: "CP");

  const Coin({required this.name, required this.shorthand});

  final String name;
  final String shorthand;
}

class Money {
  int gold;
  int silver;
  int copper;

  Money({this.gold = 0, this.silver = 0, this.copper = 0});

  void changeAmount(Coin coin, int amount) {
    switch (coin) {
      case Coin.gold:
        gold = (gold + amount).clamp(0, double.infinity).toInt();
        break;
      case Coin.silver:
        silver = (silver + amount).clamp(0, double.infinity).toInt();
        break;
      case Coin.copper:
        copper = (copper + amount).clamp(0, double.infinity).toInt();
        break;
    }
  }

  void resetCoin(Coin coin) {
    gold = 0;
    silver = 0;
    copper = 0;
  }

  int getCoinAmount(Coin coin) {
    switch (coin) {
      case Coin.gold:
        return gold;
      case Coin.silver:
        return silver;
      case Coin.copper:
        return copper;
    }
  }

  Money.fromJson(Map<String, dynamic> json)
      : gold = json[Coin.gold.name] as int,
        silver = json[Coin.silver.name] as int,
        copper = json[Coin.copper.name] as int;

  Map<String, dynamic> toJson() => {
        Coin.gold.name: gold,
        Coin.silver.name: silver,
        Coin.copper.name: copper
      };
}

class Item {
  final String name;
  final String description;
  int quantity;

  Item({required this.name, required this.description, this.quantity = 1});

  void setQuantity(int quantity) {
    if (quantity < 0) {
      this.quantity = 0;
    } else {
      this.quantity = quantity;
    }
  }

  ListTile getItemListTile() {
    return ListTile(title: Text(name), trailing: Text(quantity.toString()));
  }

  Item.fromJson(Map<String, dynamic> json)
      : name = json["name"] as String,
        description = json["description"] as String,
        quantity = json["quantity"] as int;

  Map<String, dynamic> toJson() =>
      {"name": name, "description": description, "quantity": quantity};
}
