import 'package:flutter/material.dart';
import 'recepie_detail_page.dart';

class FavoritesPage extends StatelessWidget {
  final List<Map<String, String>> favoriteRecipes = [
    {
      'name': 'Creamy Tomato Pasta',
      'image': 'assets/images/creamy_tomato_pasta.jpg',
      'prepTime': '20 mins'
    },
    {
      'name': 'Fresh Garden Salad',
      'image': 'assets/images/fresh_garden_salad.jpg',
      'prepTime': '10 mins'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        backgroundColor: const Color(0xFFF8F5F2),
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: favoriteRecipes.length,
        itemBuilder: (context, index) {
          final recipe = favoriteRecipes[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  recipe['image']!,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(Icons.food_bank, size: 30),
                ),
              ),
              title: Text(recipe['name']!),
              subtitle: Text('Prep Time: ${recipe['prepTime']}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RecipeDetailPage(recipeName: recipe['name']!),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
