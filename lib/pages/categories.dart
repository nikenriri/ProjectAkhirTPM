import 'package:flutter/material.dart';
import 'package:projectakhir_tpm/api_data_source.dart';
import 'package:projectakhir_tpm/model/list_model.dart';
import 'package:projectakhir_tpm/pages/meals.dart';

class ListCategoryScreen extends StatefulWidget {
  const ListCategoryScreen({Key? key}) : super(key: key);

  @override
  State<ListCategoryScreen> createState() => _ListCategoryScreenState();
}

class _ListCategoryScreenState extends State<ListCategoryScreen> {
  late Future<List<Category>> _futureCategories;

  @override
  void initState() {
    super.initState();
    _futureCategories = ApiDataSource.instance.loadCategories()
        .then((data) => List<Category>.from(data['categories']
        .map((category) => Category.fromJson(category))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text("Meal Categories"),
      ),
      body: _buildListCategoryBody(),
    );
  }

  Widget _buildListCategoryBody() {
    return FutureBuilder<List<Category>>(
      future: _futureCategories,
      builder: (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
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

  Widget _buildSuccessSection(List<Category> categories) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return _buildListItem(category);
      },
    );
  }

  Widget _buildListItem(Category category) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ListMealsScreen(category: category.strCategory),
          ),
        );
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(category.strCategoryThumb),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  category.strCategory,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(category.strCategoryDescription),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
