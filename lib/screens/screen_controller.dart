import 'package:pilula_em_ponto/screens/home.dart';
import 'package:flutter/material.dart';

class ScreenController extends StatefulWidget {
  const ScreenController({super.key});

  @override
  State<StatefulWidget> createState() => _ScreenControllerState();
}

class _ScreenControllerState extends State<ScreenController> {
  @override
  Widget build(BuildContext context) {
    return Home();
  }
}
