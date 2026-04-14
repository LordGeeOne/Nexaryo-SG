import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  bool _oneHandedMode = false;
  int _oneHandedHintCount = 0;
  String _userName = '';

  bool get oneHandedMode => _oneHandedMode;
  int get oneHandedHintCount => _oneHandedHintCount;
  String get userName => _userName;

  set oneHandedMode(bool value) {
    _oneHandedMode = value;
    notifyListeners();
    _save();
  }

  set userName(String value) {
    _userName = value;
    notifyListeners();
    _save();
  }

  void incrementOneHandedHintCount() {
    _oneHandedHintCount++;
    notifyListeners();
    _save();
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _oneHandedMode = prefs.getBool('oneHandedMode') ?? false;
    _oneHandedHintCount = prefs.getInt('oneHandedHintCount') ?? 0;
    _userName = prefs.getString('userName') ?? '';
    notifyListeners();
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('oneHandedMode', _oneHandedMode);
    await prefs.setInt('oneHandedHintCount', _oneHandedHintCount);
    await prefs.setString('userName', _userName);
  }
}
