import 'package:flutter/material.dart';
import 'package:routing_example/app_router.dart';
import 'package:routing_example/base_screen.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  // to remove # from the URL
  setPathUrlStrategy();

  // to initialize the app router
  AppRouter().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // define your go router here
      routerConfig: AppRouter().goRouter,
    );
  }
}
