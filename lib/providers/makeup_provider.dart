import 'package:flutter/material.dart';
import 'package:mini_project/service/makeup_recommendation.dart';

class MakeupRecommendationProvider extends ChangeNotifier {
  final MakeUpRecommendationService _service = MakeUpRecommendationService();
  Map<String, dynamic>? recommendation;

  Future<void> getRecommendations({
    required String skinTypes,
    required String skinColors,
    required String budgets,
  }) async {
    recommendation = await _service.getRecommendations(
      skinType: skinTypes,
      skinColor: skinColors,
      budget: budgets,
    );
    notifyListeners();
  }
}
