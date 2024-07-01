import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/app/my_app.dart';
import 'package:pokedex/services/settings.dart';

void main() {
  setup();
  runApp(const MyApp());
}

void setup() {
  // carregar banco de dados
  // registrar banco de dados?

  // registrar temas
  // registrar favoritos

  // carregar temas
  // carregar favoritos
  GetIt.I.registerSingleton<Settings>(Settings());
}