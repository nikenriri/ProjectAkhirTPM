import 'package:flutter/material.dart';
import 'package:projectakhir_tpm/api_data_source.dart';
import 'package:projectakhir_tpm/model/list_model.dart'; // Sesuaikan dengan path model Meal
import 'package:projectakhir_tpm/pages/detailMeals.dart'; // Import halaman detail makanan

class ListMealsScreen extends StatefulWidget {
  final String category;

  const ListMealsScreen({Key? key, required this.category}) : super(key: key);

  @override
  State<ListMealsScreen> createState() => _ListMealsScreenState();
}

class _ListMealsScreenState extends State<ListMealsScreen> {
  late Future<List<Meal>> _futureMeals;
  List<Meal> _allMeals = [];
  List<Meal> _filteredMeals = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _futureMeals = ApiDataSource.instance.loadMeals(widget.category).then((data) {
      List<dynamic> mealsData = data['meals'];
      _allMeals = mealsData.map((meal) => Meal.fromJson(meal)).toList();
      _filteredMeals = _allMeals;
      return _allMeals;
    });
  }

  void _filterMeals(String query) {
    setState(() {
      _filteredMeals = _allMeals
          .where((meal) => meal.strMeal.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: _isSearching ? _buildSearchField() : Text("${widget.category} Meals"),
        actions: _buildAppBarActions(),
      ),
      body: _buildListMealsBody(),
    );
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            setState(() {
              _isSearching = false;
              _filteredMeals = _allMeals;
            });
          },
        ),
      ];
    } else {
      return [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            setState(() {
              _isSearching = true;
            });
          },
        ),
      ];
    }
  }

  Widget _buildSearchField() {
    return TextField(
      autofocus: true,
      decoration: const InputDecoration(
        hintText: 'Search meals...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white60),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: _filterMeals,
    );
  }

  Widget _buildListMealsBody() {
    return FutureBuilder<List<Meal>>(
      future: _futureMeals,
      builder: (BuildContext context, AsyncSnapshot<List<Meal>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error occurred while loading data."));
        } else if (snapshot.hasData) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns
              crossAxisSpacing: 10.0, // Spacing between columns
              mainAxisSpacing: 10.0, // Spacing between rows
            ),
            itemCount: _filteredMeals.length,
            itemBuilder: (context, index) {
              final meal = _filteredMeals[index];
              return _buildMealItem(meal);
            },
            padding: const EdgeInsets.all(10.0), // Padding around the grid
          );
        }
        return Center(child: Text("No data available."));
      },
    );
  }

  Widget _buildMealItem(Meal meal) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryDetailScreen(mealId: meal.idMeal),
          ),
        );
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Ensure image fills the column width
          children: [
            Expanded(
              child: Center(
                child: Image.network(
                  meal.strMealThumb,
                  fit: BoxFit.cover, // Ensure the image covers the space
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                meal.strMeal,
                textAlign: TextAlign.center, // Center the text
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
