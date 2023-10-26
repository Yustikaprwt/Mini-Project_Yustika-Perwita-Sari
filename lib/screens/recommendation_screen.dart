import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecommendationScreen extends StatelessWidget {
  final Map<String, dynamic>? responseData;

  RecommendationScreen({Key? key, required this.responseData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recommendations',
          style: GoogleFonts.poppins(
            fontSize: 23,
            fontWeight: FontWeight.w600,
            color: const Color(0xffEE6BCC),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Center(
                child: Text(
              'This is your recommendation!',
              style: GoogleFonts.poppins(
                  fontSize: 15, fontWeight: FontWeight.w500),
            )),
            const SizedBox(height: 5),
            if (responseData != null && responseData!['choices'] != null)
              Column(
                children: responseData!['choices'].map<Widget>((choice) {
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        choice['message']['content'] ??
                            "No recommendation text available",
                        textAlign: TextAlign.justify,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                }).toList(),
              )
            else
              const Text("No recommendations available"),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
