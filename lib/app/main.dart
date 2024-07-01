import 'package:flutter/material.dart';
import 'package:pokedex/app/my_app.dart';

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
  GetIt.I.registerSingleton<Themes>
}