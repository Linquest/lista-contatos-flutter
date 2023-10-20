import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'appTitle': 'ContApp',
      'addContact': 'Add Contact',
      'editContact': 'Edit Contact',
      'contactList': 'Contact List',
      // Adicione mais chaves e valores conforme necessário
    },
    'pt': {
      'appTitle': 'ContApp',
      'addContact': 'Adicionar Contato',
      'editContact': 'Editar Contato',
      'contactList': 'Lista de Contatos',
      // Adicione mais chaves e valores conforme necessário
    },
  };

  String get appTitle {
    return _localizedValues[locale.languageCode]['appTitle'];
  }

  String get addContact {
    return _localizedValues[locale.languageCode]['addContact'];
  }

  String get editContact {
    return _localizedValues[locale.languageCode]['editContact'];
  }

  String get contactList {
    return _localizedValues[locale.languageCode]['contactList'];
  }

  // Adicione métodos para mais chaves conforme necessário

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'pt'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}
