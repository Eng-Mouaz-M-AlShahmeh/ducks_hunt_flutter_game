/* Developed by Eng Mouaz M AlShahmeh */
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/riverpod.dart';
import '../../helpers/assets.dart';

Widget iTree(BuildContext context) {
  double screenW = MediaQuery.of(context).size.width;
  double screenH = MediaQuery.of(context).size.height;
  return AnimatedAlign(
    duration: Duration.zero,
    alignment: const Alignment(-0.8, 0.5),
    child: SizedBox(
      width: screenW / 4.4,
      height: screenH / 2.4,
      child: const DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage(Assets.sceneTree),
            fit: BoxFit.fill,
          ),
        ),
      ),
    ),
  );
}

Widget iScore(BuildContext context, double score) {
  double screenW = MediaQuery.of(context).size.width;
  double screenH = MediaQuery.of(context).size.height;
  return AnimatedAlign(
    duration: Duration.zero,
    alignment: const Alignment(1, -1),
    child: Padding(
      padding: EdgeInsets.fromLTRB(
        screenW * 0.03,
        screenH * 0.02,
        screenW * 0.03,
        screenH * 0.02,
      ),
      child: Text('${score.toInt()}',
          style: const TextStyle(color: Colors.white, fontSize: 20)),
    ),
  );
}

Widget iPauseGameBtn(BuildContext context, bool paused, WidgetRef ref) {
  return AnimatedAlign(
    duration: Duration.zero,
    alignment: const Alignment(0, -1),
    child: paused == true
        ? const SizedBox()
        : IconButton(
            onPressed: () {
              ref.read(appProvider.notifier).pauseGame();
            },
            icon: const Icon(
              Icons.pause_circle,
              color: Colors.white,
            ),
          ),
  );
}

Widget iBack(BuildContext context) {
  double screenW = MediaQuery.of(context).size.width;
  double screenH = MediaQuery.of(context).size.height;
  return AnimatedAlign(
    duration: Duration.zero,
    alignment: const Alignment(0, 1),
    child: SizedBox(
      width: screenW,
      height: screenH,
      child: const DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage(Assets.sceneBack),
            fit: BoxFit.fill,
          ),
        ),
      ),
    ),
  );
}

Widget iBullets(BuildContext context, int count) {
  double screenW = MediaQuery.of(context).size.width;
  double screenH = MediaQuery.of(context).size.height;
  return AnimatedAlign(
    duration: Duration.zero,
    alignment: const Alignment(-1, -1),
    child: Padding(
      padding: EdgeInsets.fromLTRB(
        screenW * 0.03,
        screenH * 0.02,
        screenW * 0.03,
        screenH * 0.02,
      ),
      child: count == 0
          ? const SizedBox()
          : Row(
              children: [
                // for (int i = 1; i <= count; i++)
                SizedBox(
                  width: screenW * 0.02,
                  height: screenH / 30,
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage(Assets.hudBullet),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                // SizedBox(width: screenW * 0.1),
                SizedBox(
                    height: screenH / 30,
                    width: screenW * 0.1,
                    child: Text(
                      ' X $count',
                      style: TextStyle(color: Colors.green[900]),
                    )),
              ],
            ),
    ),
  );
}

Widget iScoreDucksDead(BuildContext context, int count) {
  double screenW = MediaQuery.of(context).size.width;
  double screenH = MediaQuery.of(context).size.height;
  return AnimatedAlign(
    duration: Duration.zero,
    alignment: const Alignment(-1, 0.92),
    child: Padding(
      padding: EdgeInsets.fromLTRB(
        screenW * 0.03,
        screenH * 0.02,
        screenW * 0.03,
        screenH * 0.02,
      ),
      child: count == 0
          ? const SizedBox()
          : Row(
              children: [
                // for (int i = 1; i <= count; i++)
                SizedBox(
                  width: screenW * 0.02,
                  height: screenH / 30,
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage(Assets.hudScoreDead),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    height: screenH / 30,
                    width: screenW * 0.1,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                      child: Text(
                        ' x $count',
                        style: TextStyle(color: Colors.red[900], fontSize: 10),
                      ),
                    )),
              ],
            ),
    ),
  );
}

Widget iScoreDucksLive(BuildContext context, int count) {
  double screenW = MediaQuery.of(context).size.width;
  double screenH = MediaQuery.of(context).size.height;
  return AnimatedAlign(
    duration: Duration.zero,
    alignment: const Alignment(-1, 1),
    child: Padding(
      padding: EdgeInsets.fromLTRB(
        screenW * 0.03,
        screenH * 0.02,
        screenW * 0.03,
        screenH * 0.02,
      ),
      child: count == 0
          ? const SizedBox()
          : Row(
              children: [
                // for (int i = 1; i <= count; i++)
                SizedBox(
                  width: screenW * 0.02,
                  height: screenH / 30,
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage(Assets.hudScoreLive),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    height: screenH / 30,
                    width: screenW * 0.1,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                      child: Text(
                        ' x $count',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    )),
              ],
            ),
    ),
  );
}

Widget iWave(BuildContext context, int current, int from) {
  double screenW = MediaQuery.of(context).size.width;
  double screenH = MediaQuery.of(context).size.height;
  return AnimatedAlign(
    duration: Duration.zero,
    alignment: const Alignment(1, 0.95),
    child: Padding(
      padding: EdgeInsets.fromLTRB(
        screenW * 0.03,
        screenH * 0.02,
        screenW * 0.03,
        screenH * 0.02,
      ),
      child: Text(
        'Wave $current from $from',
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
    ),
  );
}

Widget iLoose(BuildContext context, WidgetRef ref) {
  double screenW = MediaQuery.of(context).size.width;
  double screenH = MediaQuery.of(context).size.height;
  return Center(
    child: SizedBox(
      width: screenW,
      height: screenH,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.black,
          backgroundBlendMode: BlendMode.overlay,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You Loose!',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            const SizedBox(height: 15),
            TextButton(
              onPressed: () {
                ref.read(appProvider.notifier).restartGame();
                ref.read(appProvider.notifier).getDucksLevel(context, 0);
              },
              child: const Text(
                'Play Again?',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget iWin(BuildContext context, WidgetRef ref) {
  double screenW = MediaQuery.of(context).size.width;
  double screenH = MediaQuery.of(context).size.height;
  return Center(
    child: SizedBox(
      width: screenW,
      height: screenH,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.black,
          backgroundBlendMode: BlendMode.overlay,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You Win!',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            const SizedBox(height: 15),
            TextButton(
              onPressed: () {
                ref.read(appProvider.notifier).restartGame();
                ref.read(appProvider.notifier).getDucksLevel(context, 0);
              },
              child: const Text(
                'Truly impressive score.Play Again?',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget iLevel(BuildContext context, String level) {
  double screenW = MediaQuery.of(context).size.width;
  double screenH = MediaQuery.of(context).size.height;
  return Center(
    child: SizedBox(
      width: screenW,
      height: screenH,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.black,
          backgroundBlendMode: BlendMode.overlay,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              level,
              style: const TextStyle(color: Colors.white, fontSize: 30),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget iGamePaused(BuildContext context, WidgetRef ref) {
  double screenW = MediaQuery.of(context).size.width;
  double screenH = MediaQuery.of(context).size.height;
  return Center(
    child: SizedBox(
      width: screenW,
      height: screenH,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.black,
          backgroundBlendMode: BlendMode.overlay,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                ref.read(appProvider.notifier).playGame();
              },
              child: const Text(
                'Back!',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
            const SizedBox(height: 15),
            TextButton(
              onPressed: () {
                ref.read(appProvider.notifier).restartGame();
                ref.read(appProvider.notifier).getDucksLevel(context, 0);
              },
              child: const Text(
                'Restart Game?',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
