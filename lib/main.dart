import 'package:flutter/material.dart';
import 'package:hive2/home_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  //hive database initialize
  Box box=await Hive.openBox("country-list");
  box.put("name", "Bangladesh");
  print(box.get("name"));

  runApp( MyApp());
}


class MyApp extends StatelessWidget {
   MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage()
    );
  }
}
