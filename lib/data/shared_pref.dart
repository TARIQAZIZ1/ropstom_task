import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{

  static SharedPreferences? instance;

  static Future <void>init()async {
   var shared = await  SharedPreferences.getInstance();
  instance = shared;

  }
}