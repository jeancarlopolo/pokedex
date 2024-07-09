import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(backgroundColor: Theme.of(context).drawerTheme.backgroundColor, child: Column(),);
  }
}