import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../providers/health_provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final health = context.watch<HealthProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Heal"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: health.resetDaily,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircularPercentIndicator(
              radius: 100,
              lineWidth: 15,
              percent: health.waterProgress,
              center: Text("${health.waterIntake} ml"),
              progressColor: Colors.blue,
              backgroundColor: Colors.grey.shade300,
              circularStrokeCap: CircularStrokeCap.round,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => health.addWater(250),
              child: const Text("Add 250ml"),
            ),
            const SizedBox(height: 30),
            LinearProgressIndicator(
              value: health.calorieProgress,
              minHeight: 10,
            ),
            const SizedBox(height: 10),
            Text("Calories: ${health.calorieIntake} kcal"),
            ElevatedButton(
              onPressed: () => health.addCalories(200),
              child: const Text("Add 200 kcal"),
            ),
          ],
        ),
      ),
    );
  }
}