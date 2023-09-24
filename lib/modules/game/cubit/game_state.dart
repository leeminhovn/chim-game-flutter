part of 'game_cubit.dart';

@immutable
abstract class GameState {
  Map<String, dynamic> loadList = {
    'background': null,
    'birdBlue': null,
    'birdYellow': null,
    'birdRed': null,
    'number': null,
    'pipeGreenTop': null,
    'pipeGreenBottom': null,
    'textGameOver': null,
    'textMessageGuidePlay': null,
    'ground': null,
    'logoHalo': null
  };
  
  Map<String, dynamic> configGame = {
    "screenWidth": 0,
    "screenHeight": 0,
    "speed": 1
  };
  copy(GameState state) {
    state.loadList = state.loadList;
  }
}

class GameInitial extends GameState {}

class GameLoading extends GameState {
  GameLoading(GameState state) {
    super.copy(state);
  }
}

class GameReady extends GameState {
  GameReady(GameState state) {
    super.copy(state);
  }
}

class GameLoaded extends GameState {
  GameLoaded(GameState state) {
    super.copy(state);
  }
}
