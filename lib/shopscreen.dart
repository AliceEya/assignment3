import 'package:eya_assignment3/shopBox.dart';
import 'package:flutter/material.dart';

class ShoppingScreen extends StatefulWidget {
      ShoppingScreen({super.key});

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
var shoppingInput = TextEditingController();


void checkAllItems() {
  setState(() {
    for (var i = 0; i < shopBox.length; i++) {
      var shopping = shopBox.getAt(i);
      shopBox.putAt(i, {'item': shopping['item'], 'isChecked': true});
    }
  });
}

void addToList() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        shopBox.add({
          'item': shoppingInput.text,
          'isChecked': false,
        });
        shoppingInput.clear();
      });
    }
  }


void clearList() {
    setState(() {
      var items = shopBox.keys.toList();
      for (var key in items) {
        var item = shopBox.get(key);
        if (item['isChecked']) {
          shopBox.delete(key);
        }
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(onPressed: checkAllItems,
        icon: const Icon(Icons.check_circle_outline_outlined)),
        title: const Text('Shopping List',
          style: TextStyle(fontSize: 25),
          ),
        actions:[IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: clearList,
                ),
                ],
        centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
              key: _formKey,
          child: Column(children: [ 
                          Card(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                  TextFormField(
                                  controller: shoppingInput,
                                  style:const TextStyle(fontSize: 25,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  label: Text('Item'),
                                  ),
                                  validator: (value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Please enter an item.';
                        }
                        return null;
                      },          
                                ),
                                TextButton(onPressed: addToList,
                                          child: const Text('ADD',
                                          style: TextStyle(
                                          fontSize: 20,
                                          ),
                                        ),
                                      ), 
                                    ],
                                  ),
                                ),
                  Expanded(
                        child: ListView.builder(
                          itemCount: shopBox.length,
                          itemBuilder: (_,index){
                            var shopping = shopBox.getAt(index);
                            return Card(
                                    child: ListTile(
                                    title: Text(shopping['item'],
                                            style: TextStyle(
                                            decoration: shopping['isChecked']
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none,
                                        ),
                                      ),
                                      trailing: Checkbox(value: shopping['isChecked'],
                                      onChanged: (value) {
                                    setState(() {shopBox.putAt(index,
                                  {'item': shopping['item'],'isChecked': value!});
                               });
                            },
                          ),
                        ),
                      );
                    },
                 ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}









