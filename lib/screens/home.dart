import 'package:pilula_em_ponto/screens/new_medicine/new_medicine.dart';
import 'package:pilula_em_ponto/themes/main_colors.dart';
import 'package:flutter/material.dart';
import 'package:pilula_em_ponto/widgets/medicine_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget _contentBody({required BuildContext context}) {
    return Stack(children: [MedicineList(), _addButton(context: context)]);
  }

  void _onAddButton({required BuildContext context}) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (ctx) => NewMedicineScreen()));
  }

  Widget _addButton({required BuildContext context}) {
    return Positioned(
      bottom: 45,
      right: 30,
      child: FloatingActionButton.extended(
        backgroundColor: kPrimaryColor,
        foregroundColor: kOnContainer,
        onPressed: () => _onAddButton(context: context),
        icon: const Icon(Icons.add, size: 30),
        label: const Text(
          'Adicionar',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Remédio em Ponto',
          style: TextStyle(fontSize: 26, color: Colors.white),
        ),
        backgroundColor: kPrimaryColor,
        foregroundColor: kOnContainer,
      ),
      body: _contentBody(context: context),
    );
  }
}
