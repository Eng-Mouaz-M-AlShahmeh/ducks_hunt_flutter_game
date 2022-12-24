/* Developed by: Eng Mouaz M. Al-Shahmeh */
class DuckModel {
  DuckModel({
    this.id,
    this.frame,
    this.currentXMove,
    this.currentYMove,
    this.positionX,
    this.positionY,
    this.currentDirection,
    this.isDead,
    this.color,
  });

  DuckModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    frame = json['frame'];
    currentXMove = json['currentXMove'];
    currentYMove = json['currentYMove'];
    positionX = json['positionX'];
    positionY = json['positionY'];
    currentDirection = json['currentDirection'];
    isDead = json['isDead'];
    color = json['color'];
  }

  int? id;
  int? frame;
  String? nextMathFrame;
  String? currentXMove;
  String? currentYMove;
  double? positionX;
  double? positionY;
  String? currentDirection;
  bool? isDead;
  String? color;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['frame'] = frame;
    data['currentXMove'] = currentXMove;
    data['currentYMove'] = currentYMove;
    data['positionX'] = positionX;
    data['positionY'] = positionY;
    data['currentDirection'] = currentDirection;
    data['isDead'] = isDead;
    data['color'] = color;
    return data;
  }
}
