import 'package:app_ordem_servico/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:app_ordem_servico/app_module.dart';

void main() {
  runApp(ModularApp(module: AppModule(), child: Login()));
}