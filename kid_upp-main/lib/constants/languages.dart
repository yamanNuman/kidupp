import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class Language {
  final int id;
  final String flag;
  final String name;
  final String languageCode;

  Language(this.id, this.flag, this.name, this.languageCode);

  static List<Language> languageList() {
    return <Language>[
      Language(1, "🇹🇷", "Türkçe", "tr"),
      Language(2, "🏴󠁧󠁢󠁥󠁮󠁧󠁿", "English", "en"),
      Language(3, "🇩🇪", "Deutsch", "de")
      ];
  }
}

const String LAGUAGE_CODE = 'languageCode';

//languages code
const String ENGLISH = 'en';
const String TURKISH = 'tr';
const String DEUTSCH = 'de';


Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(LAGUAGE_CODE, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(LAGUAGE_CODE) ?? ENGLISH;
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case ENGLISH:
      return const Locale(ENGLISH, '');
    case TURKISH:
      return const Locale(TURKISH, "");
    case DEUTSCH:
      return const Locale(DEUTSCH, "");
    default:
      return const Locale(ENGLISH, '');
  }
}

AppLocalizations translation(BuildContext context) {
  return AppLocalizations.of(context)!;
}

