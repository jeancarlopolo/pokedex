import 'package:flutter/material.dart';
import 'package:pokedex/widgets/drawer.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(), // pesqiusa e filtro TODO

      drawer: const MyDrawer(),
      body: Container(),
    );
  }
}
