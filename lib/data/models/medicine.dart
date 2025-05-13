import 'package:pilula_em_ponto/data/models/dose.dart';
import 'package:uuid/uuid.dart';

class Medicine {
  final String id;
  Medicine({required this.name, this.dose}) : id = Uuid().v4();

  final String name;
  final Dose? dose;
}
