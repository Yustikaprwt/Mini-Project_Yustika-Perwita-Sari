import 'package:flutter/material.dart';
import 'package:mini_project/components/navigation_bar.dart';

class ChatRecommendation extends StatefulWidget {
  const ChatRecommendation({super.key});

  @override
  State<ChatRecommendation> createState() => _ChatRecommendationState();
}

class _ChatRecommendationState extends State<ChatRecommendation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [Text('hai')],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: 2,
          onItemTapped: (index) {
            if (index == 0) {
              Navigator.pushNamed(context, '/home');
            } else if (index == 1) {
              Navigator.pushNamed(context, '/favorite');
            } else if (index == 3) {
              Navigator.pushNamed(context, '/profile');
            }
          }),
    );
  }
}
