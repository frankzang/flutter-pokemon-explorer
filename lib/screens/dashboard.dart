import 'package:flutter/material.dart';
import 'package:pokemon_explorer/screens/home_page.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(
      key: PageStorageKey("home"),
    ),
    Container(
      child: Center(child: Text("Favoritos")),
    )
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: this._pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        items: const [
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.home,
              color: Colors.redAccent,
            ),
            icon: Icon(
              Icons.home,
              color: Colors.black45,
            ),
            title: Text(
              'Home',
              style: TextStyle(color: Colors.black45),
            ),
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.favorite,
              color: Colors.redAccent,
            ),
            icon: Icon(
              Icons.favorite,
              color: Colors.black45,
            ),
            title: Text(
              'Favorites',
              style: TextStyle(color: Colors.black45),
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    ));
  }
}
