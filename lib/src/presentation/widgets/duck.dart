/* Developed by Eng Mouaz M AlShahmeh */
import 'package:duck_hunt_flutter_game/src/domain/duck.dart';
import 'package:duck_hunt_flutter_game/src/helpers/helper.dart';
import 'package:flutter/material.dart';

Widget iDuck(BuildContext context, DuckModel iDuckModel) {
  double screenW = MediaQuery.of(context).size.width;
  double screenH = MediaQuery.of(context).size.height;
  return AnimatedPositioned(
    duration: Duration.zero,
    left: iDuckModel.positionX,
    top: iDuckModel.positionY,
    child: SizedBox(
      width: screenW / 10,
      height: screenH / 10,
      child: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage(Helper().assetDuckName(iDuckModel.isDead!, iDuckModel.frame!,
                iDuckModel.currentDirection!, iDuckModel.color!)),
            fit: BoxFit.fill,
          ),
        ),
      ),
    ),
  );
}
