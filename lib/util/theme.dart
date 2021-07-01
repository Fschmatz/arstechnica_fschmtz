import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//CLARO
ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFFF1F1F3),
    accentColor: Color(0xFFE6753B),
    scaffoldBackgroundColor: Color(0xFFF1F1F3),
    cardTheme: CardTheme(
      color: Color(0xFFFFFFFF),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Color(0xFFFFFFFF),
    ),
    bottomAppBarColor: Color(0xFFE5E5E7),
   );

//ESCURO
ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color(0xFF202022),
    accentColor: Color(0xFFE6753B),
    scaffoldBackgroundColor: Color(0xFF202022),
    cardTheme: CardTheme(
      color: Color(0xFF29292B),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Color(0xFF252527),
    ),
    bottomAppBarColor: Color(0xFF171719),
    );

class ThemeNotifier extends ChangeNotifier {
  final String key = 'valorTema';
  SharedPreferences prefs;
  bool _darkTheme;

  bool get darkTheme => _darkTheme;

  ThemeNotifier() {
    _darkTheme = true;
    _loadFromPrefs();
  }

  toggleTheme() {
    _darkTheme = !_darkTheme;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
  }

  _loadFromPrefs() async {
    await _initPrefs();
    _darkTheme = prefs.getBool(key) ?? true;
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    prefs.setBool(key, _darkTheme);
  }
}
