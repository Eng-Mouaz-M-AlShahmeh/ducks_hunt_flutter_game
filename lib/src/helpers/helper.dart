/* Developed by Eng Mouaz M AlShahmeh */
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'assets.dart';
import 'sounds.dart';

class Helper {
  double maxWidthPosition(BuildContext context) {
    return MediaQuery.of(context).size.center(Offset.zero).dx * 2;
  }

  double maxHeightPosition(BuildContext context) {
    return MediaQuery.of(context).size.center(Offset.zero).dy * 2;
  }

  void playSound(int type) {
    final player = AudioPlayer();
    switch (type) {
      case 1:
        player.play(AssetSource(Sounds.barkDucks));
        break;
      case 2:
        player.play(AssetSource(Sounds.champ));
        break;
      case 3:
        player.play(AssetSource(Sounds.gun));
        break;
      case 4:
        player.play(AssetSource(Sounds.laugh));
        break;
      case 5:
        player.play(AssetSource(Sounds.loser));
        break;
      case 6:
        player.play(AssetSource(Sounds.ohYeah));
        break;
      case 7:
        player.play(AssetSource(Sounds.quacking));
        break;
      case 8:
        player.play(AssetSource(Sounds.quak));
        break;
      case 9:
        player.play(AssetSource(Sounds.sniff));
        break;
      case 10:
        player.play(AssetSource(Sounds.thud));
        break;
    }
  }

  List levels = [
    {
      'id': 1,
      'title': 'Level 1',
      'waves': 3,
      'ducks': 2,
      'pointsPerDuck': 100,
      'speed': 5,
      'bullets': 3,
      'time': 13
    },
    {
      'id': 2,
      'title': 'Level 2',
      'waves': 5,
      'ducks': 3,
      'pointsPerDuck': 100,
      'speed': 6,
      'bullets': 4,
      'time': 10
    },
    {
      'id': 3,
      'title': 'Level 3',
      'waves': 6,
      'ducks': 3,
      'pointsPerDuck': 100,
      'speed': 7,
      'bullets': 4,
      'time': 10
    },
    {
      'id': 4,
      'title': 'Level 4',
      'waves': 3,
      'ducks': 10,
      'pointsPerDuck': 100,
      'speed': 7,
      'bullets': 11,
      'time': 18
    },
    {
      'id': 5,
      'title': 'Level 5',
      'waves': 5,
      'ducks': 2,
      'pointsPerDuck': 100,
      'speed': 8,
      'bullets': 3,
      'time': 13
    },
    {
      'id': 6,
      'title': 'Level 6',
      'waves': 1,
      'ducks': 15,
      'pointsPerDuck': 100,
      'speed': 8,
      'bullets': 15,
      'time': 25
    }
  ];

  String assetDuckName(bool localDead, int localFrame, String localDirection,
      String localColor) {
    if (localColor == 'black') {
      if (localDead == true) {
        if (localFrame == 0) {
          return Assets.duckBlackDeadZero;
        } else if (localFrame == 1) {
          return Assets.duckBlackDeadOne;
        } else {
          return Assets.duckBlackDeadTwo;
        }
      } else {
        if (localDirection == 'left') {
          if (localFrame == 0) {
            return Assets.duckBlackLeftZero;
          } else if (localFrame == 1) {
            return Assets.duckBlackLeftOne;
          } else {
            return Assets.duckBlackLeftTwo;
          }
        } else if (localDirection == 'right') {
          if (localFrame == 0) {
            return Assets.duckBlackRightZero;
          } else if (localFrame == 1) {
            return Assets.duckBlackRightOne;
          } else {
            return Assets.duckBlackRightTwo;
          }
        } else if (localDirection == 'top-left') {
          if (localFrame == 0) {
            return Assets.duckBlackTopLeftZero;
          } else if (localFrame == 1) {
            return Assets.duckBlackTopLeftOne;
          } else {
            return Assets.duckBlackTopLeftTwo;
          }
        } else {
          if (localFrame == 0) {
            return Assets.duckBlackTopRightZero;
          } else if (localFrame == 1) {
            return Assets.duckBlackTopRightOne;
          } else {
            return Assets.duckBlackTopRightTwo;
          }
        }
      }
    } else {
      if (localDead == true) {
        if (localFrame == 0) {
          return Assets.duckRedDeadZero;
        } else if (localFrame == 1) {
          return Assets.duckRedDeadOne;
        } else {
          return Assets.duckRedDeadTwo;
        }
      } else {
        if (localDirection == 'left') {
          if (localFrame == 0) {
            return Assets.duckRedLeftZero;
          } else if (localFrame == 1) {
            return Assets.duckRedLeftOne;
          } else {
            return Assets.duckRedLeftTwo;
          }
        } else if (localDirection == 'right') {
          if (localFrame == 0) {
            return Assets.duckRedRightZero;
          } else if (localFrame == 1) {
            return Assets.duckRedRightOne;
          } else {
            return Assets.duckRedRightTwo;
          }
        } else if (localDirection == 'top-left') {
          if (localFrame == 0) {
            return Assets.duckRedTopLeftZero;
          } else if (localFrame == 1) {
            return Assets.duckRedTopLeftOne;
          } else {
            return Assets.duckRedTopLeftTwo;
          }
        } else {
          if (localFrame == 0) {
            return Assets.duckRedTopRightZero;
          } else if (localFrame == 1) {
            return Assets.duckRedTopRightOne;
          } else {
            return Assets.duckRedTopRightTwo;
          }
        }
      }
    }
  }

  String assetDogName(int localFrame, String localState) {
    if (localState == 'sniff') {
      if (localFrame == 0) {
        return Assets.dogSniffZero;
      } else if (localFrame == 1) {
        return Assets.dogSniffOne;
      } else if (localFrame == 2) {
        return Assets.dogSniffTwo;
      } else if (localFrame == 3) {
        return Assets.dogSniffThree;
      } else {
        return Assets.dogSniffFour;
      }
    } else if (localState == 'laugh') {
      if (localFrame == 0) {
        return Assets.dogLaughZero;
      } else {
        return Assets.dogLaughOne;
      }
    } else if (localState == 'jump') {
      if (localFrame == 0) {
        return Assets.dogJumpZero;
      } else {
        return Assets.dogJumpOne;
      }
    } else if (localState == 'find') {
      return Assets.dogFind;
    } else if (localState == 'single') {
      return Assets.dogSingle;
    } else {
      return Assets.dogDouble;
    }
  }

  List<String> directions = ['left', 'right', 'top-left', 'top-right'];
  List<String> dogStates = [
    'single',
    'double',
    'find',
    'jump',
    'laugh',
    'sniff'
  ];
  List<String> colors = ['black', 'red'];
  List<String> maths = ['+', '-'];
}
