import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get backendUrl => dotenv.get('BACKEND_URL');

  static Future<void> init() async {
    await dotenv.load(fileName: '.env');
  }
}
