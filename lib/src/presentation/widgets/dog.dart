/* Developed by Eng Mouaz M AlShahmeh */
import 'package:duck_hunt_flutter_game/src/domain/dog.dart';
import 'package:duck_hunt_flutter_game/src/helpers/helper.dart';
import 'package:flutter/material.dart';

Widget iDog(BuildContext context, DogModel iDogModel) {
  double screenW = MediaQuery.of(context).size.width;
  double screenH = MediaQuery.of(context).size.height;
  return AnimatedPositioned(
    duration: Duration.zero,
    left: iDogModel.positionX,
    top: iDogModel.positionY,
    child: SizedBox(
      width: screenW / 6,
      height: screenH / 6,
      child: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage(Helper().assetDogName(iDogModel.frame!, iDogModel.currentState!)),
            fit: BoxFit.fill,
          ),
        ),
      ),
    ),
  );
}

Widget iDogActive(BuildContext context, DogModel iDogModel) {
  double screenW = MediaQuery.of(context).size.width;
  double screenH = MediaQuery.of(context).size.height;
  return AnimatedPositioned(
    duration: Duration.zero,
    left: iDogModel.positionX,
    top: iDogModel.positionY,
    child: SizedBox(
      width: screenW / 6,
      height: screenH / 6,
      child: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage(Helper().assetDogName(iDogModel.frame!, iDogModel.currentState!)),
            fit: BoxFit.fill,
          ),
        ),
      ),
    ),
  );
}
