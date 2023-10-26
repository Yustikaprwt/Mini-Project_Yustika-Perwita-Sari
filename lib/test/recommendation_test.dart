import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_project/screens/recommendation_screen.dart';

void main() {
  testWidgets('UI Test RecommendationScreen', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: RecommendationScreen(
        responseData: const {
          'choices': [
            {
              'message': {'content': 'Recommendation 1'}
            },
            {
              'message': {'content': 'Recommendation 2'}
            }
          ],
        },
      ),
    ));

    final titleFinder = find.text('Recommendations');
    final recommendation1Finder = find.text('Recommendation 1');
    final recommendation2Finder = find.text('Recommendation 2');

    expect(titleFinder, findsOneWidget);
    expect(recommendation1Finder, findsOneWidget);
    expect(recommendation2Finder, findsOneWidget);
  });
}
