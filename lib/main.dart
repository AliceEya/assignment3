import 'package:eya_assignment3/shopBox.dart';
import 'package:eya_assignment3/shopscreen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main () async{
  await Hive.initFlutter();
  shopBox = await Hive.openBox('shopping');
  runApp(Shopping());
}
class Shopping extends StatelessWidget {
  const Shopping({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: ShoppingScreen(),
      );
  }
}



