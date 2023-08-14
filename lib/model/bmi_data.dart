import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ResultCategory {
  final double minRange;
  final double maxRange;
  final Color color;
  final String name;

  const ResultCategory(this.minRange, this.maxRange, this.color, this.name);
  bool inRange(double bmi) => bmi >= minRange && bmi < maxRange;
}

final resultCategories = [
  ResultCategory(
      double.negativeInfinity, 16.0, Colors.red[900]!, 'SEVERELY UNDERWEIGHT'),
  ResultCategory(16.0, 17, Colors.red[700]!, 'MODERATELY UNDERWEIGHT'),
  ResultCategory(16.0, 18.5, Colors.orange[300]!, 'UNDERWEIGHT'),
  ResultCategory(18.5, 25, Colors.green, 'NORMAL'),
  ResultCategory(25.0, 30, Colors.orange[300]!, 'OVERWEIGHT'),
  ResultCategory(30, 35, Colors.red[400]!, 'CLASS 1 OBESE'),
  ResultCategory(35, 40, Colors.red[700]!, 'CLASS 2 OBESE'),
  ResultCategory(40, double.infinity, Colors.red[900]!, 'CLASS 3 OBESE'),
];

class BMIData with ChangeNotifier {
  static const MAX_AGE = 140;
  static const MIN_AGE = 1;
  static const MIN_WEIGHT = 3;
  static const MAX_WEIGHT = 500;
  static const MIN_HEIGHT = 30;
  static const MAX_HEIGHT = 280;

  /// Height in cm
  int get height => _height;
  int _height = 170;
  void setHeight(int v) => n(() => _height = v.clamp(MIN_HEIGHT, MAX_HEIGHT));

  /// Weight in kg
  int get weight => _weight;
  int _weight = 75;
  void setWeight(int v) => n(() => _weight = v.clamp(MIN_WEIGHT, MAX_WEIGHT));

  /// Age in years
  int get age => _age;
  int _age = 20;
  void setAge(int v) => n(() => _age = v.clamp(MIN_AGE, MAX_AGE));

  /// Gender
  Gender get gender => _gender;
  Gender _gender = Gender.female;
  void setGender(Gender v) => n(() => _gender = v);

  void n(VoidCallback v) {
    v();
    notifyListeners();
  }

  /// Returns the calculated BMI
  double get bmi => weight / pow(height / 100.0, 2);

  /// Returns the BMI result category
  ResultCategory get category {
    var b = bmi;
    return resultCategories.firstWhere((c) => c.inRange(b));
  }
}

enum Gender { male, female }