import 'dart:convert';

import 'package:mobx/mobx.dart';

part 'translator.g.dart';

class Translator = _Translator with _$Translator;

abstract class _Translator with Store {
  // Future<bool> load() async {
  //   // Load the language JSON file from the "lang" folder
  //   String jsonString =
  //   await rootBundle.loadString('i18n/${locale.languageCode}.json');
  //   Map<String, dynamic> jsonMap = json.decode(jsonString);

  //   _localizedStrings = jsonMap.map((key, value) {
  //     return MapEntry(key, value.toString());
  //   });

  //   return true;
  // }
}
