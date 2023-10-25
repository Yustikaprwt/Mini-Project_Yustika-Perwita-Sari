import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  CustomBottomNavigationBar(
      {required this.selectedIndex, required this.onItemTapped});

  Widget _buildIcon(IconData icon, String label, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xffEE6BCC) : Colors.white,
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(10),
          child: Icon(
            icon,
            color: isSelected ? Colors.white : const Color(0xffEE6BCC),
          ),
        ),
        if (isSelected)
          Text(
            label,
            style: const TextStyle(
              color: Color(0xffEE6BCC),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) {
        onItemTapped(index);
      },
      items: [
        BottomNavigationBarItem(
          icon: _buildIcon(Icons.home, 'Home', selectedIndex == 0),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: _buildIcon(Icons.favorite, 'Favorite', selectedIndex == 1),
          label: 'Favorite',
        ),
        BottomNavigationBarItem(
          icon: _buildIcon(Icons.chat_outlined, 'Chat AI', selectedIndex == 2),
          label: 'Chat AI',
        ),
        BottomNavigationBarItem(
          icon: _buildIcon(Icons.person, 'Profile', selectedIndex == 3),
          label: 'Profile',
        ),
      ],
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xffEE6BCC),
      unselectedItemColor: const Color(0xffEE6BCC),
    );
  }
}
