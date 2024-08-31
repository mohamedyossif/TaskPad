import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static const _lang = 'LANG';
  static const _hasUserSeenIntro = "onBoarding";

  static Future<bool> setOnboarding(bool hasUserSeenIntro) async {
    var preference = await SharedPreferences.getInstance();
    return await preference.setBool(_hasUserSeenIntro, hasUserSeenIntro);
  }

  static Future<bool> getOnboarding() async {
    var preference = await SharedPreferences.getInstance();
    return preference.getBool(_hasUserSeenIntro) ?? false;
  }

  static Future<Locale> setLanguage(String languageCode) async {
    var preference = await SharedPreferences.getInstance();
    await preference.setString(_lang, languageCode);
    return _locale(languageCode);
  }

  static Future<Locale> getLanguage() async {
    var preference = await SharedPreferences.getInstance();
    String langCode = preference.getString(_lang) ?? 'en';
    return _locale(langCode);
  }

  static Locale _locale(String langCode) {
    switch (langCode) {
      case 'en':
        return const Locale('en');
      case 'ar':
        return const Locale('ar');
      default:
        return const Locale('en');
    }
  }
}
