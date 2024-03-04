import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:npstock/controller/detail_controller.dart';
import 'package:npstock/controller/ticker_controller.dart';
import 'package:npstock/screens/home_screen/home_screen.dart';
import 'package:npstock/styles/themes.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TickerController(),
        ),
        ChangeNotifierProvider(
          create: (_) => DetailController(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: theme,
        home: const HomeScreen(),
      ),
    );
  }
}
