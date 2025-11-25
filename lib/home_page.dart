import 'package:flutter/material.dart';
import 'custom_bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // deixei o botão central (game) como selecionado por padrão
  int _currentIndex = 2;

  void _onNavItemSelected(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (index == 4) {
      // perfil -> login
      Navigator.pushNamed(context, '/login');
    }

    // os outros índices ainda não fazem nada (tela em produção)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFFEFEFEF),
      body: const Center(
        child: Text(
          'Tela inicial (em produção)',
          style: TextStyle(fontSize: 18),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onItemSelected: _onNavItemSelected,
      ),
    );
  }
}
