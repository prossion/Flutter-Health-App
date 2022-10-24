import 'package:flutter/material.dart';
import 'package:flutter_health_app/screens/achievments_screen.dart';
import 'package:flutter_health_app/screens/health_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(initialPage: 0);

  List<Widget> get pages => [
        const HealthScreen(),
        const AchievmentsScreen(),
      ];

  int _currentPageIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentPageIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              itemBuilder: (_, index) {
                return pages[index];
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.health_and_safety),
            label: 'Health',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_chart),
            label: 'Achievments',
          )
        ],
        currentIndex: _currentPageIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
