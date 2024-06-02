import 'package:flutter/material.dart';
import 'package:projectakhir_tpm/pages/currency.dart';
import 'package:projectakhir_tpm/pages/favorite.dart';
import 'package:projectakhir_tpm/pages/categories.dart';
import 'package:projectakhir_tpm/pages/profile.dart';
import 'package:projectakhir_tpm/pages/time.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // PageController pageController = PageController();
  // List<Widget> pages = [const HomePage()];
  //
  // int selectedIndex = 0;
  // void onPageChanged(int index) {
  //   setState(() {
  //     selectedIndex = index;
  //   });
  // }
  //
  // void onItemTapped(int selectedItems) {
  //   pageController.jumpToPage(selectedItems);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text('Dashboard'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.brown,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              minWidth: 200,
              height: 42,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ListCategoryScreen(),
                  ),
                );
              },
              color: Colors.brown,
              child: const Text(
                'Meals Categories',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 15),
            ),
            MaterialButton(
              minWidth: 200,
              height: 42,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoritePage(),
                  ),
                );
              },
              color: Colors.brown,
              child: const Text(
                'Favorite Meal',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 15),
            ),
            MaterialButton(
              minWidth: 200,
              height: 42,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CurrencyPage(),
                  ),
                );
              },
              color: Colors.brown,
              child: const Text(
                'Currency Conversion',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 15),
            ),
            MaterialButton(
              minWidth: 200,
              height: 42,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TimePage(),
                  ),
                );
              },
              color: Colors.brown,
              child: const Text(
                'Time Conversion',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 15),
            ),
          ],
        ),
      ),
    );
  }
}
