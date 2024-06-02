import 'package:flutter/material.dart';
import 'package:projectakhir_tpm/pages/home.dart';
import 'package:projectakhir_tpm/pages/profile.dart';
import 'package:projectakhir_tpm/pages/login.dart';
import 'package:projectakhir_tpm/pages/sarankesan.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  PageController pageController = PageController();
  List<Widget> pages = [const HomePage(), const ProfilePage(), const SarankesanPage(), const LoginPage()];

  int selectedIndex = 0;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initPage();
  }

  Future<void> _initPage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    setState(() {
      selectedIndex = isLoggedIn ? 0 : 3;
    });
  }

  void onPageChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void onItemTapped(int selectedItems) {
    if (selectedItems == 3) {
      _logout();
    } else {
      pageController.jumpToPage(selectedItems);
    }
  }

  Future<void> _logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: pages,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        onTap: onItemTapped,
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_rounded,
                color: selectedIndex == 0 ? Colors.brown : Colors.grey,
              ),
              label: "Home"
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: selectedIndex == 1 ? Colors.brown : Colors.grey,
              ),
              label: "Profile"
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.list_alt_rounded,
                color: selectedIndex == 2 ? Colors.brown : Colors.grey,
              ),
              label: "Saran&Kesan"
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.logout_rounded,
              color: selectedIndex == 3 ? Colors.brown : Colors.grey,
            ),
            label: "Log out",
          ),
        ],
      ),
    );
  }
}
