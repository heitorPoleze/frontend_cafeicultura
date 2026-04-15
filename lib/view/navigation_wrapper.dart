import 'package:flutter/material.dart';
import 'package:frontend_cafeicultura/components/custom_bottom_navigation.dart';
import 'package:frontend_cafeicultura/view/home_page.dart';
import 'package:frontend_cafeicultura/view/relatorio_financeiro_page.dart';

class NavigationWrapper extends StatefulWidget {
  const NavigationWrapper({super.key});

  @override
  State<NavigationWrapper> createState() => _NavigationWrapperState();
}

class _NavigationWrapperState extends State<NavigationWrapper> {
  int _selectedIndex = 2; 

  final List<Widget> _screens = [
    const RelatorioFinanceiroPage(),
    const Center(child: Text("Página Calendário")),
    const HomePage(),
    const Center(child: Text("Página Armazém")),
    const Center(child: Text("Página Funcionário")),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}