import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../services/storage_service.dart';
import '../services/notification_service.dart';

class HealthProvider extends ChangeNotifier {
  int waterIntake = 0;
  int calorieIntake = 0;

  int waterGoal = AppConstants.defaultWaterGoal;
  int calorieGoal = AppConstants.defaultCalorieGoal;

  HealthProvider() {
    _init();
  }

  Future<void> _init() async {
    waterIntake =
        await StorageService.getInt(AppConstants.waterKey);

    calorieIntake =
        await StorageService.getInt(AppConstants.calorieKey);

    waterGoal = await StorageService.getInt(
      AppConstants.waterGoalKey,
      defaultValue: AppConstants.defaultWaterGoal,
    );

    calorieGoal = await StorageService.getInt(
      AppConstants.calorieGoalKey,
      defaultValue: AppConstants.defaultCalorieGoal,
    );

    notifyListeners();
  }

  double get waterProgress =>
      (waterIntake / waterGoal).clamp(0.0, 1.0);

  double get calorieProgress =>
      (calorieIntake / calorieGoal).clamp(0.0, 1.0);

  Future<void> addWater(int amount) async {
    waterIntake += amount;
    await StorageService.saveInt(
        AppConstants.waterKey, waterIntake);
    notifyListeners();
  }

  Future<void> addCalories(int amount) async {
    calorieIntake += amount;
    await StorageService.saveInt(
        AppConstants.calorieKey, calorieIntake);
    notifyListeners();
  }

  Future<void> updateWaterGoal(int goal) async {
    waterGoal = goal;
    await StorageService.saveInt(
        AppConstants.waterGoalKey, goal);
    notifyListeners();
  }

  Future<void> updateCalorieGoal(int goal) async {
    calorieGoal = goal;
    await StorageService.saveInt(
        AppConstants.calorieGoalKey, goal);
    notifyListeners();
  }

  Future<void> resetDaily() async {
    waterIntake = 0;
    calorieIntake = 0;

    await StorageService.saveInt(AppConstants.waterKey, 0);
    await StorageService.saveInt(AppConstants.calorieKey, 0);

    notifyListeners();
  }

  void checkWaterReminder() {
    if (waterIntake < waterGoal) {
      NotificationService.showInstant(
        title: "Hydration Alert",
        body: "You are behind your water goal. Do 10 pushups.",
      );
    }
  }
}