import 'package:flutter/material.dart';
import 'package:nbt_team17/inventory/inventory_model.dart';
import 'package:provider/provider.dart';

class Inventory extends StatefulWidget {
  const Inventory({super.key});
  //final DatabaseService dbService;

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  Widget _moneyRow(Coin coin, int value, InventoryModel model) {
    return Column(
      children: [
        Text(
          '${coin.shorthand}: $value',
          style: const TextStyle(fontSize: 18),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                textStyle: const TextStyle(fontSize: 12),
                minimumSize: const Size(40, 30),
              ),
              onPressed: () => model.changeAmount(coin, -100),
              child: const Text('-100'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                textStyle: const TextStyle(fontSize: 12),
                minimumSize: const Size(40, 30),
              ),
              onPressed: () => model.changeAmount(coin, -10),
              child: const Text('-10'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                textStyle: const TextStyle(fontSize: 12),
                minimumSize: const Size(40, 30),
              ),
              onPressed: () => model.changeAmount(coin, -1),
              child: const Text('-1'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                textStyle: const TextStyle(fontSize: 12),
                minimumSize: const Size(40, 30),
              ),
              onPressed: () => model.changeAmount(coin, 1),
              child: const Text('+1'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                textStyle: const TextStyle(fontSize: 12),
                minimumSize: const Size(40, 30),
              ),
              onPressed: () => model.changeAmount(coin, 10),
              child: const Text('+10'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                textStyle: const TextStyle(fontSize: 12),
                minimumSize: const Size(40, 30),
              ),
              onPressed: () => model.changeAmount(coin, 100),
              child: const Text('+100'),
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  Widget _addItemForm(InventoryModel model) {
    return Form(
        key: _formKey,
        child: ListView(children: [
          TextFormField(
              decoration: const InputDecoration(hintText: 'Item name...'),
              controller: nameController,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a valid name';
                }
                return null;
              }),
          TextFormField(
              decoration:
                  const InputDecoration(hintText: 'Item description...'),
              controller: descriptionController,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a valid description';
                }
                return null;
              }),
          TextFormField(
              decoration: const InputDecoration(hintText: 'Item quantity...'),
              controller: quantityController,
              keyboardType: TextInputType.number,
              validator: (String? value) {
                if (value == null ||
                    value.isEmpty ||
                    int.tryParse(value) == null) {
                  return 'Please enter a valid quantity';
                }
                return null;
              }),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        int quantity = int.parse(quantityController.text);
                        String name = nameController.text;
                        String description = descriptionController.text;

                        model.addItem(name, description, quantity);
                      }
                    },
                    child: const Text("Add"))),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        int quantity = int.parse(quantityController.text);
                        String name = nameController.text;

                        model.removeItem(name, quantity);
                      }
                    },
                    child: const Text("Remove")))
          ]),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    final InventoryModel model = Provider.of<InventoryModel>(context);
    List<Item> items = model.items;

    return Scaffold(
      appBar: AppBar(title: const Text("Inventory")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _moneyRow(Coin.gold, model.getCoinAmount(Coin.gold), model),
            _moneyRow(Coin.silver, model.getCoinAmount(Coin.silver), model),
            _moneyRow(Coin.copper, model.getCoinAmount(Coin.copper), model),
            Expanded(
              flex: 1,
              child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    Item item = items[index];
                    return ListTile(
                        title: Text(item.name),
                        trailing: Text(item.quantity.toString()),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const ItemDetailsView(),
                              settings: RouteSettings(
                                  arguments: [items[index], model])));
                        });
                  }),
            ),
            Expanded(flex: 2, child: _addItemForm(model)),
          ],
        ),
      ),
    );
  }
}

class ItemDetailsView extends StatelessWidget {
  const ItemDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    final item = args[0] as Item;
    final model = args[1] as InventoryModel;

    return Scaffold(
        appBar: AppBar(
          title: Text(item.name),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(item.description)])));
  }
}
