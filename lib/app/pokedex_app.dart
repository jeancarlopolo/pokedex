import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/constants/themes.dart';
import 'package:pokedex/pages/page.dart';
import 'package:pokedex/services/settings.dart';
import 'package:signals/signals_flutter.dart';

class PokedexApp extends StatefulWidget {
  const PokedexApp({super.key});

  @override
  State<PokedexApp> createState() => _PokedexAppState();
}

class _PokedexAppState extends State<PokedexApp> {
  @override
  void initState() {
    super.initState();
    currentTheme = GetIt.I<Settings>().darkMode;
  }

  late final Signal<bool> currentTheme;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pókedex',
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: currentTheme.watch(context) ? ThemeMode.dark : ThemeMode.light,
      home: MyPage(),
    );
  }
}
