import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app_flutter/data/models/color.dart';
import 'package:todo_app_flutter/ui/screens/group_screen.dart';
import 'package:todo_app_flutter/ui_kit/_ui_kit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(3)) {
    Hive.registerAdapter(ColorAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        // canvasColor: Colors.white,
      ),
      home: ListScreen(),
    );
  }
}

