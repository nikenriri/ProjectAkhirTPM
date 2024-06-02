import 'package:flutter/material.dart';
import 'package:projectakhir_tpm/api_data_source.dart';
import 'package:projectakhir_tpm/model/detail_model.dart';
import 'favorite.dart';

class CategoryDetailScreen extends StatefulWidget {
  final String mealId;

  const CategoryDetailScreen({Key? key, required this.mealId}) : super(key: key);

  @override
  _CategoryDetailScreenState createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  late Future<MealDetail> _futureMealDetail;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _futureMealDetail = ApiDataSource.instance.loadCategoryDetail(widget.mealId).then((data) {
      final mealDetail = MealDetail.fromJson(data['meals'][0]);
      isFavorite = FavoritePage.favoriteList.contains(mealDetail.strMeal);
      return mealDetail;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text("Meal Detail"),
        actions: [
          IconButton(
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.red),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: _buildMealDetailBody(),
    );
  }

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
      String message;

      if (isFavorite) {
        FavoritePage.favoriteList.add(widget.mealId);
        message = 'Meal added to favorites';
      } else {
        FavoritePage.favoriteList.remove(widget.mealId);
        message = 'Meal removed from favorites';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: Duration(seconds: 2),
        ),
      );
    });
  }

  Widget _buildMealDetailBody() {
    return FutureBuilder<MealDetail>(
      future: _futureMealDetail,
      builder: (BuildContext context, AsyncSnapshot<MealDetail> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingSection();
        } else if (snapshot.hasError) {
          return _buildErrorSection();
        } else if (snapshot.hasData) {
          return _buildSuccessSection(snapshot.data!);
        }
        return _buildErrorSection();
      },
    );
  }

  Widget _buildErrorSection() {
    return Center(
      child: Text(
        "Error occurred while loading data.",
        style: TextStyle(color: Colors.red),
      ),
    );
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(MealDetail meal) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(meal.strMealThumb, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meal.strMeal,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text("Category: ${meal.strCategory}"),
                SizedBox(height: 10),
                Text("Area: ${meal.strArea}"),
                SizedBox(height: 10),
                Text("Instructions:", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text(meal.strInstructions),
                SizedBox(height: 10),
                Text("Ingredients:", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                for (int i = 0; i < meal.ingredients.length; i++)
                  Text("${meal.ingredients[i]} - ${meal.measures[i]}"),
                SizedBox(height: 10),
                if (meal.strYoutube.isNotEmpty)
                  ElevatedButton(
                    onPressed: () {
                      // open youtube link
                    },
                    child: Text("Watch on YouTube"),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
