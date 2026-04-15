import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF7B9374), // Verde da imagem
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.5),
        currentIndex: currentIndex,
        onTap: onTap,
        selectedFontSize: 12,
        unselectedFontSize: 11,
        // Efeito de destaque: Ícone maior quando selecionado
        selectedIconTheme: const IconThemeData(size: 32),
        unselectedIconTheme: const IconThemeData(size: 24),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: 'Financeiro',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Calendário',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.coffee_outlined), // Ícone representando o Café
            label: 'Café',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.warehouse_outlined),
            label: 'Armazém',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            label: 'Funcionário',
          ),
        ],
      ),
    );
  }
}