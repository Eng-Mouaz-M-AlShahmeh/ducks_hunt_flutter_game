/* Developed by Eng Mouaz M AlShahmeh */
import 'package:duck_hunt_flutter_game/src/application/riverpod.dart';
import 'package:duck_hunt_flutter_game/src/domain/duck.dart';
import 'package:duck_hunt_flutter_game/src/presentation/widgets/dog.dart';
import 'package:duck_hunt_flutter_game/src/presentation/widgets/duck.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widgets/scene.dart';

class MyGame extends ConsumerWidget {
  const MyGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future.delayed(Duration.zero, () {
      ref.read(appProvider.notifier).startGame(context);
      ref.read(appProvider.notifier).ducksMovements(context);
    });

    return Scaffold(
      body: Consumer(
        builder: (_, ref, __) {
          final gunClicked = ref.watch(appProvider).gunClicked;
          final gunFinish = ref.watch(appProvider).gunFinish;
          AppNotifier appRiverpod = ref.watch(appProvider);
          List<DuckModel> ducks = appRiverpod.gameDucks;

          return Scaffold(
            backgroundColor: gunFinish
                ? Colors.red[200]
                : gunClicked
                    ? Colors.white
                    : Colors.blue[400],
            body: GestureDetector(
              onTapUp: (event) {
                ref.read(appProvider.notifier).shotGun(context, event);
              },
              child: Stack(
                children: [
                  iScore(context, appRiverpod.score),
                  appRiverpod.levelTitleOn == true
                      ? const SizedBox()
                      : appRiverpod.gameLoose == true ||
                              appRiverpod.gameWin == true
                          ? const SizedBox()
                          : iBullets(context, appRiverpod.bulletsCount),
                  for (int i = 0; i < ducks.length; i++)
                    appRiverpod.levelTitleOn == true
                        ? const SizedBox()
                        : iDuck(context, ducks[i]),
                  appRiverpod.dogActiveVisible == true
                      ? iDogActive(context, appRiverpod.gameDogActive)
                      : const SizedBox(),
                  iTree(context),
                  iBack(context),
                  appRiverpod.levelTitleOn == true
                      ? const SizedBox()
                      : iScoreDucksDead(
                          context, appRiverpod.scoreDucksDeadCount),
                  appRiverpod.levelTitleOn == true
                      ? const SizedBox()
                      : iScoreDucksLive(
                          context, appRiverpod.scoreDucksLiveCount),
                  appRiverpod.levelTitleOn == true
                      ? const SizedBox()
                      : appRiverpod.gameLoose == true ||
                              appRiverpod.gameWin == true
                          ? const SizedBox()
                          : iWave(context, appRiverpod.currentWave,
                              appRiverpod.fromWave),
                  appRiverpod.gameLoose == true
                      ? iLoose(context, ref)
                      : const SizedBox(),
                  appRiverpod.gameWin == true
                      ? iWin(context, ref)
                      : const SizedBox(),
                  appRiverpod.gameStart == false
                      ? const SizedBox()
                      : appRiverpod.levelTitleOn == true
                          ? iLevel(context, appRiverpod.currentLevelTitle)
                          : const SizedBox(),
                  appRiverpod.dogVisible == true
                      ? iDog(context, appRiverpod.gameDog)
                      : const SizedBox(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
