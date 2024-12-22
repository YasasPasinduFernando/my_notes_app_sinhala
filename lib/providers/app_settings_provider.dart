import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../l10n/app_localizations.dart';

class AppSettingsProvider extends ChangeNotifier {
  late SharedPreferences _prefs;
  late bool _isDarkMode;
  late String _languageCode;
  late AppLocalizations _localizations;

  bool get isDarkMode => _isDarkMode;
  String get languageCode => _languageCode;
  AppLocalizations get localizations => _localizations;

  AppSettingsProvider() {
    _isDarkMode = false;
    _languageCode = 'en';
    _localizations = AppLocalizations('en');
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    _prefs = await SharedPreferences.getInstance();
    _isDarkMode = _prefs.getBool('isDarkMode') ?? false;
    _languageCode = _prefs.getString('languageCode') ?? 'en';
    _localizations = AppLocalizations(_languageCode);
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    await _prefs.setBool('isDarkMode', _isDarkMode);
    notifyListeners();
  }

  Future<void> setLanguage(String languageCode) async {
    _languageCode = languageCode;
    _localizations = AppLocalizations(languageCode);
    await _prefs.setString('languageCode', languageCode);
    notifyListeners();
  }
}