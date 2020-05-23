// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translator.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Translator on _Translator, Store {
  Computed<Locale> _$localeComputed;

  @override
  Locale get locale =>
      (_$localeComputed ??= Computed<Locale>(() => super.locale)).value;
  Computed<String> _$titleComputed;

  @override
  String get title =>
      (_$titleComputed ??= Computed<String>(() => super.title)).value;
  Computed<String> _$currentBetComputed;

  @override
  String get currentBet =>
      (_$currentBetComputed ??= Computed<String>(() => super.currentBet)).value;
  Computed<String> _$playAgainComputed;

  @override
  String get playAgain =>
      (_$playAgainComputed ??= Computed<String>(() => super.playAgain)).value;
  Computed<String> _$newGameComputed;

  @override
  String get newGame =>
      (_$newGameComputed ??= Computed<String>(() => super.newGame)).value;
  Computed<String> _$calculateComputed;

  @override
  String get calculate =>
      (_$calculateComputed ??= Computed<String>(() => super.calculate)).value;
  Computed<String> _$betComputed;

  @override
  String get bet => (_$betComputed ??= Computed<String>(() => super.bet)).value;
  Computed<String> _$undoComputed;

  @override
  String get undo =>
      (_$undoComputed ??= Computed<String>(() => super.undo)).value;
  Computed<String> _$redoComputed;

  @override
  String get redo =>
      (_$redoComputed ??= Computed<String>(() => super.redo)).value;
  Computed<String> _$doubleComputed;

  @override
  String get double =>
      (_$doubleComputed ??= Computed<String>(() => super.double)).value;
  Computed<String> _$redoubleComputed;

  @override
  String get redouble =>
      (_$redoubleComputed ??= Computed<String>(() => super.redouble)).value;
  Computed<String> _$team1Computed;

  @override
  String get team1 =>
      (_$team1Computed ??= Computed<String>(() => super.team1)).value;
  Computed<String> _$team2Computed;

  @override
  String get team2 =>
      (_$team2Computed ??= Computed<String>(() => super.team2)).value;
  Computed<String> _$cancelComputed;

  @override
  String get cancel =>
      (_$cancelComputed ??= Computed<String>(() => super.cancel)).value;
  Computed<String> _$languageComputed;

  @override
  String get language =>
      (_$languageComputed ??= Computed<String>(() => super.language)).value;
  Computed<String> _$trickNumberComputed;

  @override
  String get trickNumber =>
      (_$trickNumberComputed ??= Computed<String>(() => super.trickNumber))
          .value;
  Computed<String> _$suitComputed;

  @override
  String get suit =>
      (_$suitComputed ??= Computed<String>(() => super.suit)).value;
  Computed<String> _$teamComputed;

  @override
  String get team =>
      (_$teamComputed ??= Computed<String>(() => super.team)).value;
  Computed<String> _$multiplierComputed;

  @override
  String get multiplier =>
      (_$multiplierComputed ??= Computed<String>(() => super.multiplier)).value;
  Computed<String> _$howToPlayComputed;

  @override
  String get howToPlay =>
      (_$howToPlayComputed ??= Computed<String>(() => super.howToPlay)).value;
  Computed<String> _$creditsComputed;

  @override
  String get credits =>
      (_$creditsComputed ??= Computed<String>(() => super.credits)).value;
  Computed<String> _$noTrickSelectedComputed;

  @override
  String get noTrickSelected => (_$noTrickSelectedComputed ??=
          Computed<String>(() => super.noTrickSelected))
      .value;
  Computed<String> _$noSuitSelectedComputed;

  @override
  String get noSuitSelected => (_$noSuitSelectedComputed ??=
          Computed<String>(() => super.noSuitSelected))
      .value;

  final _$_localeAtom = Atom(name: '_Translator._locale');

  @override
  Locale get _locale {
    _$_localeAtom.context.enforceReadPolicy(_$_localeAtom);
    _$_localeAtom.reportObserved();
    return super._locale;
  }

  @override
  set _locale(Locale value) {
    _$_localeAtom.context.conditionallyRunInAction(() {
      super._locale = value;
      _$_localeAtom.reportChanged();
    }, _$_localeAtom, name: '${_$_localeAtom.name}_set');
  }

  final _$localizedStringsAtom = Atom(name: '_Translator.localizedStrings');

  @override
  ObservableMap<String, Map<String, String>> get localizedStrings {
    _$localizedStringsAtom.context.enforceReadPolicy(_$localizedStringsAtom);
    _$localizedStringsAtom.reportObserved();
    return super.localizedStrings;
  }

  @override
  set localizedStrings(ObservableMap<String, Map<String, String>> value) {
    _$localizedStringsAtom.context.conditionallyRunInAction(() {
      super.localizedStrings = value;
      _$localizedStringsAtom.reportChanged();
    }, _$localizedStringsAtom, name: '${_$localizedStringsAtom.name}_set');
  }

  final _$loadAsyncAction = AsyncAction('load');

  @override
  Future<bool> load() {
    return _$loadAsyncAction.run(() => super.load());
  }

  @override
  String toString() {
    final string =
        'localizedStrings: ${localizedStrings.toString()},locale: ${locale.toString()},title: ${title.toString()},currentBet: ${currentBet.toString()},playAgain: ${playAgain.toString()},newGame: ${newGame.toString()},calculate: ${calculate.toString()},bet: ${bet.toString()},undo: ${undo.toString()},redo: ${redo.toString()},double: ${double.toString()},redouble: ${redouble.toString()},team1: ${team1.toString()},team2: ${team2.toString()},cancel: ${cancel.toString()},language: ${language.toString()},trickNumber: ${trickNumber.toString()},suit: ${suit.toString()},team: ${team.toString()},multiplier: ${multiplier.toString()},howToPlay: ${howToPlay.toString()},credits: ${credits.toString()},noTrickSelected: ${noTrickSelected.toString()},noSuitSelected: ${noSuitSelected.toString()}';
    return '{$string}';
  }
}
