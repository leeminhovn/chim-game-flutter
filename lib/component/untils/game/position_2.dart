// ignore: camel_case_types
class position2D {
  double _x = 0;
  double _y = 0;
  position2D(this._x, this._y);
  double get x => _x;
  double get y => _y;
  set x(value) {
    _x = value;
  }

  set y(value) {
    _y = value;
  }
}