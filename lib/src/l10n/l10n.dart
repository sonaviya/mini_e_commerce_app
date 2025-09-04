import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class AppLocalizations {
  static const supportedLocales = [Locale('en'), Locale('es')];
  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) => Localizations.of<AppLocalizations>(context, AppLocalizations)!;

  String get title => Intl.message('Mini E-Commerce', name: 'title');
  String get addToCart => Intl.message('Add to cart', name: 'addToCart');
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();
  @override bool isSupported(Locale locale) => ['en', 'es'].contains(locale.languageCode);
  @override Future<AppLocalizations> load(Locale locale) async {
    Intl.defaultLocale = locale.languageCode;
    return AppLocalizations();
  }
  @override bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) => false;
}
