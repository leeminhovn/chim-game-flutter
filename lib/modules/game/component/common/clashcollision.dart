import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

bool areRectanglesColliding(Rect a, double angleA, Rect b, double angleB) {
  List<Vector2> verticesA = _getVertices(a, angleA);
  List<Vector2> verticesB = _getVertices(b, angleB);

  List<Vector2> axes = [];
  for (int i = 0; i < 4; i++) {
    Vector2 edge1 = verticesA[i];
    Vector2 edge2 = verticesA[(i + 1) % 4];
    Vector2 axis = Vector2(-(edge2.y - edge1.y), edge2.x - edge1.x);
    axis.normalize();
    axes.add(axis);
  }
  for (int i = 0; i < 4; i++) {
    Vector2 edge1 = verticesB[i];
    Vector2 edge2 = verticesB[(i + 1) % 4];
    Vector2 axis = Vector2(-(edge2.y - edge1.y), edge2.x - edge1.x);
    axis.normalize();
    axes.add(axis);
  }

  for (Vector2 axis in axes) {
    double minA = double.infinity;
    double maxA = double.negativeInfinity;
    for (Vector2 vertex in verticesA) {
      double projection = vertex.dot(axis);
      if (projection < minA) {
        minA = projection;
      }
      if (projection > maxA) {
        maxA = projection;
      }
    }

    double minB = double.infinity;
    double maxB = double.negativeInfinity;
    for (Vector2 vertex in verticesB) {
      double projection = vertex.dot(axis);
      if (projection < minB) {
        minB = projection;
      }
      if (projection > maxB) {
        maxB = projection;
      }
    }

    if (maxA < minB || maxB < minA) {
      return false;
    }
  }

  return true;
}

List<Vector2> _getVertices(Rect rect, double angle) {
  Vector2 center = Vector2(rect.center.dx, rect.center.dy);
  List<Vector2> vertices = [
    Vector2(rect.left, rect.top),
    Vector2(rect.right, rect.top),
    Vector2(rect.right, rect.bottom),
    Vector2(rect.left, rect.bottom),
  ];
  for (int i = 0; i < vertices.length; i++) {
    vertices[i] -= center;
    vertices[i] = _rotateVector(vertices[i], angle);
    vertices[i] += center;
  }
  return vertices;
}

Vector2 _rotateVector(Vector2 vector, double angle) {
  Matrix2 matrix = Matrix2.rotation(angle);
  return matrix.transform(vector);
}
