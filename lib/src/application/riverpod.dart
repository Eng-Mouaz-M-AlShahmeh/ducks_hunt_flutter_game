/* Developed by Eng Mouaz M AlShahmeh */
import 'dart:async';
import 'dart:math';
import 'package:duck_hunt_flutter_game/src/domain/dog.dart';
import 'package:duck_hunt_flutter_game/src/domain/duck.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../helpers/helper.dart';

final appProvider = ChangeNotifierProvider<AppNotifier>((ref) {
  return AppNotifier();
});

class AppNotifier extends ChangeNotifier {
  /// ..........
  /// Setters
  /// ..........
  double _score = 0;
  int _pointPerDuck = 0;
  int _bulletsCount = 0;
  int _scoreDucksDeadCount = 0;
  int _scoreDucksLiveCount = 0;
  int _currentWave = 1;
  int _fromWave = 0;
  bool _gamePause = false;
  bool _gameStart = false;
  bool _gameLoose = false;
  bool _gameWin = false;
  bool _levelTitleOn = false;
  bool _dogVisible = false;
  bool _dogActiveVisible = false;
  bool _gunClicked = false;
  bool _gunFinish = false;
  int _currentLevelIndex = 0;
  String _currentLevelTitle = '';
  final List<DuckModel> _gameDucks = [];
  DogModel _gameDog = DogModel();
  DogModel _gameDogActive = DogModel();
  Timer? _directionTimer;
  Timer? _positionActiveTimer;
  Timer? _frameTimer;
  Timer? _positionTimer;
  int randDirectionIndex = 0;
  int randColorIndex = 0;
  int randFrameIndex = 0;
  int randMathXIndex = 0;
  int randMathYIndex = 0;
  int gunDucks = 0;
  double randX = 0.0;
  double randY = 0.0;

  /// ..........
  /// Functions
  /// ..........
  void startGame(BuildContext context) {
    if (_gameLoose == true || _gameWin == true) {
    } else {
      restartGame();
      getDucksLevel(context, 0);
    }
  }

  void pauseGame() {
    _gamePause = true;
    _gameStart = false;
    _gameLoose = false;
    _gameWin = false;
    _levelTitleOn = false;
    notifyListeners();
  }

  void playGame() {
    _gamePause = false;
    _gameStart = true;
    _gameLoose = false;
    _gameWin = false;
    _levelTitleOn = false;
    notifyListeners();
  }

  void checkGameOver(BuildContext context) {
    for (int i = 0; i < _gameDucks.length; i++) {
      if (_gameDucks[i].isDead == false) {
        _scoreDucksLiveCount = _scoreDucksLiveCount + 1;
        notifyListeners();
      }
    }
    _gameDucks.clear();
    if (_scoreDucksDeadCount >= _scoreDucksLiveCount) {
      if (_currentLevelIndex == Helper().levels.length - 1) {
        _currentWave = 1;
        _scoreDucksDeadCount = 0;
        _scoreDucksLiveCount = 0;
        _gameLoose = false;
        _gameWin = true;
        Helper().playSound(2);
        notifyListeners();
        return;
      } else {
        if (_currentWave + 1 > _fromWave) {
          _currentWave = 1;
          _scoreDucksDeadCount = 0;
          _scoreDucksLiveCount = 0;
          _currentLevelIndex = _currentLevelIndex + 1;
          getDucksLevel(context, _currentLevelIndex);
          notifyListeners();
          return;
        } else {
          _currentWave = _currentWave + 1;
          getDucksLevel(context, _currentLevelIndex);
          notifyListeners();
          return;
        }
      }
    } else {
      _currentWave = 1;
      _scoreDucksDeadCount = 0;
      _scoreDucksLiveCount = 0;
      _gameLoose = true;
      _gameWin = false;
      Helper().playSound(5);
      notifyListeners();
      return;
    }
  }

  void restartGame() {
    _score = 0;
    _scoreDucksDeadCount = 0;
    _scoreDucksLiveCount = 0;
    _gameStart = true;
    _gamePause = false;
    _gameLoose = false;
    _gameWin = false;
    _levelTitleOn = false;
    _currentLevelIndex = 0;
    _currentLevelTitle = Helper().levels[0]['title'];
    _currentWave = 1;
    _fromWave = Helper().levels[0]['waves'];
    _bulletsCount = Helper().levels[0]['bullets'];
    _pointPerDuck = Helper().levels[0]['pointsPerDuck'];
    notifyListeners();
  }

  void shotGun(BuildContext context, TapUpDetails event) {
    if(_levelTitleOn == true) {
      return;
    }
    if(_gameLoose == true) {
      return;
    }
    if(_gameWin == true) {
      return;
    }
    gunDucks = 0;
    _gunClicked = true;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 100), () {
      _gunClicked = false;
      notifyListeners();
    });
    if (_bulletsCount != 0) {
      Helper().playSound(3);
      _bulletsCount = _bulletsCount - 1;
      if (_bulletsCount == 0) {
        Helper().playSound(4);
        _gunFinish = true;
        notifyListeners();
        Future.delayed(const Duration(milliseconds: 100), () {
          _gunFinish = false;
          notifyListeners();
        });
        checkGameOver(context);
      }
      for (int i = 0; i < _gameDucks.length; i++) {
        if ((event.localPosition.dx -
                        num.tryParse('${_gameDucks[i].positionX}')!)
                    .abs() <=
                80 &&
            (event.localPosition.dy -
                        num.tryParse('${_gameDucks[i].positionY}')!)
                    .abs() <=
                80) {
          Helper().playSound(8);
          _gameDucks[i].isDead = true;
          _score =
              _score + Helper().levels[_currentLevelIndex]['pointsPerDuck'];
          _scoreDucksDeadCount = _scoreDucksDeadCount + 1;
          gunDucks = gunDucks + 1;
          notifyListeners();
        }
      }
      if (gunDucks == 1) {
        Helper().playSound(10);
        _gameDogActive = DogModel(
          id: 1,
          frame: 0,
          positionX: Helper().maxWidthPosition(context) -
              Helper().maxWidthPosition(context) / 1.7,
          positionY: Helper().maxHeightPosition(context) -
              Helper().maxHeightPosition(context) * 0.18,
          currentState: Helper().dogStates[0],
          nextMathFrame: '-',
        );
        dogActive(context);
      }
      if (gunDucks > 1) {
        Helper().playSound(10);
        _gameDogActive = DogModel(
          id: 1,
          frame: 0,
          positionX: Helper().maxWidthPosition(context) -
              Helper().maxWidthPosition(context) / 1.7,
          positionY: Helper().maxHeightPosition(context) -
              Helper().maxHeightPosition(context) * 0.18,
          currentState: Helper().dogStates[1],
          nextMathFrame: '-',
        );
        dogActive(context);
      }
    }
  }

  void getDucksLevel(BuildContext context, int id) {
    // Future.delayed(Duration(seconds: Helper().levels[_currentLevelIndex]['time']), () {
    //   checkGameOver(context);
    // });
    Helper().playSound(1);
    _dogVisible = true;
    _levelTitleOn = true;
    _currentLevelIndex = id;
    _fromWave = Helper().levels[id]['waves'];
    _currentLevelTitle = Helper().levels[id]['title'];
    _bulletsCount = Helper().levels[id]['bullets'];
    _pointPerDuck = Helper().levels[id]['pointsPerDuck'];
    _gameDog = DogModel(
        id: 1,
        frame: 0,
        positionX: 0.0,
        positionY: Helper().maxHeightPosition(context) -
            Helper().maxHeightPosition(context) * 0.18,
        currentState: Helper().dogStates[5],
        nextMathFrame: '+');
    _gameDucks.clear();
    for (int i = 0; i < Helper().levels[id]['ducks']; i++) {
      randX = Random().nextDouble() * Helper().maxWidthPosition(context);
      randY = Random().nextDouble() * Helper().maxHeightPosition(context);
      randDirectionIndex = Random().nextInt(3);
      randColorIndex = Random().nextInt(1);
      randFrameIndex = Random().nextInt(2);
      randMathXIndex = Random().nextInt(1);
      randMathYIndex = Random().nextInt(1);
      _gameDucks.add(
        DuckModel(
          id: i,
          frame: randFrameIndex,
          currentXMove: Helper().maths[randMathXIndex],
          currentYMove: Helper().maths[randMathYIndex],
          positionX: randX >
                  Helper().maxWidthPosition(context) -
                      Helper().maxWidthPosition(context) * 0.1
              ? randX - Helper().maxWidthPosition(context) * 0.1
              : randX,
          positionY: randY >
                  Helper().maxHeightPosition(context) -
                      Helper().maxHeightPosition(context) * 0.3
              ? randY - Helper().maxHeightPosition(context) * 0.3
              : randY,
          currentDirection: Helper().directions[randDirectionIndex],
          isDead: false,
          color: Helper().colors[randColorIndex],
        ),
      );
    }
    dogMovements(context);
    Future.delayed(const Duration(seconds: 3), () {
      _levelTitleOn = false;
      _dogVisible = false;
      notifyListeners();
    });
    notifyListeners();
  }

  void dogActive(BuildContext context) {
    _dogActiveVisible = true;
    _positionActiveTimer =
        Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_gameDogActive.positionY! > Helper().maxHeightPosition(context)) {
        _dogActiveVisible = false;
        _gameDog.nextMathFrame = '+';
        notifyListeners();
      } else if (_gameDogActive.positionY! <=
          Helper().maxHeightPosition(context) -
              Helper().maxHeightPosition(context) / 2.8) {
        _gameDogActive.nextMathFrame = '+';
        notifyListeners();
      }
      if (_gameDogActive.nextMathFrame == '+') {
        _gameDogActive.positionY = _gameDogActive.positionY! + 10;
        notifyListeners();
      } else {
        _gameDogActive.positionY = _gameDogActive.positionY! - 10;
        notifyListeners();
      }
    });
  }

  void dogMovements(BuildContext context) {
    Helper().playSound(9);
    _gameDog.positionX = 0.0;
    _gameDog.positionY = Helper().maxHeightPosition(context) -
        Helper().maxHeightPosition(context) * 0.18;
    _positionTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if ((_gameDog.positionX! -
                  (Helper().maxWidthPosition(context) -
                      Helper().maxWidthPosition(context) / 1.7))
              .abs() <=
          50) {
        if (_gameDog.positionY! ==
            Helper().maxHeightPosition(context) -
                Helper().maxHeightPosition(context) * 0.12) {
          _gameDog.currentState = Helper().dogStates[2];
          Future.delayed(const Duration(milliseconds: 100), () {
            _gameDog.positionY = _gameDog.positionY! - 10;
          });
          notifyListeners();
        } else {
          if (_gameDog.positionY! <=
              Helper().maxHeightPosition(context) / 1.5) {
          } else {
            _gameDog.currentState = Helper().dogStates[3];
            if (_gameDog.frame == 1) {
              _gameDog.nextMathFrame = '-';
            }
            if (_gameDog.frame == 0) {
              _gameDog.nextMathFrame = '+';
            }
            if (_gameDog.nextMathFrame == '+') {
              _gameDog.frame = _gameDog.frame! + 1;
            } else {
              _gameDog.frame = _gameDog.frame! - 1;
            }
            _gameDog.positionY = _gameDog.positionY! - 10;
            notifyListeners();
          }
        }
      } else {
        _gameDog.currentState = Helper().dogStates[5];
        if (_gameDog.frame == 4) {
          _gameDog.nextMathFrame = '-';
        }
        if (_gameDog.frame == 0) {
          _gameDog.nextMathFrame = '+';
        }
        if (_gameDog.nextMathFrame == '+') {
          _gameDog.frame = _gameDog.frame! + 1;
        } else {
          _gameDog.frame = _gameDog.frame! - 1;
        }
        _gameDog.positionX = _gameDog.positionX! + 10;
        notifyListeners();
      }
    });
  }

  void ducksMovements(BuildContext context) {
    if (_gameDucks.isNotEmpty) {
      Helper().playSound(7);
      _positionTimer = Timer.periodic(
          Duration(
              milliseconds: 500 ~/
                  num.tryParse(
                      '${Helper().levels[_currentLevelIndex]['speed']}')!),
          (timer) {
        for (int i = 0; i < _gameDucks.length; i++) {
          if (_gameDucks[i].isDead == true) {
            _gameDucks[i].positionY = _gameDucks[i].positionY! + 5;
            notifyListeners();
          } else {
            if (_gameDucks[i].currentXMove == '+' &&
                _gameDucks[i].currentYMove == '+') {
              if (_gameDucks[i].positionX! + 5 >
                  Helper().maxWidthPosition(context) -
                      Helper().maxWidthPosition(context) * 0.1) {
                _gameDucks[i].currentXMove = '-';
                notifyListeners();
              } else if (_gameDucks[i].positionY! + 5 >
                  Helper().maxHeightPosition(context) -
                      Helper().maxHeightPosition(context) * 0.3) {
                _gameDucks[i].currentYMove = '-';
                notifyListeners();
              }
              _gameDucks[i].positionX = _gameDucks[i].positionX! + 5;
              _gameDucks[i].positionY = _gameDucks[i].positionY! + 5;
              notifyListeners();
            } else if (_gameDucks[i].currentXMove == '-' &&
                _gameDucks[i].currentYMove == '-') {
              if (_gameDucks[i].positionX! - 5 < 0) {
                _gameDucks[i].currentXMove = '+';
                notifyListeners();
              } else if (_gameDucks[i].positionY! - 5 < 0) {
                _gameDucks[i].currentYMove = '+';
                notifyListeners();
              }
              _gameDucks[i].positionX = _gameDucks[i].positionX! - 5;
              _gameDucks[i].positionY = _gameDucks[i].positionY! - 5;
              notifyListeners();
            } else if (_gameDucks[i].currentXMove == '+' &&
                _gameDucks[i].currentYMove == '-') {
              if (_gameDucks[i].positionX! + 5 >
                  Helper().maxWidthPosition(context) -
                      Helper().maxWidthPosition(context) * 0.1) {
                _gameDucks[i].currentXMove = '-';
                notifyListeners();
              } else if (_gameDucks[i].positionY! - 5 < 0) {
                _gameDucks[i].currentYMove = '+';
                notifyListeners();
              }
              _gameDucks[i].positionX = _gameDucks[i].positionX! + 5;
              _gameDucks[i].positionY = _gameDucks[i].positionY! - 5;
              notifyListeners();
            } else if (_gameDucks[i].currentXMove == '-' &&
                _gameDucks[i].currentYMove == '+') {
              if (_gameDucks[i].positionX! - 5 < 0) {
                _gameDucks[i].currentXMove = '+';
                notifyListeners();
              } else if (_gameDucks[i].positionY! + 5 >
                  Helper().maxHeightPosition(context) -
                      Helper().maxHeightPosition(context) * 0.3) {
                _gameDucks[i].currentYMove = '-';
                notifyListeners();
              }
              _gameDucks[i].positionX = _gameDucks[i].positionX! - 5;
              _gameDucks[i].positionY = _gameDucks[i].positionY! + 5;
              notifyListeners();
            }
          }
        }
      });
      _frameTimer = Timer.periodic(const Duration(milliseconds: 150), (timer) {
        for (int i = 0; i < _gameDucks.length; i++) {
          if (_gameDucks[i].frame == 2) {
            _gameDucks[i].nextMathFrame = '-';
          }
          if (_gameDucks[i].frame == 0) {
            _gameDucks[i].nextMathFrame = '+';
          }
          if (_gameDucks[i].nextMathFrame == '+') {
            _gameDucks[i].frame = _gameDucks[i].frame! + 1;
          } else {
            _gameDucks[i].frame = _gameDucks[i].frame! - 1;
          }
        }
      });
      _directionTimer =
          Timer.periodic(const Duration(milliseconds: 3000), (timer) {
        for (int i = 0; i < _gameDucks.length; i++) {
          randDirectionIndex = Random().nextInt(3);
          if (randDirectionIndex == 0) {
            _gameDucks[i].currentXMove = Helper().maths[1];
          } else if (randDirectionIndex == 1) {
            _gameDucks[i].currentXMove = Helper().maths[0];
          } else if (randDirectionIndex == 2) {
            _gameDucks[i].currentXMove = Helper().maths[1];
            _gameDucks[i].currentYMove = Helper().maths[1];
          } else if (randDirectionIndex == 3) {
            _gameDucks[i].currentXMove = Helper().maths[0];
            _gameDucks[i].currentYMove = Helper().maths[1];
          }
          if (_gameDucks[i].currentDirection ==
              Helper().directions[randDirectionIndex]) {
            randDirectionIndex = Random().nextInt(3);
          } else {
            _gameDucks[i].currentDirection =
                Helper().directions[randDirectionIndex];
          }
          notifyListeners();
        }
      });
    }
  }

  /// ..........
  /// Getters
  /// ..........
  double get score => _score;
  int get pointPerDuck => _pointPerDuck;
  int get bulletsCount => _bulletsCount;
  int get scoreDucksDeadCount => _scoreDucksDeadCount;
  int get scoreDucksLiveCount => _scoreDucksLiveCount;
  int get currentWave => _currentWave;
  int get fromWave => _fromWave;
  bool get gamePause => _gamePause;
  bool get gameStart => _gameStart;
  bool get gameLoose => _gameLoose;
  bool get gameWin => _gameWin;
  bool get levelTitleOn => _levelTitleOn;
  bool get dogVisible => _dogVisible;
  bool get dogActiveVisible => _dogActiveVisible;
  bool get gunClicked => _gunClicked;
  bool get gunFinish => _gunFinish;
  int get currentLevelIndex => _currentLevelIndex;
  String get currentLevelTitle => _currentLevelTitle;
  List<DuckModel> get gameDucks => _gameDucks;
  DogModel get gameDog => _gameDog;
  DogModel get gameDogActive => _gameDogActive;

  /// ..........
  /// Dispose
  /// ..........
  @override
  void dispose() {
    _frameTimer!.cancel();
    _directionTimer!.cancel();
    _positionTimer!.cancel();
    _positionActiveTimer!.cancel();
    super.dispose();
  }
}
