import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onItemSelected;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onItemSelected,
  });

  static const _primaryGreen = Color(0xFF1FA34A);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Barra branca de fundo
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    offset: Offset(0, -2),
                    color: Colors.black12,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _NavIcon(
                    icon: Icons.home_outlined,
                    index: 0,
                    currentIndex: currentIndex,
                    onTap: onItemSelected,
                  ),
                  _NavIcon(
                    icon: Icons.bar_chart_outlined,
                    index: 1,
                    currentIndex: currentIndex,
                    onTap: onItemSelected,
                  ),
                  const SizedBox(width: 56), // espaço pro botão central
                  _NavIcon(
                    icon: Icons.chat_bubble_outline,
                    index: 3,
                    currentIndex: currentIndex,
                    onTap: onItemSelected,
                  ),
                  _NavIcon(
                    icon: Icons.person_outline,
                    index: 4,
                    currentIndex: currentIndex,
                    onTap: onItemSelected,
                  ),
                ],
              ),
            ),
          ),

          // Botão central (game)
          Positioned.fill(
            top: -12,
            child: Align(
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () => onItemSelected(2),
                child: Container(
                  height: 64,
                  width: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentIndex == 2 ? _primaryGreen : Colors.white,
                    border: Border.all(
                      color: _primaryGreen,
                      width: 3,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 8,
                        offset: Offset(0, 3),
                        color: Colors.black26,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.sports_esports,
                    color: currentIndex == 2 ? Colors.white : _primaryGreen,
                    size: 28,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  final IconData icon;
  final int index;
  final int currentIndex;
  final ValueChanged<int> onTap;

  static const _primaryGreen = Color(0xFF1FA34A);

  const _NavIcon({
    required this.icon,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = index == currentIndex;
    return InkWell(
      onTap: () => onTap(index),
      child: Icon(
        icon,
        size: 26,
        color: isSelected ? _primaryGreen : Colors.grey,
      ),
    );
  }
}
