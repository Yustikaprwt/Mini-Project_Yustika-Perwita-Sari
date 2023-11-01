import 'package:dio/dio.dart';

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
          'Authorization':
              'Bearer',
        },
      );

      final response = await _dio.post('completions', data: {
        "model": "gpt-3.5-turbo",
        "messages": [
          {
            "role": "system",
            "content":
                "Berikan saya 3 rekomendasi makeup dengan tipe kulit $skinType dan warna kulit $skinColor, berikan saya rekomendasi berdasarkan budget yang saya miliki $budget, berikan juga deskripsi produk beserta harganya"
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
