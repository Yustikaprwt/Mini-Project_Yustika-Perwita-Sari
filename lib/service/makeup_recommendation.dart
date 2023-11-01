import 'package:dio/dio.dart';
import 'package:mini_project/env/env.dart';

class MakeUpRecommendationService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>?> getRecommendations({
    required String skinType,
    required String skinColor,
    required String budget,
  }) async {
    try {
      _dio.options = BaseOptions(
        baseUrl: 'https://api.openai.com/v1/chat/',
        headers: {
          'Authorization': 'Bearer ${Env.apiKey}',
        },
      );

      final response = await _dio.post('completions', data: {
        "model": "gpt-3.5-turbo",
        "messages": [
          {
            "role": "system",
            "content":
                "Berikan saya 3 rekomendasi makeup dengan tipe kulit $skinType dan warna kulit $skinColor, berikan saya rekomendasi berdasarkan budget yang saya miliki $budget"
          },
        ]
      });

      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (error) {
      print('Error: $error');
    }
    return null;
  }
}
