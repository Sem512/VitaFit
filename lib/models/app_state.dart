import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;

  ThemeMode get themeMode => _themeMode;
  bool get isDark => _themeMode == ThemeMode.dark;

  void toggleTheme() {
    _themeMode = isDark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}

class NutritionData {
  final int targetCalories;
  final int consumedCalories;
  final double proteinG;
  final double carbsG;
  final double fatG;
  final double proteinTarget;
  final double carbsTarget;
  final double fatTarget;
  final int waterGlasses;
  final int waterTarget;

  const NutritionData({
    this.targetCalories = 2400,
    this.consumedCalories = 553,
    this.proteinG = 89,
    this.carbsG = 210,
    this.fatG = 48,
    this.proteinTarget = 150,
    this.carbsTarget = 300,
    this.fatTarget = 58,
    this.waterGlasses = 5,
    this.waterTarget = 8,
  });

  int get remainingCalories => targetCalories - consumedCalories;
  double get calorieProgress => consumedCalories / targetCalories;
  double get proteinProgress => proteinG / proteinTarget;
  double get carbsProgress => carbsG / carbsTarget;
  double get fatProgress => fatG / fatTarget;
}

class WorkoutData {
  final String name;
  final String muscles;
  final String category;
  final String pr;
  final String program;
  final Color color;

  const WorkoutData({
    required this.name,
    required this.muscles,
    required this.category,
    required this.pr,
    required this.program,
    required this.color,
  });
}

class FoodItem {
  final String name;
  final String serving;
  final int calories;
  final double protein;
  final double carbs;
  final double fat;

  const FoodItem({
    required this.name,
    required this.serving,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
  });
}

class MockData {
  static const nutrition = NutritionData();

  static const workouts = [
    WorkoutData(name: 'Bench Press', muscles: 'Chest · Triceps · Shoulders', category: 'Push', pr: '132.5 kg 1RM', program: '4 × 8', color: Color(0xFFFF6B6B)),
    WorkoutData(name: 'Overhead Press', muscles: 'Shoulders · Triceps', category: 'Push', pr: '85 kg 1RM', program: '4 × 6', color: Color(0xFFFFA94D)),
    WorkoutData(name: 'Pull Ups', muscles: 'Back · Biceps', category: 'Pull', pr: '+25 kg weighted', program: '4 × 8', color: Color(0xFF74C0FC)),
    WorkoutData(name: 'Back Squat', muscles: 'Quads · Glutes · Core', category: 'Legs', pr: '160 kg 1RM', program: '5 × 5', color: Color(0xFF2ECC71)),
    WorkoutData(name: 'Deadlift', muscles: 'Hamstrings · Back · Glutes', category: 'Pull', pr: '200 kg 1RM', program: '3 × 5', color: Color(0xFFCC5DE8)),
    WorkoutData(name: 'Incline DB Press', muscles: 'Upper Chest · Delts', category: 'Push', pr: '45 kg × 10', program: '3 × 10', color: Color(0xFFFF6B6B)),
  ];

  static const breakfastItems = [
    FoodItem(name: 'Oatmeal w/ Berries', serving: '1 bowl · 300g', calories: 210, protein: 6, carbs: 42, fat: 4),
    FoodItem(name: 'Protein Shake', serving: '1 scoop · 30g', calories: 132, protein: 25, carbs: 4, fat: 2),
  ];

  static const lunchItems = [
    FoodItem(name: 'Grilled Chicken Breast', serving: '1 serving · 200g', calories: 211, protein: 44, carbs: 0, fat: 5),
  ];

  static const recentFoods = [
    FoodItem(name: 'Chicken Breast', serving: '200g · 211 kcal', calories: 211, protein: 44, carbs: 0, fat: 5),
    FoodItem(name: 'Oatmeal', serving: '100g · 68 kcal', calories: 68, protein: 2.4, carbs: 12, fat: 1.4),
    FoodItem(name: 'Eggs (2 large)', serving: '100g · 155 kcal', calories: 155, protein: 13, carbs: 1, fat: 11),
    FoodItem(name: 'Greek Yogurt', serving: '150g · 90 kcal', calories: 90, protein: 10, carbs: 7, fat: 0.5),
  ];

  static const weeklyCalories = [2350.0, 2100.0, 553.0, 2450.0, 2200.0, 0.0, 0.0];
  static const weeklyWeight = [79.2, 79.0, 78.8, 78.6, 78.5, 78.4, 78.4];
  static const weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  static const weeklyActivity = [0.85, 0.60, 0.45, 0.90, 0.70, 0.0, 0.0];
}
