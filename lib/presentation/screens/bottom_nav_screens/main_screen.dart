import 'package:flutter/material.dart';
import 'package:safqa_app/data/models/category_model.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/chats_screen/chats_screen.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/favorite_screen/favorite_screen.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/home_screen/home_screen.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/more_screen/more_screen.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/widgets/custom_bottom_nav.dart';

class MainScreen extends StatefulWidget {
   MainScreen({super.key,});



  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const HomeScreen(),
    const FavoriteScreen(),
    const ChatsScreen(),
    const MoreScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomBottomNavBar(
          selectedIndex: _selectedIndex, onTap: _onItemTapped),
    );
  }
}
