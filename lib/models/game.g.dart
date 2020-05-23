// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Game on _Game, Store {
  Computed<Bet> _$currentBetComputed;

  @override
  Bet get currentBet =>
      (_$currentBetComputed ??= Computed<Bet>(() => super.currentBet)).value;

  final _$teamsAtom = Atom(name: '_Game.teams');

  @override
  ObservableList<Team> get teams {
    _$teamsAtom.context.enforceReadPolicy(_$teamsAtom);
    _$teamsAtom.reportObserved();
    return super.teams;
  }

  @override
  set teams(ObservableList<Team> value) {
    _$teamsAtom.context.conditionallyRunInAction(() {
      super.teams = value;
      _$teamsAtom.reportChanged();
    }, _$teamsAtom, name: '${_$teamsAtom.name}_set');
  }

  final _$betsAtom = Atom(name: '_Game.bets');

  @override
  ObservableList<Bet> get bets {
    _$betsAtom.context.enforceReadPolicy(_$betsAtom);
    _$betsAtom.reportObserved();
    return super.bets;
  }

  @override
  set bets(ObservableList<Bet> value) {
    _$betsAtom.context.conditionallyRunInAction(() {
      super.bets = value;
      _$betsAtom.reportChanged();
    }, _$betsAtom, name: '${_$betsAtom.name}_set');
  }

  final _$undoneBetsAtom = Atom(name: '_Game.undoneBets');

  @override
  ObservableList<Bet> get undoneBets {
    _$undoneBetsAtom.context.enforceReadPolicy(_$undoneBetsAtom);
    _$undoneBetsAtom.reportObserved();
    return super.undoneBets;
  }

  @override
  set undoneBets(ObservableList<Bet> value) {
    _$undoneBetsAtom.context.conditionallyRunInAction(() {
      super.undoneBets = value;
      _$undoneBetsAtom.reportChanged();
    }, _$undoneBetsAtom, name: '${_$undoneBetsAtom.name}_set');
  }

  final _$_currentBetAtom = Atom(name: '_Game._currentBet');

  @override
  Bet get _currentBet {
    _$_currentBetAtom.context.enforceReadPolicy(_$_currentBetAtom);
    _$_currentBetAtom.reportObserved();
    return super._currentBet;
  }

  @override
  set _currentBet(Bet value) {
    _$_currentBetAtom.context.conditionallyRunInAction(() {
      super._currentBet = value;
      _$_currentBetAtom.reportChanged();
    }, _$_currentBetAtom, name: '${_$_currentBetAtom.name}_set');
  }

  final _$gameoverAtom = Atom(name: '_Game.gameover');

  @override
  bool get gameover {
    _$gameoverAtom.context.enforceReadPolicy(_$gameoverAtom);
    _$gameoverAtom.reportObserved();
    return super.gameover;
  }

  @override
  set gameover(bool value) {
    _$gameoverAtom.context.conditionallyRunInAction(() {
      super.gameover = value;
      _$gameoverAtom.reportChanged();
    }, _$gameoverAtom, name: '${_$gameoverAtom.name}_set');
  }

  final _$_GameActionController = ActionController(name: '_Game');

  @override
  void makeBet(Bet bet) {
    final _$actionInfo = _$_GameActionController.startAction();
    try {
      return super.makeBet(bet);
    } finally {
      _$_GameActionController.endAction(_$actionInfo);
    }
  }

  @override
  void undo() {
    final _$actionInfo = _$_GameActionController.startAction();
    try {
      return super.undo();
    } finally {
      _$_GameActionController.endAction(_$actionInfo);
    }
  }

  @override
  void redo() {
    final _$actionInfo = _$_GameActionController.startAction();
    try {
      return super.redo();
    } finally {
      _$_GameActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool roundResult(int rounds, [bool isEnd = true]) {
    final _$actionInfo = _$_GameActionController.startAction();
    try {
      return super.roundResult(rounds, isEnd);
    } finally {
      _$_GameActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'teams: ${teams.toString()},bets: ${bets.toString()},undoneBets: ${undoneBets.toString()},gameover: ${gameover.toString()},currentBet: ${currentBet.toString()}';
    return '{$string}';
  }
}
