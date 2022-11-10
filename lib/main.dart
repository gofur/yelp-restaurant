import 'package:flutter/material.dart';
import 'package:restaurant/config.dart';
import 'package:restaurant/home.dart';
import 'package:restaurant/service_locator.dart';

Future main() async {
  Future<void> _init() async {
    //set singleton config
    serviceLocator.registerSingleton<Config>(DevelopmentConfig());
  }
  initialize(_init);
}

void initialize(Function() envInit)  {
  WidgetsFlutterBinding.ensureInitialized();
  //call service locator
  envInit.call();
  initServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SuperIndo Apps',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}
