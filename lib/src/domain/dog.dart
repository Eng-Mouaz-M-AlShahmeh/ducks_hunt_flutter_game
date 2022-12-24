/* Developed by: Eng Mouaz M. Al-Shahmeh */
class DogModel {
  DogModel({
    this.id,
    this.frame,
    this.positionX,
    this.positionY,
    this.currentState,
    this.nextMathFrame,
  });

  DogModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    frame = json['frame'];
    positionX = json['positionX'];
    positionY = json['positionY'];
    currentState = json['currentState'];
    nextMathFrame = json['nextMathFrame'];
  }

  int? id;
  int? frame;
  double? positionX;
  double? positionY;
  String? currentState;
  String? nextMathFrame;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['frame'] = frame;
    data['positionX'] = positionX;
    data['positionY'] = positionY;
    data['currentState'] = currentState;
    data['nextMathFrame'] = nextMathFrame;
    return data;
  }
}
